//
//  Comment.h
//  糗百
//
//  Created by kehwa on 15/10/8.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (nonatomic , copy)NSString *content;

@property (nonatomic , copy)NSString *commentId;

@property (nonatomic , copy)NSString *commentCreateTime;

@property (nonatomic , copy)NSString *userAvatar;

@property (nonatomic , copy)NSString *userId;

@property (nonatomic , copy)NSString *userNickName;

@property (nonatomic , copy)NSString *floor;

- (instancetype)initWithComment:(NSDictionary *)data;

@end
