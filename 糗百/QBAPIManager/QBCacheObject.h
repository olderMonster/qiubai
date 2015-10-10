//
//  QBCacheObject.h
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QBCacheObject : NSObject

@property (nonatomic , strong , readonly)NSData *content;
@property (nonatomic , strong , readonly)NSDate *lastUpdateTime;

@property (nonatomic , assign , readonly)BOOL isOutdated;
@property (nonatomic , assign , readonly)BOOL isEmpty;

- (instancetype)initWithContent:(NSData *)content;
- (void)updateContent:(NSData *)content;


@end
