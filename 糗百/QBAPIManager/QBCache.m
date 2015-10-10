//
//  QBCache.m
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "QBCache.h"

#import "QBNetworkingConfiguration.h"

#import "NSDictionary+QBNetworkingMethods.h"

#import "NSObject+QBNetworkingMethod.h"

#import "QBCacheObject.h"

@interface QBCache()

@property (nonatomic , strong)NSCache *cache;

@end


@implementation QBCache

#pragma mark -- life cycle

+ (instancetype)sharedInstance{
    
    static QBCache *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInstance = [[QBCache alloc]init];
        
    });
    
    return sharedInstance;
    
}

#pragma mark -- public method

//存储需要缓存的数据
- (void)saveCacheWithData:(NSData *)cacheData
               methodName:(NSString *)methodName
            requestParams:(NSDictionary *)requestParams{
    
    [self saveCacheWithData:cacheData key:[self keyWithMethodName:methodName requestParams:requestParams]];
    
}




//获取缓存数据
- (NSData *)fetchCachedDataWithMethodName:(NSString *)methodName
                            requestParams:(NSDictionary *)requestParams{
    
    return [self fetchCachedDataWithKey:[self keyWithMethodName:methodName requestParams:requestParams]];
    
}



//删除缓存数据
- (void)deleteCacheWithMethodName:(NSString *)methodName
                    requestParams:(NSDictionary *)requestParams{
    
    [self deleteCachedDataWithKey:[self keyWithMethodName:methodName requestParams:requestParams]];
    
}


//删除所有缓存
- (void)clean{
    
    [self.cache removeAllObjects];
    
}


//根据key存值
- (void)saveCacheWithData:(NSData *)cacheData key:(NSString *)key{
    
    QBCacheObject *cacheObject = [self.cache objectForKey:key];
    
    if (cacheObject == nil) {
        
        cacheObject = [[QBCacheObject alloc]init];
        
    }
    
    [cacheObject updateContent:cacheData];
    
    [self.cache setObject:cacheObject forKey:key];
    
}

//根据key取值
- (NSData *)fetchCachedDataWithKey:(NSString *)key{
    
    QBCacheObject *cacheObject = [self.cache objectForKey:key];

    if (cacheObject.isOutdated || cacheObject.isEmpty) {
        
        return nil;
        
    }else{
        
        return cacheObject.content;
        
    }
    
}

//根据key删除缓存
- (void)deleteCachedDataWithKey:(NSString *)key{
    
    [self.cache removeObjectForKey:key];
    
}




//生成存储时的key
- (NSString *)keyWithMethodName:(NSString *)methodName requestParams:(NSDictionary *)requestParams{
    
    return [NSString stringWithFormat:@"%@%@",methodName,[requestParams QB_urlParamsString]];
    
}

#pragma mark -- getters and setters

- (NSCache *)cache{
    
    if (_cache == nil) {
        
        _cache = [[NSCache alloc]init];
        
        _cache.countLimit = kQBCacheCountLimit;
        
    }
    
    return _cache;
    
}


@end
