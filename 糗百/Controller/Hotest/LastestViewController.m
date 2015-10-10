//
//  LastestViewController.m
//  糗百
//
//  Created by kehwa on 15/10/8.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "LastestViewController.h"

#import "Utils.h"

#import "QBLastestApiManager.h"

#import "MJRefresh.h"

#import "JokeCell.h"

#import "JokeCommentViewController.h"

@interface LastestViewController ()<UITableViewDataSource , UITableViewDelegate , QBAPIManagerInterceptor , QBAPIManagerApiCallBackDelegate>

@property (nonatomic , strong)UITableView *lastestTableView;

@property (nonatomic , strong)QBLastestApiManager *lastestApiManager;

@property (nonatomic , strong)NSMutableArray *lastestJokeMArray;

@end

@implementation LastestViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"最新";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.lastestTableView];
    
    [self addRefreshAction];
    
}

- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    self.lastestTableView.frame = self.view.bounds;
    
}


#pragma mark -- private method
- (void)addRefreshAction{
    
    self.lastestTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self.lastestApiManager refreshingAction:@selector(loadNewPage)];
    
    self.lastestTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self.lastestApiManager refreshingAction:@selector(loadNextPage)];
    
    [self.lastestTableView.header beginRefreshing];
    
}


#pragma mark -- QBAPIManagerApiCallBackDelegate
//请求完成之后的回调
- (void)managerCallApiDidSuccess:(QBAPIBaseManager *)manager{
    
    NSDictionary *tempDic = [manager fetchDataWithReformer:nil];
    
    NSArray *jokeArray = [JokeCellFrame transformModel:tempDic[@"items"]];
    
    if (self.lastestApiManager.isFirstPage) {
        
        self.lastestJokeMArray = [NSMutableArray arrayWithArray:jokeArray];
        
    }else{
        
        [self.lastestJokeMArray addObjectsFromArray:jokeArray];
        
    }
    
    [self.lastestTableView reloadData];
    
}
- (void)managerCallApiDidFailed:(QBAPIBaseManager *)manager{
    
    
    
}


#pragma mark -- QBAPIManagerInterceptor
- (void)manager:(QBAPIBaseManager *)manager afterCallingAPIWithParams:(NSDictionary *)params{
    
    if (self.lastestApiManager.isFirstPage) {
        
        [self.lastestTableView.header endRefreshing];
        
    }else{
        
        [self.lastestTableView.footer endRefreshing];
        
    }
    
}


#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.lastestJokeMArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cell";
    
    JokeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        
        cell = [[JokeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    cell.jokeCellFrame = self.lastestJokeMArray[indexPath.row];
    
    return cell;
    
}


#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JokeCellFrame *cellFrame = self.lastestJokeMArray[indexPath.row];
    
    return cellFrame.cellH;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JokeCellFrame *cellFrame = self.lastestJokeMArray[indexPath.row];
    
    JokeCommentViewController *commentVC = [[JokeCommentViewController alloc]init];
    
    commentVC.jokeId = cellFrame.joke.jokeId;
    
    [self.navigationController pushViewController:commentVC animated:YES];
    
}

#pragma mark -- getters and setters

- (QBLastestApiManager *)lastestApiManager{
    
    if (_lastestApiManager == nil) {
        
        _lastestApiManager = [[QBLastestApiManager alloc]init];
        
        _lastestApiManager.interceptor = self;
        
        _lastestApiManager.callbackDelegate = self;
        
    }
    
    return _lastestApiManager;
    
}

- (NSMutableArray *)lastestJokeMArray{
    
    if (_lastestJokeMArray == nil) {
        
        _lastestJokeMArray = [NSMutableArray array];
        
    }
    
    return _lastestJokeMArray;
    
}

- (UITableView *)lastestTableView{
    
    if (_lastestTableView == nil) {
        
        _lastestTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _lastestTableView.backgroundColor = [UIColor whiteColor];
        
        _lastestTableView.dataSource = self;
        
        _lastestTableView.delegate = self;
        
        _lastestTableView.tableFooterView = [[UIView alloc]init];
        
        _lastestTableView.separatorColor = kColorRGB(249, 176, 86);
        
    }
    
    return _lastestTableView;
    
}


@end
