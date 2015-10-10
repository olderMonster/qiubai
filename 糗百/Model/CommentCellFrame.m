//
//  CommentCellFrame.m
//  糗百
//
//  Created by kehwa on 15/10/8.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "CommentCellFrame.h"

#import "Utils.h"

#import "QBNetworkingConfiguration.h"

@implementation CommentCellFrame

- (instancetype)initWithComment:(NSDictionary *)commentData{
    
    self = [super init];
    
    if (self) {
        
        self.comment = [[Comment alloc]initWithComment:commentData];
        
        self.commentUserAvatarFrame = CGRectMake(10, 10, 30, 30);
        
        CGSize floorSize = [self.comment.floor sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kCommentFloorFont]}];
        
        self.floorFrame = CGRectMake(kScreenWidth - 10 - floorSize.width, 10, floorSize.width, floorSize.height);
        
        self.commentUserNickNameFrame = CGRectMake(CGRectGetMaxX(self.commentUserAvatarFrame) + 10, 10, kScreenWidth - CGRectGetMaxX(self.commentUserAvatarFrame) - 20 - self.floorFrame.size.width, kCommentUserNameFont);
        
        self.commentCreateTimeFrame = CGRectMake(CGRectGetMaxX(self.commentUserAvatarFrame) + 10, CGRectGetMaxY(self.commentUserAvatarFrame) - kCommentTimeFont, self.commentUserNickNameFrame.size.width + self.floorFrame.size.width, kCommentTimeFont);
        
        CGRect contentRect = [self.comment.content boundingRectWithSize:CGSizeMake(kScreenWidth - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kCommentContentFont]} context:nil];
        
        self.contentFrame = CGRectMake(10, CGRectGetMaxY(self.commentUserAvatarFrame) + 10, kScreenWidth - 20, contentRect.size.height);
        
        self.cellHeight = CGRectGetMaxY(self.contentFrame) + 10;
        
    }
    
    return self;
    
}


+ (NSArray *)transformCommentModel:(NSArray *)commentList{
    
    NSMutableArray *tmpArr = [[NSMutableArray alloc]init];
    
    for (NSDictionary *tmp in commentList) {
        
        [tmpArr addObject:[[CommentCellFrame alloc]initWithComment:tmp]];
        
    }
    
    return tmpArr;
    
}

@end
