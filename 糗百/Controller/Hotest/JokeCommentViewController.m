//
//  JokeCommentViewController.m
//  糗百
//
//  Created by kehwa on 15/10/8.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "JokeCommentViewController.h"

#import "Utils.h"

#import "QBCommentApiManager.h"

#import "CommentCell.h"

#import "MJRefresh.h"

@interface JokeCommentViewController ()<QBAPIManagerInterceptor , QBAPIManagerApiCallBackDelegate , UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , strong)QBCommentApiManager *commentManager;

@property (nonatomic , strong)UITableView *commentTableView;

@property (nonatomic , strong)NSMutableArray *commentMArray;

@end

@implementation JokeCommentViewController

@synthesize jokeId;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"评论";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.commentTableView];
    
    [self addRefreshAction];
    
}

- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    self.commentTableView.frame = CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height + 49);
    
}

#pragma mark -- private method
- (void)addRefreshAction{
    
    self.commentTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self.commentManager refreshingAction:@selector(loadNewPage)];
    
    self.commentTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self.commentManager refreshingAction:@selector(loadNextPage)];
    
    [self.commentTableView.header beginRefreshing];
    
}


#pragma mark -- QBAPIManagerApiCallBackDelegate
//请求完成之后的回调
- (void)managerCallApiDidSuccess:(QBAPIBaseManager *)manager{
    
    NSDictionary *tempDic = [manager fetchDataWithReformer:nil];
    
    NSArray *tempArray = [CommentCellFrame transformCommentModel:tempDic[@"items"]];
    
    if (self.commentManager.isFirstPage) {
        
        self.commentMArray = [NSMutableArray arrayWithArray:tempArray];
        
    }else{
        
        [self.commentMArray addObjectsFromArray:tempArray];
        
    }
    
    
    
    [self.commentTableView reloadData];
    
}

- (void)managerCallApiDidFailed:(QBAPIBaseManager *)manager{
    
    
    
}

#pragma mark -- QBAPIManagerInterceptor
- (void)manager:(QBAPIBaseManager *)manager afterCallingAPIWithParams:(NSDictionary *)params{
    
    if (self.commentManager.isFirstPage) {
        
        [self.commentTableView.header endRefreshing];
        
    }else{
        
        [self.commentTableView.footer endRefreshing];
        
    }
    
}

#pragma makr -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.commentMArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cell";
    
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        
        cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    cell.cellFrame = self.commentMArray[indexPath.row];
    
    return cell;
    
}


#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentCellFrame *cellFrame = self.commentMArray[indexPath.row];
    
    return cellFrame.cellHeight;
    
}


#pragma mark -- getters and setters
- (QBCommentApiManager *)commentManager{
    
    if (_commentManager == nil) {
        
        _commentManager = [[QBCommentApiManager alloc]init];
        
        _commentManager.interceptor = self;
        
        _commentManager.callbackDelegate = self;
        
        _commentManager.jokeId = self.jokeId;
        
    }
    
    return _commentManager;
    
}


- (UITableView *)commentTableView{
    
    if (_commentTableView == nil) {
        
        _commentTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _commentTableView.backgroundColor = [UIColor whiteColor];
        
        _commentTableView.dataSource = self;
        
        _commentTableView.delegate = self;
        
        _commentTableView.tableFooterView = [[UIView alloc]init];
        
    }
    
    return _commentTableView;
    
}

@end
