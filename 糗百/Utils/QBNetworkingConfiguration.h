//
//  QBNetworkingConfiguration.h
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#ifndef QBNetworkingConfiguration_h
#define QBNetworkingConfiguration_h

typedef NS_ENUM(NSUInteger, QBURLResponseStatus)
{
    QBURLResponseStatusSuccess, //作为底层，请求是否成功只考虑是否成功收到服务器反馈。至于签名是否正确，返回的数据是否完整，由上层的RTApiBaseManager来决定。
    QBURLResponseStatusErrorTimeout,  //超时
    QBURLResponseStatusErrorNoNetwork // 默认除了超时以外的错误都是无网络错误。
    
};

//请求超时时间
static NSTimeInterval kQBNetworkingTimeoutSeconds = 20.0f;

//缓存开关
static BOOL kQBShouldCache = YES;
static NSTimeInterval kQBCacheOutdateTimeSeconds = 300; // 5分钟的cache过期时间
static NSUInteger kQBCacheCountLimit = 1000;  //最多1000条cache

//jokeCell
static NSInteger kUserHandleFont = 15;
static NSInteger kUserNameFont = 15;
static NSInteger kUserJokeTimeFont = 13;
static NSInteger kUserJokeContentFont = 15;


//commentCell
static NSInteger kCommentUserNameFont = 13;
static NSInteger kCommentTimeFont = 12;
static NSInteger kCommentContentFont = 13;
static NSInteger kCommentFloorFont = 11;

#endif /* QBNetworkingConfiguration_h */
