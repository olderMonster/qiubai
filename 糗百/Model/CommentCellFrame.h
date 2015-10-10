//
//  CommentCellFrame.h
//  糗百
//
//  Created by kehwa on 15/10/8.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "Comment.h"

@interface CommentCellFrame : NSObject

@property (nonatomic , strong)Comment *comment;

@property (nonatomic , assign)CGFloat cellHeight;

@property (nonatomic , assign)CGRect commentUserAvatarFrame;

@property (nonatomic , assign)CGRect commentUserNickNameFrame;

@property (nonatomic , assign)CGRect contentFrame;

@property (nonatomic , assign)CGRect commentCreateTimeFrame;

@property (nonatomic , assign)CGRect floorFrame;

+ (NSArray *)transformCommentModel:(NSArray *)commentList;

@end
