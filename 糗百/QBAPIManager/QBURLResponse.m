//
//  QBURLResponse.m
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "QBURLResponse.h"

#import "NSObject+QBNetworkingMethod.h"

@interface QBURLResponse()

@property (nonatomic , assign , readwrite)QBURLResponseStatus status;
@property (nonatomic , copy   , readwrite)NSString *contentString;
@property (nonatomic , strong , readwrite)id content;
@property (nonatomic , strong , readwrite)NSURLRequest *request;
@property (nonatomic , assign , readwrite)NSInteger requestId;
@property (nonatomic , strong , readwrite)NSData *responseData;
@property (nonatomic , assign , readwrite)BOOL isCache;

@end


@implementation QBURLResponse

- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData status:(QBURLResponseStatus)status{
    
    self = [super init];
    
    if (self) {
        
        self.status = status;
        
        self.contentString = responseString;
        
        self.requestId = [requestId integerValue];
        
        self.request = request;
        
        self.responseData = responseData;
        
//        self.requestParams = request.requestParams;
        
        self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
        
        self.isCache = NO;
        
    }
    
    return self;
}


//请求失败
- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error{
    
    
    self = [super init];
    
    if (self) {
    
    self.status = [self responseStatusWithError:error];
    
    self.contentString = [responseString qb_defaultValue:@""];
    
    self.requestId = [requestId integerValue];
    
    self.request = request;
    
    self.responseData = responseData;
    
    self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:nil];
    
    self.isCache = NO;
        
        
    }
    
    return self;
    
}

- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        self.contentString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.status = [self responseStatusWithError:nil];
        self.requestId = 0;
        self.request = nil;
        self.responseData = [data copy];
        self.content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        self.isCache = YES;
    }
    return self;
}



#pragma mark -- private method
- (QBURLResponseStatus)responseStatusWithError:(NSError *)error{
    
    if (error) {
        
        QBURLResponseStatus status = QBURLResponseStatusErrorNoNetwork;
        
        //除了超时意外，所有错误都当成无网络
        if (error.code == NSURLErrorTimedOut) {
            
            status = QBURLResponseStatusErrorTimeout;
            
        }
        
        return status;
        
    }else{
        
        return QBURLResponseStatusSuccess;
        
    }
    
}
@end
