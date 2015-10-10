//
//  NSDictionary+QBNetworkingMethods.m
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "NSDictionary+QBNetworkingMethods.h"

#import "NSArray+QBNetworkingMethods.h"

@implementation NSDictionary (QBNetworkingMethods)

/** 字符串前面是没有问号的，如果用于POST，那就不用加问号，如果用于GET就要加问号**/
- (NSString *)QB_urlParamsString{
    
    NSArray *sortedArray = [self QB_transformedUrlParamsArray];
    
    return [sortedArray QB_paramsString];
    
}

/** 转义参数 **/
- (NSArray *)QB_transformedUrlParamsArray{
    
    NSMutableArray *result = [[NSMutableArray alloc]init];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
       
        if (![obj isKindOfClass:[NSString class]]) {
            
            obj = [NSString stringWithFormat:@"%@",obj];
            
        }
        
        obj = [obj stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&;=+$,/?%#[]"]];
        
//        obj = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)obj, NULL, (CFStringRef)@"!*'();:@&;=+$,/?%#[]", kCFStringEncodingUTF8));
        
        if ([obj length] > 0) {
            
            [result addObject:[NSString stringWithFormat:@"%@=%@",key,obj]];
            
        }
        
    }];
    
    NSArray *sortedresult= [result sortedArrayUsingSelector:@selector(compare:)];
    
    return sortedresult;
    
}
@end
