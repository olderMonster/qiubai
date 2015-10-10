//
//  JokeCellFrame.m
//  糗百
//
//  Created by kehwa on 15/9/30.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "JokeCellFrame.h"

#import "Utils.h"

#import "QBNetworkingConfiguration.h"

@implementation JokeCellFrame

- (instancetype)initWithJoke:(NSDictionary *)jokeDic{
    
    self = [super init];
    
    if (self) {

        self.joke = [[Joke alloc] initWithJoke:jokeDic];
        
        CGFloat avatarS = 40;
        
        self.userAvatarFrame = CGRectMake(10, 10, avatarS, avatarS);
        
        self.userNicknameFrame = CGRectMake(CGRectGetMaxX(self.userAvatarFrame) + 10, self.userAvatarFrame.origin.y, kScreenWidth - CGRectGetMaxX(self.userNicknameFrame) - 20, kUserNameFont);
        
        self.jokeTimeFrame = CGRectMake(self.userNicknameFrame.origin.x, CGRectGetMaxY(self.userAvatarFrame) - kUserJokeTimeFont, self.userNicknameFrame.size.width, kUserJokeTimeFont);
        
        CGRect contentRect = [self.joke.content boundingRectWithSize:CGSizeMake(kScreenWidth - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kUserJokeContentFont]} context:nil];
        
        self.contentFrame = CGRectMake(10, CGRectGetMaxY(self.userAvatarFrame) + 10, contentRect.size.width, contentRect.size.height);
        
        
        if (self.joke.hasPicture) {
            
            self.pictureFrame = CGRectMake(10, CGRectGetMaxY(self.contentFrame) + 10, self.joke.smallPicture.width, self.joke.smallPicture.height);
            
        }else{
            
            self.pictureFrame = CGRectMake(0, CGRectGetMaxY(self.contentFrame), 0, 0);
            
        }
        
        CGFloat buttonW = kScreenWidth / 3;
        
        CGFloat buttonH = 30;
        
        self.upButtonFrame = CGRectMake(0, CGRectGetMaxY(self.pictureFrame) + 10, buttonW, buttonH);
        
        self.downButtonFrame = CGRectMake(CGRectGetMaxX(self.upButtonFrame), self.upButtonFrame.origin.y, self.upButtonFrame.size.width, self.upButtonFrame.size.height);
        
        self.commentButtonFrame = CGRectMake(CGRectGetMaxX(self.downButtonFrame), self.upButtonFrame.origin.y, self.upButtonFrame.size.width, self.upButtonFrame.size.height);
        
        
        self.cellH = CGRectGetMaxY(self.upButtonFrame);
        
    }
    
    return self;
    
}


+ (NSArray *)transformModel:(NSArray *)jokeList{
    
    NSMutableArray *tempJoke = [NSMutableArray array];
    
    for (NSDictionary *joke in jokeList) {
        
        JokeCellFrame *jokeModel = [[JokeCellFrame alloc]initWithJoke:joke];
        
        [tempJoke addObject:jokeModel];
        
    }
    
    return tempJoke;
    
}

@end
