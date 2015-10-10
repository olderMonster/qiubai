//
//  Joke.m
//  糗百
//
//  Created by kehwa on 15/9/30.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "Joke.h"

#import "NSObject+QBNetworkingMethod.h"

@interface Joke()

@property (nonatomic , copy , readwrite)NSString *jokeId;

@property (nonatomic , copy , readwrite)NSString *votesDown;

@property (nonatomic , copy , readwrite)NSString *votesUp;

@property (nonatomic , copy , readwrite)NSString *commentsCount;

@property (nonatomic , copy , readwrite)NSString *content;

@property (nonatomic , assign , readwrite)BOOL hasUser;

@property (nonatomic , copy , readwrite)NSString *userLastDevice;

@property (nonatomic , copy , readwrite)NSString *createTime;

@property (nonatomic , copy , readwrite)NSString *userNickname;

@property (nonatomic , copy , readwrite)NSString *userId;

@property (nonatomic , copy , readwrite)NSString *userIcon;

@property (nonatomic , assign , readwrite)BOOL hasPicture;

@property (nonatomic , copy , readwrite)NSString *image;

@property (nonatomic , assign , readwrite)CGSize smallPicture;

@property (nonatomic , assign , readwrite)CGSize mediumPicture;

@end

@implementation Joke

- (instancetype)initWithJoke:(NSDictionary *)joke{
    
    self = [super init];
    
    if (self) {
        
        self.jokeId = [NSString stringWithFormat:@"%@",joke[@"id"]];
        
        self.votesUp = [NSString stringWithFormat:@"%@",joke[@"votes"][@"up"]];
        
        self.votesDown = [NSString stringWithFormat:@"%@",joke[@"votes"][@"down"]];
        
        self.commentsCount = [NSString stringWithFormat:@"%@",joke[@"comments_count"]];
        
        self.content = [NSString stringWithFormat:@"%@",joke[@"content"]];
        
        self.hasUser = ![joke[@"user"] isEmptyObject];
        
        self.userNickname = self.hasUser?joke[@"user"][@"login"]:@"匿名";
        
        self.userLastDevice = self.hasUser?joke[@"user"][@"last_device"]:@"";
        
        self.createTime = self.hasUser?[NSString stringWithFormat:@"%@",joke[@"user"][@"created_at"]]:@"";
        
        self.userId = self.hasUser?[NSString stringWithFormat:@"%@",joke[@"user"][@"id"]]:@"";
        
        self.userIcon = self.hasUser?joke[@"user"][@"icon"]:@"";
        
        self.hasPicture = ![joke[@"image"] isEmptyObject];
        
        self.image = self.hasPicture?joke[@"image"]:@"";
        
        //小图
        self.smallPicture = self.hasPicture?CGSizeMake([joke[@"image_size"][@"s"][0] floatValue], [joke[@"image_size"][@"s"][1] floatValue]):CGSizeMake(0, 0);
        
        //大图
        self.mediumPicture = self.hasPicture?CGSizeMake([joke[@"image_size"][@"m"][0] floatValue], [joke[@"image_size"][@"m"][1] floatValue]):CGSizeMake(0, 0);
        
    }
    
    return self;
    
}


@end
