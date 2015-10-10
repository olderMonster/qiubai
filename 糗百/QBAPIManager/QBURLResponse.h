//
//  QBURLResponse.h
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QBNetworkingConfiguration.h"

@interface QBURLResponse : NSObject

@property (nonatomic , assign , readonly)QBURLResponseStatus status;
@property (nonatomic , copy   , readonly)NSString *contentString;
@property (nonatomic , strong , readonly)id content;
@property (nonatomic , strong , readonly)NSURLRequest *request;
@property (nonatomic , assign , readonly)NSInteger requestId;
@property (nonatomic , strong , readonly)NSData *responseData;
@property (nonatomic , strong)NSDictionary *requestParams;
//判断QBURLResponse是否是由缓存中取得
@property (nonatomic , assign , readonly)BOOL isCache;

//请求成功
- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData status:(QBURLResponseStatus)status;

//请求失败
- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error;


// 使用initWithData的response，它的isCache是YES，上面两个函数生成的response的isCache是NO
- (instancetype)initWithData:(NSData *)data;

@end
