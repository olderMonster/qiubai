//
//  JokeCell.m
//  糗百
//
//  Created by kehwa on 15/9/30.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "JokeCell.h"

#import "QBNetworkingConfiguration.h"

#import "HandleTool.h"

#import "UIImageView+AFNetworking.h"

@interface JokeCell()

@property (nonatomic , strong)UIImageView *avatarImageView;

@property (nonatomic , strong)UILabel *userNicknameLabel;

@property (nonatomic , strong)UILabel *contentLabel;

@property (nonatomic , strong)UILabel *timeLabel;

@property (nonatomic , strong)UIImageView *pictureImageView;

@property (nonatomic , strong)UIButton *upButton;

@property (nonatomic , strong)UIButton *downButton;

@property (nonatomic , strong)UIButton *commentButton;

@end

@implementation JokeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.avatarImageView];
        
        [self.contentView addSubview:self.userNicknameLabel];
        
        [self.contentView addSubview:self.timeLabel];
        
        [self.contentView addSubview:self.contentLabel];
        
        [self.contentView addSubview:self.pictureImageView];
        
        [self.contentView addSubview:self.upButton];
        
        [self.contentView addSubview:self.downButton];
        
        [self.contentView addSubview:self.commentButton];
        
    }
    
    return self;
    
}

#pragma mark -- event response
- (void)CommentAction{
    
    if ([self.delegate respondsToSelector:@selector(commentOperation:)]) {
        
        [self.delegate commentOperation:_jokeCellFrame.joke.jokeId];
        
    }
    
}


#pragma mark -- data source
- (void)setJokeCellFrame:(JokeCellFrame *)jokeCellFrame{
    
    _jokeCellFrame = jokeCellFrame;
    
    NSString *avatarUrl = [HandleTool getAvatarUrlWithUseId:jokeCellFrame.joke.userId userIcon:jokeCellFrame.joke.userIcon];
    [self.avatarImageView setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:[UIImage imageNamed:@"avatar.jpg"]];
    self.avatarImageView.frame = jokeCellFrame.userAvatarFrame;
    
    self.userNicknameLabel.text = jokeCellFrame.joke.userNickname;
    self.userNicknameLabel.frame = jokeCellFrame.userNicknameFrame;
    
    self.timeLabel.text = [HandleTool dateStringFromTimetamp:jokeCellFrame.joke.createTime];
    self.timeLabel.frame = jokeCellFrame.jokeTimeFrame;
    
    self.contentLabel.text = jokeCellFrame.joke.content;
    self.contentLabel.frame = jokeCellFrame.contentFrame;
    
    NSString *pictureUrl = [HandleTool getJokePictureUrlWithJokeId:jokeCellFrame.joke.jokeId image:jokeCellFrame.joke.image thumbnails:YES];
    
    [self.pictureImageView setImageWithURL:[NSURL URLWithString:pictureUrl]];
    self.pictureImageView.frame = jokeCellFrame.pictureFrame;
    
    [self.upButton setTitle:[NSString stringWithFormat:@"顶(%@)",jokeCellFrame.joke.votesUp] forState:UIControlStateNormal];
    self.upButton.frame = jokeCellFrame.upButtonFrame;
    
    [self.downButton setTitle:[NSString stringWithFormat:@"踩(%@)",jokeCellFrame.joke.votesDown] forState:UIControlStateNormal];
    self.downButton.frame = jokeCellFrame.downButtonFrame;
    
    [self.commentButton setTitle:[NSString stringWithFormat:@"评论(%@)",jokeCellFrame.joke.commentsCount] forState:UIControlStateNormal];
    self.commentButton.frame = jokeCellFrame.commentButtonFrame;
    
}


#pragma mark -- getters and setters
- (UIImageView *)avatarImageView{
    
    if (_avatarImageView == nil) {
        
        _avatarImageView = [[UIImageView alloc]init];
        
    }
    
    return _avatarImageView;
    
}

- (UILabel *)userNicknameLabel{
    
    if (_userNicknameLabel == nil) {
        
        _userNicknameLabel = [[UILabel alloc]init];
        
        _userNicknameLabel.backgroundColor = [UIColor whiteColor];
        
        _userNicknameLabel.font = [UIFont systemFontOfSize:kUserNameFont];
        
        _userNicknameLabel.textColor = [UIColor orangeColor];
        
    }
    
    return _userNicknameLabel;
    
}

- (UILabel *)timeLabel{
    
    if (_timeLabel == nil) {
        
        _timeLabel = [[UILabel alloc]init];
        
        _timeLabel.backgroundColor = [UIColor whiteColor];
        
        _timeLabel.textColor = [UIColor grayColor];
        
        _timeLabel.font = [UIFont systemFontOfSize:kUserJokeTimeFont];
        
    }
    
    return _timeLabel;
    
}

- (UILabel *)contentLabel{
    
    if (_contentLabel == nil) {
        
        _contentLabel = [[UILabel alloc]init];
        
        _contentLabel.backgroundColor = [UIColor whiteColor];
        
        _contentLabel.textColor = [UIColor blackColor];
        
        _contentLabel.font = [UIFont systemFontOfSize:kUserJokeContentFont];
        
        _contentLabel.numberOfLines = 0;
        
        [_contentLabel sizeToFit];
        
    }
    
    return _contentLabel;
    
}

- (UIImageView *)pictureImageView{
    
    if (_pictureImageView == nil) {
        
        _pictureImageView = [[UIImageView alloc]init];
        
    }
    
    return _pictureImageView;
    
}

- (UIButton *)upButton{
    
    if (_upButton == nil) {
        
        _upButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _upButton.backgroundColor = [UIColor whiteColor];
        
        _upButton.titleLabel.font = [UIFont systemFontOfSize:kUserHandleFont];
        
        [_upButton setTitle:@"顶" forState:UIControlStateNormal];
        
        [_upButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        
    }
    
    return _upButton;
    
}

- (UIButton *)downButton{
    
    if (_downButton == nil) {
        
        _downButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _downButton.backgroundColor = [UIColor whiteColor];
        
        _downButton.titleLabel.font = [UIFont systemFontOfSize:kUserHandleFont];
        
        [_downButton setTitle:@"踩" forState:UIControlStateNormal];
        
        [_downButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        
    }
    
    return _downButton;
    
}

- (UIButton *)commentButton{
    
    if (_commentButton == nil) {
        
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _commentButton.backgroundColor = [UIColor whiteColor];
        
        _commentButton.titleLabel.font = [UIFont systemFontOfSize:kUserHandleFont];
        
        [_commentButton setTitle:@"评论" forState:UIControlStateNormal];
        
        [_commentButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        
        [_commentButton addTarget:self action:@selector(CommentAction) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _commentButton;
    
}

@end
