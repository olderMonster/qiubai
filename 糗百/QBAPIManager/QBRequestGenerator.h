//
//  QBRequestGenerator.h
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QBRequestGenerator : NSObject

+ (instancetype)sharedInstance;

- (NSURLRequest *)generateGETRequestWithRequestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;

- (NSURLRequest *)generatePOSTRequestWithRequestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;

@end
