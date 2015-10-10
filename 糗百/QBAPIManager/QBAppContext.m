//
//  QBAppContext.m
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "QBAppContext.h"

#import "AFNetworkReachabilityManager.h"

@implementation QBAppContext

#pragma mark -- life cycle
+ (instancetype)sharedInstance{
    
    static QBAppContext *sharedInsatnce = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        sharedInsatnce = [[QBAppContext alloc]init];
        
    });
    
    return sharedInsatnce;
    
}


#pragma mark -- getters and setters

- (BOOL)isReachable{
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        
        return YES;
        
    }else{
        
        return [AFNetworkReachabilityManager sharedManager].isReachable;
        
    }
    
}

@end
