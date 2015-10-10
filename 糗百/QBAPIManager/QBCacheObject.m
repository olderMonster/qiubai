//
//  QBCacheObject.m
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "QBCacheObject.h"

#import "QBNetworkingConfiguration.h"

@interface QBCacheObject()

@property (nonatomic , strong , readwrite)NSData *content;
@property (nonatomic , strong , readwrite)NSDate *lastUpdateTime;

@end

@implementation QBCacheObject

#pragma mark -- life cycle
- (instancetype)initWithContent:(NSData *)content{
    
    self = [super init];
    
    if (self) {
        
        self.content = content;
        
    }
    
    return self;
    
}


#pragma mark -- public method
- (void)updateContent:(NSData *)content{
    
    self.content = content;
    
}



#pragma mark -- getters and setters
- (BOOL)isEmpty{
    
    //为nil则证明为空
    return self.content == nil;
    
}


- (BOOL)isOutdated{
    
    //比较当前时间与上次存储时间是否间隔300s
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastUpdateTime];
    
    return timeInterval > kQBCacheOutdateTimeSeconds;
    
}

- (void)setContent:(NSData *)content{
    
    _content = [content copy];
    
    self.lastUpdateTime = [NSDate dateWithTimeIntervalSinceNow:0];
    
}

@end
