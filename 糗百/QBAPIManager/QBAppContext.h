//
//  QBAppContext.h
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QBAppContext : NSObject

//网络是否可达
@property (nonatomic , assign , readonly)BOOL isReachable;

+ (instancetype)sharedInstance;

@end
