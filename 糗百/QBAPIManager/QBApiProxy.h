//
//  QBApiProxy.h
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "QBURLResponse.h"

typedef void(^QBCallBack)(QBURLResponse *response);

@interface QBApiProxy : NSObject

+ (instancetype)sharedInstance;

- (NSInteger)callGETWithParams:(NSDictionary *)params methodName:(NSString *)methodName success:(QBCallBack)success failed:(QBCallBack)failed;

- (NSInteger)callPOSTWithParams:(NSDictionary *)params methodName:(NSString *)methodName success:(QBCallBack)success failed:(QBCallBack)failed;


//取消请求
- (void)cancelRequestWithRequestId:(NSNumber *)requestId;
//取消所有请求
- (void)cancelRequestWithRequestIdList:(NSArray *)requestIdList;

@end
