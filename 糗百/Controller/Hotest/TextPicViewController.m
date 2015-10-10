//
//  TextPicViewController.m
//  糗百
//
//  Created by kehwa on 15/10/8.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "TextPicViewController.h"

#import "QBTextPicApiManager.h"

#import "MJRefresh.h"

#import "JokeCell.h"

#import "JokeCommentViewController.h"

@interface TextPicViewController ()<QBAPIManagerApiCallBackDelegate , QBAPIManagerInterceptor , UITableViewDataSource , UITableViewDelegate>

@property (nonatomic , strong)QBTextPicApiManager *textpicApiManager;

@property (nonatomic , strong)UITableView *textpicTableView;

@property (nonatomic , strong)NSMutableArray *textpicMArray;

@end

@implementation TextPicViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"图文";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.textpicTableView];
    
    [self.textpicApiManager loadData];
    
}

- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    self.textpicTableView.frame = self.view.bounds;
    
}

#pragma mark -- private method
- (void)addRefreshAction{
    
    self.textpicTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self.textpicApiManager refreshingAction:@selector(loadNewPage)];
    
    self.textpicTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self.textpicApiManager refreshingAction:@selector(loadNextPage)];
    
    [self.textpicTableView.header beginRefreshing];
    
}

#pragma mark -- QBAPIManagerApiCallBackDelegate
//请求完成之后的回调
- (void)managerCallApiDidSuccess:(QBAPIBaseManager *)manager{
    
    NSDictionary *tempDic = [manager fetchDataWithReformer:nil];
    
    NSArray *jokeArray = [JokeCellFrame transformModel:tempDic[@"items"]];
    
    if (self.textpicApiManager.isFirstPage) {
        
        self.textpicMArray = [NSMutableArray arrayWithArray:jokeArray];
        
    }else{
        
        [self.textpicMArray addObjectsFromArray:jokeArray];
        
    }
    
    [self.textpicTableView reloadData];
    
}

- (void)managerCallApiDidFailed:(QBAPIBaseManager *)manager{
    
    
}

#pragma mark -- QBAPIManagerInterceptor
- (void)manager:(QBAPIBaseManager *)manager afterCallingAPIWithParams:(NSDictionary *)params{
    
    
    
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.textpicMArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cell";
    
    JokeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        
        cell = [[JokeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    cell.jokeCellFrame = self.textpicMArray[indexPath.row];
    
    return cell;
    
}

#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JokeCellFrame *cellFrame = self.textpicMArray[indexPath.row];
    
    return cellFrame.cellH;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JokeCellFrame *cellFrame = self.textpicMArray[indexPath.row];
    
    JokeCommentViewController *commentVC = [[JokeCommentViewController alloc]init];
    
    commentVC.jokeId = cellFrame.joke.jokeId;
    
    [self.navigationController pushViewController:commentVC animated:YES];
    
}

#pragma mark -- getters and setters
- (QBTextPicApiManager *)textpicApiManager{
    
    if (_textpicApiManager == nil) {
        
        _textpicApiManager = [[QBTextPicApiManager alloc]init];
        
        _textpicApiManager.callbackDelegate = self;
        
        _textpicApiManager.interceptor = self;
        
    }
    
    return _textpicApiManager;
    
}

- (NSMutableArray *)textpicMArray{
    
    if (_textpicMArray == nil) {
        
        _textpicMArray = [[NSMutableArray alloc]init];
        
    }
    
    return _textpicMArray;
    
}


- (UITableView *)textpicTableView{
    
    if (_textpicTableView == nil) {
        
        _textpicTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _textpicTableView.backgroundColor = [UIColor whiteColor];
        
        _textpicTableView.dataSource = self;
        
        _textpicTableView.delegate = self;
        
        _textpicTableView.tableFooterView = [[UIView alloc]init];
        
    }
    
    return _textpicTableView;
    
}

@end
