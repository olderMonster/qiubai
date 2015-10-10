//
//  MainViewController.m
//  糗百
//
//  Created by kehwa on 15/9/29.
//  Copyright © 2015年 kehwa. All rights reserved.
//

#import "MainViewController.h"

#import "HostestViewController.h"

#import "LastestViewController.h"

#import "TextPicViewController.h"

#import "Utils.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //导航栏背景颜色
    [[UINavigationBar appearance] setBarTintColor:kColorRGB16(0x067AB5)];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //返回按钮及文字颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UITabBar appearance] setTintColor:kColorRGB(249, 176, 86)];
    
    
    HostestViewController *hostestVC = [[HostestViewController alloc]init];
    
    UINavigationController *hostestNav = [[UINavigationController alloc]initWithRootViewController:hostestVC];
    
    hostestNav.tabBarItem.title = @"最热";
    
    
    LastestViewController *lastestVC = [[LastestViewController alloc]init];
    
    UINavigationController *lastestNav = [[UINavigationController alloc]initWithRootViewController:lastestVC];
    
    lastestNav.tabBarItem.title = @"最新";
    
    
    TextPicViewController *textpicVC = [[TextPicViewController alloc]init];
    
    UINavigationController *textpicNav = [[UINavigationController alloc]initWithRootViewController:textpicVC];
    
    textpicNav.tabBarItem.title = @"图文";
    
    
    NSArray *items = @[hostestNav,lastestNav,textpicNav];
    
    self.viewControllers = items;
}



@end
