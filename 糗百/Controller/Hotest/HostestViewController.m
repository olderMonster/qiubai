//
//  HostestViewController.m
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "HostestViewController.h"

#import "JokeCell.h"

#import "MJRefresh.h"

#import "Utils.h"

#import "JokeCommentViewController.h"

@interface HostestViewController ()<UITableViewDataSource , UITableViewDelegate , JokeCellDelegate>

@property (nonatomic , strong)QBHostestApiManager *hostestApiManager;

@property (nonatomic , strong)NSMutableArray *hostestJokeMArray;


@property (nonatomic , strong)UITableView *jokeTableView;

@end

@implementation HostestViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationItem.title = @"最热";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.jokeTableView];
    
    [self addRefreshAction];
    
}

- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    
    self.jokeTableView.frame = self.view.bounds;
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
}

#pragma mark -- private method
- (void)addRefreshAction{
    
    self.jokeTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self.hostestApiManager refreshingAction:@selector(loadNewPage)];
    
    self.jokeTableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self.hostestApiManager refreshingAction:@selector(loadNextPage)];
    
    [self.jokeTableView.header beginRefreshing];
    
}


#pragma mark -- QBAPIManagerApiCallBackDelegate
//请求完成之后的回调
- (void)managerCallApiDidSuccess:(QBAPIBaseManager *)manager{
    
    NSDictionary *hostestjok = [self.hostestApiManager fetchDataWithReformer:nil];
    
    NSArray *jokeArray = [JokeCellFrame transformModel:hostestjok[@"items"]];
    
    if (self.hostestApiManager.isFirstPage) {
        
        self.hostestJokeMArray = [NSMutableArray arrayWithArray:jokeArray];
        
    }else{
        
        [self.hostestJokeMArray addObjectsFromArray:jokeArray];   
        
    }

    [self.jokeTableView reloadData];
    
}

- (void)managerCallApiDidFailed:(QBAPIBaseManager *)manager{
    
    
}

#pragma mark -- QBAPIManagerInterceptor
- (void)manager:(QBAPIBaseManager *)manager afterCallingAPIWithParams:(NSDictionary *)params{
    
    if (self.hostestApiManager.isFirstPage) {
        
        [self.jokeTableView.header endRefreshing];
        
    }else{
        
        [self.jokeTableView.footer endRefreshing];
        
    }
    
    
}

#pragma mark -- JokeCellDelegate
- (void)commentOperation:(NSString *)jokeId{
    
    self.tabBarController.tabBar.hidden = YES;
    
    JokeCommentViewController *commentVC = [[JokeCommentViewController alloc]init];
    
    commentVC.jokeId = jokeId;
    
    [self.navigationController pushViewController:commentVC animated:YES];
    
}



#pragma makr -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.hostestJokeMArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cell";
    
    JokeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        
        cell = [[JokeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        cell.delegate = self;
        
    }
    
    cell.jokeCellFrame = self.hostestJokeMArray[indexPath.row];
    
    return cell;
    
}


#pragma mark -- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JokeCellFrame *jokeCell = self.hostestJokeMArray[indexPath.row];
    
    return jokeCell.cellH;
    
}

#pragma mark -- getters and setters
- (QBHostestApiManager *)hostestApiManager{
    
    if (_hostestApiManager == nil) {
        
        _hostestApiManager = [[QBHostestApiManager alloc]init];
        
        _hostestApiManager.callbackDelegate = self;
        
        _hostestApiManager.interceptor = self;
        
    }
    
    return _hostestApiManager;
    
}

- (NSMutableArray *)hostestJokeMArray{
    
    if (_hostestJokeMArray == nil) {
        
        _hostestJokeMArray = [[NSMutableArray alloc]init];
        
    }
    
    return _hostestJokeMArray;
    
}

- (UITableView *)jokeTableView{
    
    if (_jokeTableView == nil) {
        
        _jokeTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _jokeTableView.backgroundColor = [UIColor whiteColor];
        
        _jokeTableView.dataSource = self;
        
        _jokeTableView.delegate = self;
        
        _jokeTableView.tableFooterView = [[UIView alloc]init];
        
        _jokeTableView.separatorColor = kColorRGB(249, 176, 86);
        
    }
    
    return _jokeTableView;
    
}

@end
