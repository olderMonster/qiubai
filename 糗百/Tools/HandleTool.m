//
//  HandleTool.m
//  糗百
//
//  Created by kehwa on 15/9/30.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "HandleTool.h"

@implementation HandleTool

+ (NSString *)getAvatarUrlWithUseId:(NSString *)userId userIcon:(NSString *)userIcon{
    
    if (userId.length && userIcon.length) {
        
        return [NSString stringWithFormat:@"http://pic.qiushibaike.com/system/avtnew/%@/%@/medium/%@",[userId substringToIndex:userId.length - 4],userId,userIcon];
        
    }
    
    return @"";
    
}


+ (NSString *)getJokePictureUrlWithJokeId:(NSString *)jokeId image:(NSString *)image thumbnails:(BOOL)thumbnails{
    
    if (jokeId.length && image.length) {
        
        //medium
        
        NSString *type = thumbnails?@"small":@"medium";
        
        return [NSString stringWithFormat:@"http://pic.qiushibaike.com/system/pictures/%@/%@/%@/%@",[jokeId substringToIndex:jokeId.length - 4],jokeId,type,image];
        
    }
    
    return @"";
    
}

+ (NSString *)dateStringFromTimetamp:(NSString *)timeStamp{
    
    if ([timeStamp isEqualToString:@""]) {
        
        return @"";
        
    }
    
    double timeDouble = [timeStamp doubleValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:MM:ss";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeDouble];
    return [formatter stringFromDate:date];
}

@end
