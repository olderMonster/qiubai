//
//  JokeCell.h
//  糗百
//
//  Created by kehwa on 15/9/30.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JokeCellFrame.h"

@protocol JokeCellDelegate <NSObject>

- (void)commentOperation:(NSString *)jokeId;

@end

@interface JokeCell : UITableViewCell

@property (nonatomic , weak)id<JokeCellDelegate>delegate;

@property (nonatomic , strong)JokeCellFrame *jokeCellFrame;

@end
