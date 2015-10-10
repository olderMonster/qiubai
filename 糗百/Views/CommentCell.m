//
//  CommentCell.m
//  糗百
//
//  Created by kehwa on 15/10/8.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "CommentCell.h"

#import "UIImageView+AFNetworking.h"

#import "QBNetworkingConfiguration.h"

@interface CommentCell()

@property (nonatomic , strong)UIImageView *commentUserAvatarImageView;

@property (nonatomic , strong)UILabel *commentUserNameLabel;

@property (nonatomic , strong)UILabel *commentCreateTimeLabel;

@property (nonatomic , strong)UILabel *commentContentLabel;

@property (nonatomic , strong)UILabel *commentFloorLabel;

@end

@implementation CommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self.contentView addSubview:self.commentUserAvatarImageView];
        
        [self.contentView addSubview:self.commentUserNameLabel];
        
        [self.contentView addSubview:self.commentCreateTimeLabel];
        
        [self.contentView addSubview:self.commentContentLabel];
        
//        [self.contentView addSubview:self.commentFloorLabel];
        
    }
    
    return self;
    
}

- (void)setCellFrame:(CommentCellFrame *)cellFrame{
    
    Comment *comment = cellFrame.comment;
    
    [self.commentUserAvatarImageView setImageWithURL:[NSURL URLWithString:comment.userAvatar] placeholderImage:[UIImage imageNamed:@"avatar.jpg"]];
    
    self.commentUserNameLabel.text = comment.userNickName;
    
    self.commentCreateTimeLabel.text = comment.commentCreateTime;
    
    self.commentContentLabel.text = comment.content;
    
    self.commentFloorLabel.text = comment.floor;
    
    
    self.commentUserAvatarImageView.frame = cellFrame.commentUserAvatarFrame;
    
    self.commentUserNameLabel.frame = cellFrame.commentUserNickNameFrame;
    
    self.commentCreateTimeLabel.frame = cellFrame.commentCreateTimeFrame;
    
    self.commentContentLabel.frame = cellFrame.contentFrame;
    
    self.commentFloorLabel.frame = cellFrame.floorFrame;
    
}


#pragma mark -- getters and setters
- (UIImageView *)commentUserAvatarImageView{
    
    if (_commentUserAvatarImageView == nil) {
        
        _commentUserAvatarImageView = [[UIImageView alloc]init];
        
    }
    
    return _commentUserAvatarImageView;
    
}

- (UILabel *)commentUserNameLabel{
    
    if (_commentUserNameLabel == nil) {
        
        _commentUserNameLabel = [[UILabel alloc]init];
        
        _commentUserNameLabel.backgroundColor = [UIColor whiteColor];
        
        _commentUserNameLabel.font = [UIFont systemFontOfSize:kCommentUserNameFont];
        
    }
    
    return _commentUserNameLabel;
    
}

- (UILabel *)commentCreateTimeLabel{
    
    if (_commentCreateTimeLabel == nil) {
        
        _commentCreateTimeLabel = [[UILabel alloc]init];
        
        _commentCreateTimeLabel.backgroundColor = [UIColor whiteColor];
        
        _commentCreateTimeLabel.font = [UIFont systemFontOfSize:kCommentTimeFont];
        
        _commentCreateTimeLabel.textColor = [UIColor grayColor];
        
    }
    
    return _commentCreateTimeLabel;
    
}

- (UILabel *)commentContentLabel{
    
    if (_commentContentLabel == nil) {
        
        _commentContentLabel = [[UILabel alloc]init];
        
        _commentContentLabel.backgroundColor = [UIColor whiteColor];
        
        _commentContentLabel.font = [UIFont systemFontOfSize:kCommentContentFont];
        
        _commentContentLabel.numberOfLines = 0;
        
        [_commentContentLabel sizeToFit];
        
    }
    
    return _commentContentLabel;
    
}

- (UILabel *)commentFloorLabel{
    
    if (_commentFloorLabel == nil) {
        
        _commentFloorLabel = [[UILabel alloc]init];
        
//        _commentFloorLabel.backgroundColor = [UIColor whiteColor];
        
        _commentFloorLabel.textColor = [UIColor grayColor];
        
        _commentFloorLabel.font = [UIFont systemFontOfSize:kCommentFloorFont];
        
    }
    
    return _commentFloorLabel;
    
}

@end
