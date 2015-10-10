//
//  QBCommentApiManager.h
//  糗百
//
//  Created by kehwa on 15/10/8.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "QBAPIBaseManager.h"

@interface QBCommentApiManager : QBAPIBaseManager<QBAPIManager , QBAPIManagerValidator>

@property (nonatomic , copy)NSString *jokeId;

@property (nonatomic , assign)BOOL isFirstPage;

- (void)loadNewPage;
- (void)loadNextPage;

@end
