//
//  JokeCellFrame.h
//  糗百
//
//  Created by kehwa on 15/9/30.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

#import "Joke.h"

@interface JokeCellFrame : NSObject

@property (nonatomic , strong)Joke *joke;

@property (nonatomic , assign)CGFloat cellH;

@property (nonatomic , assign)CGRect userAvatarFrame;

@property (nonatomic , assign)CGRect userNicknameFrame;

@property (nonatomic , assign)CGRect jokeTimeFrame;

@property (nonatomic , assign)CGRect contentFrame;

@property (nonatomic , assign)CGRect pictureFrame;

@property (nonatomic , assign)CGRect upButtonFrame;

@property (nonatomic , assign)CGRect downButtonFrame;

@property (nonatomic , assign)CGRect commentButtonFrame;

+ (NSArray *)transformModel:(NSArray *)jokeList;

@end
