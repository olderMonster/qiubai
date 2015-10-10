//
//  QBAPIBaseManager.m
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "QBAPIBaseManager.h"

#import "QBCache.h"

#import "QBAppContext.h"

#import "QBApiProxy.h"


#define QBCallApi(REQUEST_METHOD,REQUEST_ID)                                           \
{                                                                                      \
    REQUEST_ID = [[QBApiProxy sharedInstance]call##REQUEST_METHOD##WithParams:apiParams methodName:self.child.methodName success:^(QBURLResponse *response) {                                           \
        [self successOnCallingAPI:response];                                            \
    } failed:^(QBURLResponse *response) {                                              \
        [self failedOnCallingAPI:response withErrorType:QBAPIManagerErrorTypeDefault]; \
    }];                                                                                \
    [self.requestIdList addObject:@(REQUEST_ID)];                                          \
}                                                                                      \


@interface QBAPIBaseManager()

@property (nonatomic , strong , readwrite)id fetchedRawData;

@property (nonatomic , readwrite)NSString *errorMessage;

@property (nonatomic , readwrite)QBAPIManagerErrorType errorType;

@property (nonatomic , strong)NSMutableArray *requestIdList;

@property (nonatomic , strong)QBCache *cache;

@end

@implementation QBAPIBaseManager

#pragma mark -- life cycle
- (instancetype)init{
    
    self = [super init];
    
    if (self) {
        
        _callbackDelegate = nil;
        _validator = nil;
        _paramsSource = nil;
        
        _fetchedRawData = nil;
        
        _errorMessage = nil;
        _errorType = QBAPIManagerErrorTypeDefault;
        
        
        if ([self conformsToProtocol:@protocol(QBAPIManager)]) {
            
            self.child = (id<QBAPIManager>)self;
            
        }
        
    }
    
    return self;
    
}

- (void)dealloc{
    
    [self cancelAllRequests];
    self.requestIdList = nil;
    
}

#pragma mark -- public method
//对数据进行处理
- (id)fetchDataWithReformer:(id<QBAPIManagerCallbackDataReformer>)reformer{
    
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(manager:reformData:)]) {
        resultData = [reformer manager:self reformData:self.fetchedRawData];
    }else{
        
        resultData = [self.fetchedRawData mutableCopy];
    }
    
    return resultData;
    
}

- (void)cancelAllRequests{
    
    [[QBApiProxy sharedInstance] cancelRequestWithRequestIdList:self.requestIdList];
    
    [self.requestIdList removeAllObjects];
    
}

- (void)cancelRequestWithRequestId:(NSInteger)requestId{
    
    [[QBApiProxy sharedInstance] cancelRequestWithRequestId:@(requestId)];
    
    [self removeRequestIdWithRequestId:requestId];
    
}

#pragma mark -- calling api
- (NSInteger)loadData{
    
    NSDictionary *params = [self.paramsSource paramsForApi:self];
    NSInteger requestId = [self loadDataWithParams:params];
    return requestId;
    
}


- (NSInteger)loadDataWithParams:(NSDictionary *)params{
    
    NSInteger requestId = 0;
    NSDictionary *apiParams = [self reformParams:params];
    //先判断是否需要进行API请求
    if ([self shouldCallAPIWithParams:apiParams]) {
        
        //判断参数是否符合规范
        if ([self.validator manager:self isCorrectWithParamsData:apiParams]) {
            
            //检查是否已经缓存
            if ([self shouldCache] && [self hasCacheWithParams:apiParams]) {
                [self afterCallingAPIWithParams:apiParams];
                return 0;
            }

            
            //网路可达
            if ([self isReachable]) {
                
                switch (self.child.requestType) {
                    case QBAPIManagerRequestTypeGet:
                        QBCallApi(GET, requestId);
                        break;
                    case QBAPIManagerRequestTypePost:
                        QBCallApi(POST, requestId);
                        break;
                        
                    default:
                        break;
                }
                
                
                NSMutableDictionary *params = [apiParams mutableCopy];
                params[kQBAPIBaseManagerRequestID] = @(requestId);
                [self afterCallingAPIWithParams:params];
                return requestId;
                
                
            }else{
                
                [self failedOnCallingAPI:nil withErrorType:QBAPIManagerErrorTypeNoNetWork];
                return requestId;
                
            }
            
            
        }else{
            
            [self failedOnCallingAPI:nil withErrorType:QBAPIManagerErrorTypeParamsError];
            
            return requestId;
            
        }
        
    }
    
    return requestId;
    
}



#pragma mark -- api callbacks
- (void)successOnCallingAPI:(QBURLResponse *)response{
    
    if (response.content) {
        
        self.fetchedRawData = [response.content copy];
        
    }else{
        
        [self failedOnCallingAPI:response withErrorType:QBAPIManagerErrorTypeTimeout];
        
    }
    
    [self removeRequestIdWithRequestId:response.requestId];
    
    if ([self.validator manager:self isCorrectWithCallBackData:response.content]) {
        
        //判断是否符合缓存条件
        if ([self shouldCache] && !response.isCache) {
            
            //进行缓存
            [self.cache saveCacheWithData:response.responseData methodName:self.child.methodName requestParams:response.requestParams];
            
        }
        
        
        [self beforePerformSuccessWithResponse:response];
        [self.callbackDelegate managerCallApiDidSuccess:self];
        [self afterPerformSuccessWithResponse:response];
        
    }
    
}

