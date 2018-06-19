//
//  ShowCityListViewController.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/19.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "ShowCityListViewController.h"
#import "ShowListModel.h"
@interface ShowCityListViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property (nonatomic, strong) UITableView *listTableView;
@property (nonatomic, strong) NSArray *hotCityArr;
@property (nonatomic, strong) UIView *ktabHeader;
@property (nonatomic, strong) CLLocationManager *manager;
@property (nonatomic, copy) NSString *locationString;
@end

@implementation ShowCityListViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _manager = [CLLocationManager new];
    _manager.delegate = self;
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (status == kCLAuthorizationStatusNotDetermined) {
        [_manager requestWhenInUseAuthorization];
    }else if (status == kCLAuthorizationStatusRestricted || status == kCLAuthorizationStatusDenied){
        _locationString = @"无法获取位置信息，请在设置-隐私中打开位置权限";
    }
    [_manager startUpdatingLocation];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"X" style:UIBarButtonItemStylePlain target:self action:@selector(dismissVC)];
  
    
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"cityList.text"];
    NSArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (arr.count) {
        self.hotCityArr = arr;
        [self.listTableView reloadData];
    }else{
        [self getClicyList];
    }
    NSLog(@"%@",arr);
    
 
    
}
- (void)getClicyList{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSDictionary *dic = @{@"group":@"cn",
                          @"key":WeatherKey,
                          };
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:@"https://search.heweather.com/top?" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dic);
        
        NSArray *arr = [NSArray yy_modelArrayWithClass:[ShowListModel class] json:dic[@"HeWeather6"][0][@"basic"]];
        
        self.hotCityArr = arr;
        
        NSString *pathString = [NSTemporaryDirectory() stringByAppendingPathComponent:@"cityList.text"];
        
        [NSKeyedArchiver archiveRootObject: self.hotCityArr toFile:pathString];
        
        [self.view addSubview:self.listTableView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (void)dismissVC{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  section == 2 ? 10 : 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section == 1) {
        [cell.contentView addSubview:self.ktabHeader];
    }else if (indexPath.section == 0){
        cell.textLabel.text = self.locationString;
    }else{
         cell.textLabel.text = [NSString stringWithFormat:@"第%ld区 -----%ld",(long)indexPath.section,(long)indexPath.row];
    }
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath.section == 1 ? self.ktabHeader.frame.size.height : 44;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return @"当前城市";
            break;
        case 1:
            return @"热门城市";
        default:
            return @"";
            break;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [_manager requestWhenInUseAuthorization];
        if (self.block) {
            NSString *city = [self.locationString substringToIndex:NSMaxRange(NSMakeRange(0, self.locationString.length - 1))];
            self.block(city);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
    
    NSFileManager *manage = [NSFileManager defaultManager];
    NSString *path = [NSTemporaryDirectory() stringByAppendingPathComponent:@"cityList.text"];
    [manage removeItemAtPath:path error:nil];
    }
}
- (UITableView *)listTableView{
    if (!_listTableView) {
        _listTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        [self.view addSubview:_listTableView];
    }
    return _listTableView;
}
- (UIView *)ktabHeader{
    if (!_ktabHeader) {
        _ktabHeader = [[UIView alloc]initWithFrame:CGRectZero];
        _ktabHeader.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        for (NSInteger i = 0; i < self.hotCityArr.count; i++) {
            NSInteger col = i / 3;
            NSInteger row = i % 3;
            ShowListModel *model = self.hotCityArr[i];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:model.location forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            NSInteger btnW = (TYSCREENWIDTH-40) / 3;
            btn.frame = CGRectMake((row * btnW) + 25, col * 50 + 10, btnW-10, 40);
            btn.backgroundColor = [UIColor whiteColor];
            btn.clipsToBounds = YES;
            btn.layer.cornerRadius = 5;
            [_ktabHeader addSubview:btn];
            [btn addTarget:self action:@selector(chooseCity:) forControlEvents:UIControlEventTouchUpInside];
            _ktabHeader.frame = CGRectMake(0,0, TYSCREENWIDTH, CGRectGetMaxY(btn.frame) + 10);
        }
        
        
    }
    
    return _ktabHeader;
}
- (void)chooseCity:(UIButton *)sender{
    if (self.block) {
        self.block(sender.currentTitle);
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *placemark = [placemarks firstObject];
        self.locationString = placemark.locality;
        [self.listTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }];
    
  
    [_manager stopUpdatingLocation];
    
}
@end
