//
//  QBRequestGenerator.m
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "QBRequestGenerator.h"

#import "Utils.h"

#import "AFNetworking.h"

#import "QBNetworkingConfiguration.h"

@interface QBRequestGenerator()

@property (nonatomic , strong)AFHTTPRequestSerializer *httpRequestserializer;

@end

@implementation QBRequestGenerator

#pragma mark --life cycle

+ (instancetype)sharedInstance{
    
    static QBRequestGenerator *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[QBRequestGenerator alloc]init];
        
    });
    
    return sharedInstance;
    
}

#pragma makr -- public method
- (NSURLRequest *)generateGETRequestWithRequestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,methodName];
    
    NSMutableURLRequest *request = [self.httpRequestserializer requestWithMethod:@"GET" URLString:url parameters:requestParams error:NULL];
    
    return request;
    
}

- (NSURLRequest *)generatePOSTRequestWithRequestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",kBaseUrl,methodName];
    
    NSMutableURLRequest *request = [self.httpRequestserializer requestWithMethod:@"POST" URLString:url parameters:requestParams error:NULL];
    
    return request;
    
}


#pragma mark -- getters and setters
- (AFHTTPRequestSerializer *)httpRequestserializer{
    
    if (_httpRequestserializer == nil) {
        
        _httpRequestserializer = [[AFHTTPRequestSerializer alloc]init];
        
        _httpRequestserializer.timeoutInterval = kQBNetworkingTimeoutSeconds;
        
        _httpRequestserializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
        
    }
    
    return _httpRequestserializer;
    
}

@end
