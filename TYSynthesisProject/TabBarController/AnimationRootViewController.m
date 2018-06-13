//
//  AnimationRootViewController.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/12.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "AnimationRootViewController.h"
#import "UIViewAnimationViewController.h"
@interface AnimationRootViewController ()

@end

@implementation AnimationRootViewController

- (void)viewDidLoad{
    [super viewDidLoad];

    NSArray *btnName = @[@"UIView动画",@"CoreAnimation",@"帧动画",@"自定义转场"];
    CGFloat btnW = TYSCREENWIDTH * 0.6;
    CGFloat btnH = 44;

    
    for (NSInteger i = 0; i < btnName.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:btnName[i] forState:UIControlStateNormal];
        btn.frame = CGRectMake(TYSCREENWIDTH * 0.2, -100, btnW, btnH);
        CGFloat btnY = TYSCREENHEIGHT * (i * 0.1 + 0.2);
        
        [btn setTitleColor:[UIColor magentaColor] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor groupTableViewBackgroundColor];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn.tag = i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        [UIView animateWithDuration:0.8 delay:0.5 * i usingSpringWithDamping:10 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            btn.frame = CGRectMake(TYSCREENWIDTH * 0.2, btnY, btnW, btnH);
        } completion:nil];
        
        
    }
}
- (void)btnAction:(UIButton *)sender{
    if (sender.tag == 0) {
      
        [self.navigationController pushViewController:[UIViewAnimationViewController new] animated:YES];
    }
}

@end