- (void)failedOnCallingAPI:(QBURLResponse *)response withErrorType:(QBAPIManagerErrorType)errorType{
    
    self.errorType = errorType;
    [self removeRequestIdWithRequestId:response.requestId];
    [self beforePerformFailWithResponse:response];
    [self.callbackDelegate managerCallApiDidFailed:self];
    [self afterPerformSuccessWithResponse:response];
    
}


#pragma mark - method for interceptor
- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params{
    
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:shouldCallAPIWithParams:)]) {
        
        return [self.interceptor manager:self shouldCallAPIWithParams:params];
        
    }else{
        
        return YES;
        
    }
    
}
- (void)afterCallingAPIWithParams:(NSDictionary *)params{
    
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterCallingAPIWithParams:)]) {
        
        [self.interceptor manager:self afterCallingAPIWithParams:params];
        
    }
    
}


- (void)beforePerformFailWithResponse:(QBURLResponse *)response{
    
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beformPerformFailWithResponse:)]) {
        
        [self.interceptor manager:self beformPerformFailWithResponse:response];
        
    }
    
}
- (void)afterPerformFailWithResponse:(QBURLResponse *)response{
    
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterPerformFailWithResponse:)]) {
        
        [self.interceptor manager:self afterPerformFailWithResponse:response];
        
    }
    
}


- (void)beforePerformSuccessWithResponse:(QBURLResponse *)response{
    
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:beformPerformSuccessWithResponse:)]) {
        
        [self.interceptor manager:self beformPerformSuccessWithResponse:response];
        
    }
    
}
- (void)afterPerformSuccessWithResponse:(QBURLResponse *)response{
    
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(manager:afterPerformSuccessWithResponse:)]) {
        
        [self.interceptor manager:self afterPerformSuccessWithResponse:response];
        
    }
    
}



#pragma mark -- private method
- (void)removeRequestIdWithRequestId:(NSInteger)requestId{
    
    NSNumber *requestIdToRemove = nil;
    
    for (NSNumber *storedRequestId in self.requestIdList) {
        
        if ([storedRequestId integerValue] == requestId) {
            
            requestIdToRemove = storedRequestId;
            
        }
        
    }
    
    if (requestIdToRemove) {
        
        [self.requestIdList removeObject:requestIdToRemove];
        
    }
    
}

- (BOOL)hasCacheWithParams:(NSDictionary *)params{
    
    NSString *methodName = self.child.methodName;
    
    NSData *result = [self.cache fetchCachedDataWithMethodName:methodName requestParams:params];
    
    if (result == nil) {
        
        return NO;
        
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{

        QBURLResponse *response = [[QBURLResponse alloc]initWithData:result];
        response.requestParams = params;
        [self successOnCallingAPI:response];
        
    });
    
    return YES;
    
}

#pragma mark - method for child
- (BOOL)shouldCache{
    
    return kQBShouldCache;
    
}

- (void)cleanData{
    
    IMP childIMP = [self.child methodForSelector:@selector(cleanData)];
    IMP selfIMP = [self methodForSelector:@selector(cleanData)];
    
    if (childIMP == selfIMP) {
        self.fetchedRawData = nil;
        self.errorMessage = nil;
        self.errorMessage = QBAPIManagerErrorTypeDefault;
    }else{
        if ([self.child respondsToSelector:@selector(cleanData)]) {
            [self.child cleanData];
        }
        
    }
    
}


//如果需要在调用API之前额外添加一些参数，比如pageNumber和pageSize之类的就在这里添加
//子类中覆盖这个函数的时候就不需要调用[super reformParams:params]了
- (NSDictionary *)reformParams:(NSDictionary *)params{
    
    IMP childIMP = [self.child methodForSelector:@selector(reformParams:)];
    IMP selfIMP = [self methodForSelector:@selector(reformParams:)];
    
    if (childIMP == selfIMP) {
        return params;
    } else {
        // 如果child是继承得来的，那么这里就不会跑到，会直接跑子类中的IMP。
        // 如果child是另一个对象，就会跑到这里
        NSDictionary *result = nil;
        result = [self.child reformParams:params];
        if (result) {
            return result;
        } else {
            return params;
        }
    }
    
}


#pragma mark -- getters and setters
- (NSMutableArray *)requestIdList{
    
    if (_requestIdList == nil) {
        
        _requestIdList = [[NSMutableArray alloc]init];
        
    }
    
    return _requestIdList;
    
}

- (QBCache *)cache{
    
    if (_cache == nil) {
        
        _cache = [QBCache sharedInstance];
        
    }
    
    return _cache;
    
}

- (BOOL)isReachable{
    
    BOOL isReachable = [QBAppContext sharedInstance].isReachable;
    
    if (!isReachable) {
        
        self.errorType = QBAPIManagerErrorTypeNoNetWork;
        
    }
    
    return isReachable;
    
}

- (BOOL)isLoading{
    
    return self.requestIdList.count > 0;
    
}
                           
@end
