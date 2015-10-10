//
//  QBCache.h
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface QBCache : NSObject

+ (instancetype)sharedInstance;

//存储需要缓存的数据
- (void)saveCacheWithData:(NSData *)cacheData
               methodName:(NSString *)methodName
            requestParams:(NSDictionary *)requestParams;

//获取缓存数据
- (NSData *)fetchCachedDataWithMethodName:(NSString *)methodName
                            requestParams:(NSDictionary *)requestParams;


//删除缓存数据
- (void)deleteCacheWithMethodName:(NSString *)methodName
                    requestParams:(NSDictionary *)requestParams;

//删除所有缓存
- (void)clean;

@end
