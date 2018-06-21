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
#import "ShowCityListViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "TCollectionViewController.h"
static NSString *kCellIdentifier = @"HomeCell";
@interface HomeRootViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property (nonatomic, strong) UITableView *homeTabView;
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property (nonatomic, strong) NSArray *homeDataArr;
@property (nonatomic, strong) UIButton *cityBtn;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSTimer *hhh;
@property (nonatomic, strong) autoScrollerADView *autoSroller;

@end

@implementation HomeRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _locationManager = [[CLLocationManager  alloc]init];
    _locationManager.delegate = self;
    
    CLAuthorizationStatus stauts = CLLocationManager.authorizationStatus;
    
    if (stauts == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestWhenInUseAuthorization];
    }else if (stauts == kCLAuthorizationStatusDenied || stauts == kCLAuthorizationStatusRestricted){
        NSLog(@"用户拒绝获取位置信息");
    };
    [_locationManager startUpdatingLocation];
    
    _homeDataArr = @[@"列表上下联动",@"CollectionView",@"XXXXX"];
    _homeTabView.tableFooterView = [UIView new];
    
    
    autoScrollerADView *autoscroller = [[autoScrollerADView alloc]initWithFrame:CGRectMake(0, NavHeight + StatusbarHeight, TYSCREENWIDTH, 200)];
    _autoSroller = autoscroller;
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
    self.cityBtn.frame = CGRectMake(0, StatusbarHeight + 10, 50, 30);
    self.cityBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.cityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cityBtn setTitle:@"未知" forState:UIControlStateNormal];
    [self.cityBtn setImage:[UIImage imageNamed:@"arrow_down"] forState:UIControlStateNormal];
    [self.cityBtn setImageEdgeInsets:UIEdgeInsetsMake(0,self.cityBtn.imageView.image.size.width, 0, 0)];
    
    [self.cityBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.cityBtn.bounds.size.width, 0, 0)];
    [self.cityBtn addTarget:self action:@selector(showAllCitys:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.cityBtn];
    
    
    
}
#pragma mark 跳转城市列表
- (void)showAllCitys:(UIButton *)sender{
    ShowCityListViewController *vc = [ShowCityListViewController new];
    vc.block = ^(NSString *name) {
        [self.cityBtn setTitle:name forState:UIControlStateNormal];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
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
    switch (indexPath.row) {
        case 0:
            {
                BaseViewController *baseVC = [BaseViewController new];
                baseVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:baseVC animated:YES];
            }
            break;
        case 1:
        {
            TCollectionViewController *vc = [TCollectionViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            
        default:
            break;
    }
   
}
#pragma mark 获取位置信息
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations{
    
    CLLocation *location = [locations lastObject];
    CLGeocoder *geoder = [CLGeocoder new];
    
    [geoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *plac = [placemarks firstObject];
        NSString *city = [plac.locality substringToIndex:NSMaxRange(NSMakeRange(0, plac.locality.length - 1))];
        [self.cityBtn setTitle:city forState:UIControlStateNormal];
        
    }];
    [_locationManager stopUpdatingLocation];
    NSLog(@"%@",location);
}
- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear: animated];
    [_autoSroller invalidateTimer];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_autoSroller startTimer];
}
@end
