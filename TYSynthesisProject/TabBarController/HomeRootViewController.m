//
//  HomeRootViewController.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/12.
//  Copyright © 2018年 TianY. All rights reserved.
//
#import "HomeRootViewController.h"
#import "BaseViewController.h"
#import "autoScrollerADView.h"
static NSString *kCellIdentifier = @"HomeCell";
@interface HomeRootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *homeTabView;
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (nonatomic, strong) NSArray *homeDataArr;
@property (nonatomic, strong) UIButton *cityBtn;


@end

@implementation HomeRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _homeDataArr = @[@"列表上下联动",@"XXXX",@"XXXXX"];
    _homeTabView.tableFooterView = [UIView new];
    
    
    autoScrollerADView *autoscroller = [[autoScrollerADView alloc]initWithFrame:CGRectMake(0, NavHeight + StatusbarHeight, TYSCREENWIDTH, 200)];
    autoscroller.imageBlock = ^(NSInteger index) {
        
        UIAlertController *alCtr = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"您点击的是第%zi张图片",index] preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        [alCtr addAction:action1];
        [self presentViewController:alCtr animated:YES completion:nil];
    };
    [self.view addSubview:autoscroller];
    autoscroller.imageArr = @[@"0",@"1",@"2",@"3",@"4",@"5"];
    
    
    self.cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cityBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cityBtn setTitle:@"未知" forState:UIControlStateNormal];
    [self.cityBtn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
//    [self.cityBtn setImageEdgeInsets:UIEdgeInsetsMake(0,0, 0,  -self.cityBtn.titleLabel.frame.size.width)];
    
    [self.cityBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.cityBtn.imageView.frame.size.width-10, 0, 0)];
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.cityBtn];
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _homeDataArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = _homeDataArr[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BaseViewController *baseVC = [BaseViewController new];
    baseVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:baseVC animated:YES];
}

@end
