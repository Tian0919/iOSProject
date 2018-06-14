//
//  LogViewController.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/14.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "LogViewController.h"
#import "TYRootViewController.h"
static const NSString *ItemStatusContext;
@interface LogViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *pswTF;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIButton *logBtn;
@property (nonatomic, assign) NSInteger currentPsw;
@property (nonatomic, strong) UILabel *showLabel;
@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setHidden:YES];
 
    [self setUI];
    _logBtn.enabled = NO;
    [_logBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
}
- (void)setUI{
    UIImageView *nameImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    nameImage.image = [UIImage imageNamed:@"name"];
    _nameTF = [[UITextField alloc]init];
    _nameTF.bounds = CGRectMake(0, 0, TYSCREENWIDTH * 0.8, 40);
    _nameTF.center = CGPointMake(self.view.center.x, self.view.center.y * 0.5);
    _nameTF.borderStyle = UITextBorderStyleRoundedRect;
    _nameTF.placeholder = @"登录名";
    _nameTF.returnKeyType = UIReturnKeyDone;
    _nameTF.leftView = nameImage;
    _nameTF.leftViewMode = UITextFieldViewModeAlways;
    _nameTF.delegate = self;
    [_logoImage addSubview:_nameTF];
    
    UIImageView *pswImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    pswImage.image = [UIImage imageNamed:@"psw"];
    
    UIButton *getCode = [UIButton buttonWithType:UIButtonTypeCustom];
    [getCode setTitle:@"获取密码" forState:UIControlStateNormal];
    getCode.titleLabel.font = [UIFont systemFontOfSize:13];
    getCode.frame = CGRectMake(10, 0, 80, 40);
    [getCode addTarget:self action:@selector(randomPsw) forControlEvents:UIControlEventTouchUpInside];
    [getCode setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    _pswTF = [[UITextField alloc]init];
    _pswTF.bounds = CGRectMake(0, 0, TYSCREENWIDTH * 0.8, 40);
    _pswTF.center = CGPointMake(self.view.center.x, self.view.center.y * 0.8);
    _pswTF.borderStyle = UITextBorderStyleRoundedRect;
    _pswTF.returnKeyType = UIReturnKeyDone;
    _pswTF.placeholder = @"密码";
    _pswTF.delegate = self;
    _pswTF.leftView = pswImage;
    _pswTF.rightView = getCode;
    _pswTF.rightViewMode = UITextFieldViewModeAlways;
    _pswTF.leftViewMode = UITextFieldViewModeAlways;
    _pswTF.keyboardType = UIKeyboardTypeNumberPad;
    _pswTF.secureTextEntry = YES;
//    [_pswTF addTarget:self action:@selector(textChnage:) forControlEvents:UIControlEventEditingChanged];
    
    [_logoImage addSubview:_pswTF];
    
    
    _showLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, -50, TYSCREENWIDTH, 50)];
    _showLabel.backgroundColor = [UIColor blueColor];
    _showLabel.textColor = [UIColor whiteColor];
    _showLabel.font = [UIFont systemFontOfSize:15];
    _showLabel.numberOfLines = 0;
    [self.view addSubview:_showLabel];
  
    
}

#pragma mark 生成随机登录密码
- (void)randomPsw{
    
   _currentPsw = arc4random() % 1000000-1;
  _showLabel.text = [NSString stringWithFormat:@"\n\n  您此次登录密码为---%zi",_currentPsw];
    [UIView animateWithDuration:0.5 animations:^{
        CGRect frame = self.showLabel.frame;
        frame.origin.y = 0;
        self.showLabel.frame = frame;
    } completion:^(BOOL finished) {
        sleep(3);
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = self.showLabel.frame;
            frame.origin.y = -50;
            self.showLabel.frame = frame;
        }];
    }];
  
}
#pragma mark 登录事件
- (IBAction)logAction:(UIButton *)sender {
    
    if ([_pswTF.text integerValue] == _currentPsw) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"mainRoot"];
        [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    }else{
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
        animation.keyPath = @"position.x";
        animation.values = @[ @0, @10, @-10, @10, @0 ];
        animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
        animation.duration = 0.4;
        animation.additive = YES;
        [_pswTF.layer addAnimation:animation forKey:@"shake"];
        _pswTF.text = @"";
    }
    
   

}
#pragma mark 输入框代理事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.view endEditing:YES];
    return YES;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
