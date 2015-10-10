//
//  QBApiProxy.m
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "QBApiProxy.h"

#import "AFNetworking.h"

#import "QBRequestGenerator.h"

@interface QBApiProxy()

@property (nonatomic , strong)NSMutableDictionary *dispatchTable;

@property (nonatomic , strong)NSNumber *recordedRequestId;

@property (nonatomic , strong)AFHTTPRequestOperationManager *operationManager;


@end

@implementation QBApiProxy

#pragma mark -- life cycle
+ (instancetype)sharedInstance{
    
    static QBApiProxy *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[QBApiProxy alloc]init];
        
    });
    
    return sharedInstance;
    
}


#pragma mark -- public method
- (NSInteger)callGETWithParams:(NSDictionary *)params methodName:(NSString *)methodName success:(QBCallBack)success failed:(QBCallBack)failed{
    
    NSURLRequest *request = [[QBRequestGenerator sharedInstance] generateGETRequestWithRequestParams:params methodName:methodName];
    
    NSNumber *requestId = [self callApiWithRequest:request success:success failed:failed];
    
    return [requestId integerValue];
    
}

- (NSInteger)callPOSTWithParams:(NSDictionary *)params methodName:(NSString *)methodName success:(QBCallBack)success failed:(QBCallBack)failed{
    
    NSURLRequest *request = [[QBRequestGenerator sharedInstance] generatePOSTRequestWithRequestParams:params methodName:methodName];
    
    NSNumber *requestId = [self callApiWithRequest:request success:success failed:failed];
    
    return [requestId integerValue];
    
}



//通过requestId找到对用的requestOperation取消请求
- (void)cancelRequestWithRequestId:(NSNumber *)requestId{
    
    NSOperation *requestOperation = self.dispatchTable[requestId];
    [requestOperation cancel];
    [self.dispatchTable removeObjectForKey:requestId];
    
}

//取消所有请求
- (void)cancelRequestWithRequestIdList:(NSArray *)requestIdList{
    
    for (NSNumber *requestId in requestIdList) {
        
        [self cancelRequestWithRequestId:requestId];
        
    }
    
}

#pragma mark -- private method
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(QBCallBack)success failed:(QBCallBack)failed{

    // 之所以不用getter，是因为如果放到getter里面的话，每次调用self.recordedRequestId的时候值就都变了，违背了getter的初衷
    NSNumber *requestId = [self generateRequestId];
    
    AFHTTPRequestOperation *httpRequestOperation = [self.operationManager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        AFHTTPRequestOperation *storedOperation = self.dispatchTable[requestId];
        
        if (storedOperation == nil) {
            
            return;
            
        }else{
            
            [self.dispatchTable removeObjectForKey:requestId];
            
        }
        
        QBURLResponse *response = [[QBURLResponse alloc]initWithResponseString:operation.responseString
                                                                     requestId:requestId
                                                                       request:operation.request
                                                                  responseData:operation.responseData
                                                                        status:QBURLResponseStatusSuccess];
        
        success?success(response):nil;
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        
        AFHTTPRequestOperation *storedOperation = self.dispatchTable[requestId];
        
        if (storedOperation == nil) {
            
            return;
            
        }else{
            
            [self.dispatchTable removeObjectForKey:requestId];
            
        }
        
        QBURLResponse *response = [[QBURLResponse alloc]initWithResponseString:operation.responseString
                                                                     requestId:requestId
                                                                       request:operation.request
                                                                  responseData:operation.responseData
                                                                         error:error];
        
        failed?failed(response):nil;
        
    }];
    
    //将发起的请求存续以便后续可以通过requestId找到当前的httpRequestOperation，并取消请求
    self.dispatchTable[requestId] = httpRequestOperation;
    
    [[self.operationManager operationQueue] addOperation:httpRequestOperation];
    
    return requestId;
    
}


- (NSNumber *)generateRequestId{
    
    if (_recordedRequestId == nil) {
        
        _recordedRequestId = @(1);
        
    }else{
        
        if ([_recordedRequestId integerValue] == NSIntegerMax) {
            
            _recordedRequestId = @(1);
            
        }else{
            
            _recordedRequestId = @([_recordedRequestId integerValue] + 1);
            
        }
        
    }
    
    return _recordedRequestId;
    
}


#pragma mark -- getters and setters
- (NSMutableDictionary *)dispatchTable{
    
    if (_dispatchTable == nil) {
        
        _dispatchTable = [[NSMutableDictionary alloc]init];
        
    }
    
    return _dispatchTable;
    
}

- (AFHTTPRequestOperationManager *)operationManager{
    
    if (_operationManager == nil) {
        
        _operationManager = [AFHTTPRequestOperationManager manager];
        
        _operationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    }
    
    return _operationManager;
    
}


@end
