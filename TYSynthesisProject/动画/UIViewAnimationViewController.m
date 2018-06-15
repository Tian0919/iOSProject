//
//  UIViewAnimationViewController.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/13.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "UIViewAnimationViewController.h"

@interface UIViewAnimationViewController ()
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) UIButton *marks;
@property (nonatomic, strong) UILabel *textLab;
@property (nonatomic, strong) UIView *animationView;
@property (nonatomic, strong) UIButton *sideBtn;
@property (nonatomic, strong) UIView *sideView;
@property (nonatomic, getter=isShowSide) BOOL showSide;
@end

@implementation UIViewAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *tipString = @"UIView 动画可以修改的属性有：frame,bounds,center,transfor,alpha,backgroundColor,contentStretch,通过这几个UIView.beginAnimations() -> UIView.commitAnimations() 和UIView.animateWithDuration()方法 配合上面的属性已经可以做出简单的动画效果，基本可以满足日常需求";
//
//
//    self.textLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, TYSCREENWIDTH, -200)];
//    self.textLab.numberOfLines = 0;
//    self.textLab.text = tipString;
//    self.textLab.backgroundColor = [UIColor redColor];
//    self.textLab.textColor = [UIColor whiteColor];
//    [self.view addSubview:self.textLab];

//    self.marks = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.marks.frame = CGRectMake(TYSCREENWIDTH-30,NavHeight + StatusbarHeight, 20, 40);
//    [self.marks setImage:[UIImage imageNamed:@"book"] forState:UIControlStateNormal];
//    [self.marks addTarget:self action:@selector(showText) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.marks];
    
    
    
    
    self.sideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sideBtn.bounds = CGRectMake(0, 0, 20, 20);
    self.sideBtn.center = CGPointMake(TYSCREENWIDTH-10, self.view.center.y);
    [self.sideBtn setImage:[UIImage imageNamed:@"side"] forState:UIControlStateNormal];
    [self.view addSubview:self.sideBtn];
    [self.sideBtn addTarget:self action:@selector(showSide) forControlEvents:UIControlEventTouchUpInside];
    
    self.sideView = [[UIView alloc]initWithFrame:CGRectMake(TYSCREENWIDTH, 0, 150, TYSCREENHEIGHT)];
    self.sideView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];

    [[UIApplication sharedApplication].keyWindow addSubview:self.sideView];
    
    
   
    
    
    
    _animationView = [[UIView alloc]initWithFrame:CGRectMake(10, TYSCREENWIDTH/ 2, 100, 100)];
    _animationView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_animationView];
}
//- (void)showText{
//
//    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//
//        CGRect labFrame = self.textLab.frame;
//        labFrame.origin.y = NavHeight + StatusbarHeight;
//        labFrame.size.height = 200;
//        self.textLab.frame = labFrame;
//
//
//        CGRect btnFrame = self.marks.frame;
//        btnFrame.origin.y = CGRectGetMaxY(self.textLab.frame);
//        self.marks.frame = btnFrame;
//
//        CGRect animationFrame = self.animationView.frame;
//        animationFrame.origin.y = CGRectGetMaxY(self.textLab.frame) + 50;
//        self.animationView.frame = animationFrame;
//
//    } completion:^(BOOL finished) {
//
//    }];
//
//}
- (void)showSide{
    
    if (!_showSide) {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGPoint newPoint = self.sideBtn.center;
            newPoint.x = TYSCREENWIDTH - 160;
            self.sideBtn.center = newPoint;
            
            CGRect sideViewFrame = self.sideView.frame;
            sideViewFrame.origin.x = TYSCREENWIDTH - 150;
            self.sideView.frame = sideViewFrame;
            
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.sideBtn.transform = CGAffineTransformMakeRotation(-M_PI);
            }];
            
        }];
    }else{
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            CGPoint newPoint = self.sideBtn.center;
            newPoint.x = TYSCREENWIDTH-10;
            self.sideBtn.center = newPoint;
            
            CGRect sideViewFrame = self.sideView.frame;
            sideViewFrame.origin.x = TYSCREENWIDTH;
            self.sideView.frame = sideViewFrame;
            
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.sideBtn.transform = CGAffineTransformMakeRotation(2*M_PI);
            }];
            
        }];
    }
    
    _showSide = !_showSide;
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        CGRect labFrame = self.textLab.frame;
        labFrame.origin.y = 0;
        labFrame.size.height = -200;
        self.textLab.frame = labFrame;
        
        
        CGRect btnFrame = self.marks.frame;
        btnFrame.origin.y = NavHeight + StatusbarHeight;
        self.marks.frame = btnFrame;
        
        CGRect animationFrame = self.animationView.frame;
        animationFrame.origin.y = TYSCREENWIDTH / 2;
        self.animationView.frame = animationFrame;
        
    } completion:^(BOOL finished) {
        
    }];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGPoint newPoint = self.sideBtn.center;
        newPoint.x = TYSCREENWIDTH-10;
        self.sideBtn.center = newPoint;
        
        CGRect sideViewFrame = self.sideView.frame;
        sideViewFrame.origin.x = TYSCREENWIDTH;
        self.sideView.frame = sideViewFrame;
        
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.sideBtn.transform = CGAffineTransformMakeRotation(2*M_PI);
        }];
        
    }];
}
- (NSString *)title{
    return @"UIView动画";
}


@end
