//
//  Joke.h
//  糗百
//
//  Created by kehwa on 15/9/30.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface Joke : NSObject

@property (nonatomic , copy , readonly)NSString *jokeId;

@property (nonatomic , copy , readonly)NSString *votesDown;

@property (nonatomic , copy , readonly)NSString *votesUp;

@property (nonatomic , copy , readonly)NSString *commentsCount;

@property (nonatomic , copy , readonly)NSString *content;

@property (nonatomic , assign , readonly)BOOL hasUser;

@property (nonatomic , copy , readonly)NSString *userLastDevice;

@property (nonatomic , copy , readonly)NSString *createTime;

@property (nonatomic , copy , readonly)NSString *userNickname;

@property (nonatomic , copy , readonly)NSString *userId;

@property (nonatomic , copy , readonly)NSString *userIcon;

@property (nonatomic , assign , readonly)BOOL hasPicture;

@property (nonatomic , copy , readonly)NSString *image;

@property (nonatomic , assign , readonly)CGSize smallPicture;

@property (nonatomic , assign , readonly)CGSize mediumPicture;

- (instancetype)initWithJoke:(NSDictionary *)joke;

@end
