//
//  QBAPIBaseManager.h
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QBURLResponse.h"

// 在调用成功之后的params字典里面，用这个key可以取出requestID
static NSString * const kQBAPIBaseManagerRequestID = @"kRTAPIBaseManagerRequestID";

@class QBAPIBaseManager;

/*************************************************************************************************/
/*                               QBAPIManagerApiCallBackDelegate                                 */
/*************************************************************************************************/
@protocol QBAPIManagerApiCallBackDelegate <NSObject>

@required
//请求完成之后的回调
- (void)managerCallApiDidSuccess:(QBAPIBaseManager *)manager;
- (void)managerCallApiDidFailed:(QBAPIBaseManager *)manager;

@end


/*************************************************************************************************/
/*                               QBAPIManagerCallbackDataReformer                                */
/*************************************************************************************************/
@protocol QBAPIManagerCallbackDataReformer <NSObject>

@required
//对请求到的数据进行处理
- (id)manager:(QBAPIBaseManager *)manager reformData:(NSDictionary *)data;

@end


/*************************************************************************************************/
/*                                     QBAPIManagerValidator                                     */
/*************************************************************************************************/

@protocol QBAPIManagerValidator <NSObject>

@required
//验证返回数据是否正确
- (BOOL)manager:(QBAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data;
//验证参数是否正确
- (BOOL)manager:(QBAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data;

@end


/*************************************************************************************************/
/*                                QBAPIManagerParamSourceDelegate                                */
/*************************************************************************************************/
@protocol QBAPIManagerParamSourceDelegate <NSObject>

@required
- (NSDictionary *)paramsForApi:(QBAPIBaseManager *)manager;

@end



//请求的结果
typedef NS_ENUM (NSUInteger,QBAPIManagerErrorType){
    QBAPIManagerErrorTypeDefault,       //没有产生过API请求，这个是manager的默认状态。
    QBAPIManagerErrorTypeSuccess,       //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    QBAPIManagerErrorTypeNoContent,     //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    QBAPIManagerErrorTypeParamsError,   //参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    QBAPIManagerErrorTypeTimeout,       //请求超时。RTApiProxy设置的是20秒超时，具体超时时间的设置请自己去看RTApiProxy的相关代码。
    QBAPIManagerErrorTypeNoNetWork      //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
};

//发起请求的类型,post/get...
typedef NS_ENUM (NSUInteger, QBAPIManagerRequestType){
    QBAPIManagerRequestTypeGet,
    QBAPIManagerRequestTypePost,
    QBAPIManagerRequestTypeRestGet,
    QBAPIManagerRequestTypeRestPost
};

/*************************************************************************************************/
/*                                         QBAPIManager                                          */
/*************************************************************************************************/
@protocol QBAPIManager <NSObject>

@required
- (NSString*)methodName;
//- (NSString *)serviceType;
- (QBAPIManagerRequestType)requestType;

@optional
- (void)cleanData;
- (NSDictionary *)reformParams:(NSDictionary *)params;
- (BOOL)shouldCache;

@end


/*************************************************************************************************/
/*                                    QBAPIManagerInterceptor                                    */
/*************************************************************************************************/
@protocol QBAPIManagerInterceptor <NSObject>

@optional
- (void)manager:(QBAPIBaseManager *)manager beformPerformSuccessWithResponse:(QBURLResponse *)response;
- (void)manager:(QBAPIBaseManager *)manager afterPerformSuccessWithResponse:(QBURLResponse *)response;


- (void)manager:(QBAPIBaseManager *)manager beformPerformFailWithResponse:(QBURLResponse *)response;
- (void)manager:(QBAPIBaseManager *)manager afterPerformFailWithResponse:(QBURLResponse *)response;


- (BOOL)manager:(QBAPIBaseManager *)manager shouldCallAPIWithParams:(NSDictionary *)params;
- (void)manager:(QBAPIBaseManager *)manager afterCallingAPIWithParams:(NSDictionary *)params;


@end


@interface QBAPIBaseManager : NSObject

@property (nonatomic , weak)id<QBAPIManagerApiCallBackDelegate>callbackDelegate;
@property (nonatomic , weak)id<QBAPIManagerParamSourceDelegate>paramsSource;
@property (nonatomic , weak)id<QBAPIManagerValidator>validator;
@property (nonatomic , weak)NSObject<QBAPIManager>*child;//里面会调用到NSObject的方法，所以这里不用id
@property (nonatomic , weak)id<QBAPIManagerInterceptor>interceptor;


@property (nonatomic , copy , readonly)NSString *errorMessage;
@property (nonatomic , readonly)QBAPIManagerErrorType errorType;

@property (nonatomic , assign , readonly)BOOL isReachable;
@property (nonatomic , assign , readonly)BOOL isLoading;

//调用其获取数据，并在该方法中调用QBAPIManagerCallbackDataReformer的方法对数据进行处理
- (id)fetchDataWithReformer:(id<QBAPIManagerCallbackDataReformer>)reformer;

//在child中调用其以发起请求，同时在该方法内部会通过param source来获取参数
- (NSInteger)loadData;

//取消请求
- (void)cancelAllRequests;
- (void)cancelRequestWithRequestId:(NSInteger)requestId;


// 拦截器方法，继承之后需要调用一下super
- (void)beforePerformSuccessWithResponse:(QBURLResponse *)response;
- (void)afterPerformSuccessWithResponse:(QBURLResponse *)response;

- (void)beforePerformFailWithResponse:(QBURLResponse *)response;
- (void)afterPerformFailWithResponse:(QBURLResponse *)response;

- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params;
- (void)afterCallingAPIWithParams:(NSDictionary *)params;

/*
 用于给继承的类做重载，在调用API之前额外添加一些参数,但不应该在这个函数里面修改已有的参数。
 子类中覆盖这个函数的时候就不需要调用[super reformParams:params]了
 RTAPIBaseManager会先调用这个函数，然后才会调用到 id<RTAPIManagerValidator> 中的 manager:isCorrectWithParamsData:
 所以这里返回的参数字典还是会被后面的验证函数去验证的。
 
 假设同一个翻页Manager，ManagerA的paramSource提供page_size=15参数，ManagerB的paramSource提供page_size=2参数
 如果在这个函数里面将page_size改成10，那么最终调用API的时候，page_size就变成10了。然而外面却觉察不到这一点，因此这个函数要慎用。
 
 这个函数的适用场景：
 当两类数据走的是同一个API时，为了避免不必要的判断，我们将这一个API当作两个API来处理。
 那么在传递参数要求不同的返回时，可以在这里给返回参数指定类型。
*/

- (NSDictionary *)reformParams:(NSDictionary *)params;
- (void)cleanData;
- (BOOL)shouldCache;

@end
