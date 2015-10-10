//
//  NSObject+QBNetworkingMethod.m
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "NSObject+QBNetworkingMethod.h"

@implementation NSObject (QBNetworkingMethod)

- (id)qb_defaultValue:(id)defaultData{
    
    if (![defaultData isKindOfClass:[self class]]) {
        
        return defaultData;
        
    }
    
    if ([self isEmptyObject]) {
        
        return defaultData;
        
    }
    
    return self;
    
}


- (BOOL)isEmptyObject{
    
    //空object
    if ([self isEqual:[NSNull class]]  || [self isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    //空字符串
    if ([self isKindOfClass:[NSString class]]) {
        
        if ([(NSString *)self length] == 0 || [(NSString *)self isEqualToString:@"null"]) {
            
            return YES;
            
        }
        
    }
    
    //空数组
    if ([self isKindOfClass:[NSArray class]]) {
        
        if ([(NSArray *)self count] == 0) {
            
            return YES;
            
        }
        
    }
    
    //空字典
    if ([self isKindOfClass:[NSDictionary class]]) {
        
        if ([(NSDictionary *)self allKeys].count == 0) {
            
            return YES;
            
        }
        
    }
    
    return NO;
    
}

@end
