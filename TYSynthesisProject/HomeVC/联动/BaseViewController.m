//
//  BaseViewController.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/12.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "BaseViewController.h"
#import "ExampleTableViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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



@end
