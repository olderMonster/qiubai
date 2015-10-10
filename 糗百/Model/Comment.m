//
//  Comment.m
//  糗百
//
//  Created by kehwa on 15/10/8.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "Comment.h"

#import "HandleTool.h"

@implementation Comment

@synthesize content;

@synthesize commentId;

@synthesize commentCreateTime;

@synthesize userAvatar;

@synthesize userId;

@synthesize userNickName;

@synthesize floor;

- (instancetype)initWithComment:(NSDictionary *)data{
    
    self = [super init];
    
    if (self) {
        
        self.content = data[@"content"];

        self.commentId = [NSString stringWithFormat:@"%@",data[@"id"]];
        
        
        NSString *createTime = [NSString stringWithFormat:@"%@",data[@"user"][@"created_at"]];
        
        self.commentCreateTime = [HandleTool dateStringFromTimetamp:createTime];

        
        self.userNickName = data[@"user"][@"login"];
        
        
        
        NSString *userIcon = data[@"user"][@"icon"];
        
        self.userId = [NSString stringWithFormat:@"%@",data[@"user"][@"id"]];
        
        self.userAvatar = [HandleTool getAvatarUrlWithUseId:self.userId userIcon:userIcon];
        
        
        self.floor = [NSString stringWithFormat:@"%@",data[@"floor"]];
        
    }
    
    return self;
    
}

@end
