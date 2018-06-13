//
//  UIViewAnimationViewController.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/13.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "UIViewAnimationViewController.h"

@interface UIViewAnimationViewController ()
@property (nonatomic, strong) UIView *animationView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger count;
@end

@implementation UIViewAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _count = 0;
    _animationView = [[UIView alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    _animationView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_animationView];
    
    NSArray *arr = @[@"Frame",@"Center",@"Transform",@"alpha",@"BackgroundColor"];
    NSInteger totalNumber = 4;
    CGFloat btnW = (TYSCREENWIDTH - 25) / totalNumber;
    CGFloat btnH = 44;
    CGFloat margin = 5;
    for (NSInteger i = 0; i < arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        NSInteger row = i / totalNumber;
        NSInteger col = i % totalNumber;
        CGFloat btnX = margin + col * (btnW + margin);
        CGFloat btnY = row * (btnH + margin);
        [btn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn.tag = i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn.frame = CGRectMake(0, TYSCREENHEIGHT + 100, TYSCREENWIDTH, 44);
        [UIView animateWithDuration:1.0 delay:0.4 * i usingSpringWithDamping:1.5 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            btn.frame = CGRectMake(btnX, TYSCREENHEIGHT - btnY - 74, btnW, btnH);
        } completion:nil];
    }
   
    
}
- (void)btnAction:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
            [self changeFrame];
            break;
        case 1:
            [self changeCener];
            break;
        case 2:
            [self changeTransform];
            break;
        case 3:
            [self changeAlpha];
            break;
        case 4:
            [self changeAlpha];
            break;
            
        default:
            break;
    }
}
- (void)changeFrame{
    
    
    [UIView animateWithDuration:0.5 animations:^{
         self.animationView.frame = CGRectMake(TYSCREENWIDTH-100, 100, 100, 100);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
              self.animationView.frame = CGRectMake(0, 100, 100, 100);
        } completion:nil];
    }];

}
- (void)changeCener{
    [UIView animateWithDuration:0.5 animations:^{
        CGPoint center = self.animationView.center;
        center.x = self.view.center.x;
        center.y =  self.view.center.y;
        self.animationView.center = center;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.animationView.frame = CGRectMake(0, 100, 100, 100);
        } completion:nil];
    }];
}
- (void)changeTransform{

    [UIView beginAnimations:@"imageViewTranslation" context:nil];
    [UIView setAnimationDuration:2.0];
    [UIView setAnimationDelegate:self];
//    [UIView setAnimationWillStartSelector:@selector(startAnimation)];
//    [UIView setAnimationDidStopSelector:@selector(stopAnimation)];
    [UIView setAnimationRepeatCount:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.animationView cache:YES];
    if (++_count % 2 ==0) {
        self.animationView.backgroundColor = [UIColor redColor];
    }else{
        self.animationView.backgroundColor = [UIColor greenColor];
    }
    [UIView commitAnimations];
    
   
    
    
}
- (void)changeAlpha{
    [UIView animateWithDuration:0.5 animations:^{
        self.animationView.alpha = 0.1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.animationView.alpha =1;
        }];
    }];
}
- (NSString *)title{
    return @"UIView动画";
}


@end
