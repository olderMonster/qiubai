//
//  HandleTool.h
//  糗百
//
//  Created by kehwa on 15/9/30.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HandleTool : NSObject

//获取用户头像url
+ (NSString *)getAvatarUrlWithUseId:(NSString *)userId userIcon:(NSString *)userIcon;

//获取用户发送的糗事图片
+ (NSString *)getJokePictureUrlWithJokeId:(NSString *)jokeId image:(NSString *)image thumbnails:(BOOL)thumbnails;

//将秒数转为时间
+ (NSString *)dateStringFromTimetamp:(NSString *)timeStamp;
@end
