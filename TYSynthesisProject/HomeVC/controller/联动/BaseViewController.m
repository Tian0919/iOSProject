//
//  BaseViewController.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/12.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "BaseViewController.h"
#import "ExampleTableViewController.h"

@interface BaseViewController ()<UINavigationControllerDelegate>

@end

@implementation BaseViewController
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    NSLog(@"View Will Appear");
}
- (void)viewDidLoad {
    [super viewDidLoad];


    self.view.backgroundColor = [UIColor whiteColor];
    self.selectedColor = [UIColor blueColor];
    self.selectedIndex = 0;
    self.HideenNavBar = NO;
    self.ShowMore = YES;
    
  
    ExampleTableViewController *vc1 = [ExampleTableViewController new];
    vc1.title = @"推荐";
    
    ExampleTableViewController *vc2 = [ExampleTableViewController new];
    vc2.title = @"赛事";
    
    ExampleTableViewController *vc3 = [ExampleTableViewController new];
    vc3.title = @"直播";
    
    ExampleTableViewController *vc4 = [ExampleTableViewController new];
    vc4.title = @"NBA";
    
    ExampleTableViewController *vc5 = [ExampleTableViewController new];
    vc5.title = @"NCAA";
    
    ExampleTableViewController *vc6 = [ExampleTableViewController new];
    vc6.title = @"世界杯";
    
    ExampleTableViewController *vc7 = [ExampleTableViewController new];
    vc7.title = @"音乐";
    
    [self addChildViewController:vc1];
    [self addChildViewController:vc2];
    [self addChildViewController:vc3];
    [self addChildViewController:vc4];
    [self addChildViewController:vc5];
    [self addChildViewController:vc6];
    [self addChildViewController:vc7];
    
    
    
    
}

/*
https://api.k.sohu.com/api/channel/v7/list.go?activeChn=1020&apiVersion=42&bid=Y29tLnNvaHUubmV3c3BhcGVy&change=0&gid=010101110600010c766a57f628044bbb96c5b69946922f&isStartUp=1&local=0&p1=NjQxMzI3MDg5OTI2ODk1NjI1Nw%3D%3D&pid=-1&rt=json&sid=18&supportLive=1&supportWeibo=1&u=1&up=1%252C13557%252C2981%252C3%252C2%252C4%252C6%252C5%252C283%252C247%252C45%252C11%252C351%252C279%252C12%252C954509%252C98%252C50%252C16%252C177%252C248%252C49%252C359980%252C46%252C250%252C960377%252C25%252C960516&v=6.0.9
*/

@end
