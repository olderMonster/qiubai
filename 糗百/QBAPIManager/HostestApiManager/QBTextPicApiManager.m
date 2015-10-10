//
//  QBTextPicApiManager.m
//  糗百
//
//  Created by kehwa on 15/10/8.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "QBTextPicApiManager.h"

@interface QBTextPicApiManager()<QBAPIManager , QBAPIManagerValidator>

@property (nonatomic , assign)NSInteger page;

@end

@implementation QBTextPicApiManager

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
        self.validator = self;
        
    }
    
    return self;
    
}

#pragma mark -- public method
- (void)loadNewPage{
    
    self.isFirstPage = YES;
    
    self.page = 1;
    
    [self loadData];
    
}

- (void)loadNextPage{
    
    if (self.isLoading) {
        return;
    }
    
    self.isFirstPage = NO;
    
    [self loadData];
    
}

#pragma mark -- QBAPIManager
- (NSString *)methodName{
    
    return @"list/imgrank";
    
}

- (QBAPIManagerRequestType)requestType{
    
    return QBAPIManagerRequestTypeGet;
    
}

- (NSDictionary *)reformParams:(NSDictionary *)params{
    
    NSMutableDictionary *apiParams = [NSMutableDictionary dictionaryWithDictionary:params];
    
    apiParams[@"page"] = @(self.page);
    
    return apiParams;
    
}

- (void)beforePerformSuccessWithResponse:(QBURLResponse *)response{
    
    self.page ++;
    
}

#pragma mark -- QBAPIManagerValidator

//验证返回数据是否正确
- (BOOL)manager:(QBAPIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data{
    return YES;
    
}
//验证参数是否正确
- (BOOL)manager:(QBAPIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data{
    
    return YES;
    
}

@end
