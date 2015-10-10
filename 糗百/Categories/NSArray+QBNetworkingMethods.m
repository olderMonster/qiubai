//
//  NSArray+QBNetworkingMethods.m
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "NSArray+QBNetworkingMethods.h"

@implementation NSArray (QBNetworkingMethods)

/** 字母排序之后形成的参数字符串 **/
- (NSString *)QB_paramsString{
    
    NSMutableString *paramString = [[NSMutableString alloc]init];
    
    NSArray *sortedParams =[self sortedArrayUsingSelector:@selector(compare:)];
    
    [sortedParams enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([paramString length] == 0) {
            
            [paramString appendFormat:@"%@",obj];
            
        }else{
            
            [paramString appendFormat:@"&%@",obj];
            
        }
        
        
    }];
    
    return paramString;
    
}

@end
