//
//  CoreAnimationViewController.m
//  TestAnimation
//
//  Created by eeesysmini2 on 2018/2/27.
//  Copyright © 2018年 TMD. All rights reserved.
//

#import "CoreAnimationViewController.h"

@interface CoreAnimationViewController ()<CAAnimationDelegate>
@property (nonatomic, strong) CALayer *animationLayer;
@property (nonatomic, strong) CADisplayLink *animationLink;
@end

@implementation CoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _animationLayer = [CALayer new];
    _animationLayer.bounds = CGRectMake(0, 0, 100, 100);
    _animationLayer.position = self.view.center;
    _animationLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:_animationLayer];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"暂停" style:UIBarButtonItemStylePlain target:self action:@selector(animationPauseOrResume:)];
    
    NSArray *btnName = @[@"位移",@"缩放",@"透明度",@"圆角",@"旋转",@"弹簧效果",@"晃动"];
    
    NSInteger totalNumber = 5;
    CGFloat btnW = (self.view.frame.size.width - 30) / totalNumber;
    CGFloat btnH = 44;
    CGFloat margin = 5;
    
    for (NSInteger i = 0; i < btnName.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:btnName[i] forState:UIControlStateNormal];
        
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
        
        [UIView animateWithDuration:1.0 delay:0.4 * i usingSpringWithDamping:1.5 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            btn.frame = CGRectMake(btnX, btnY + 74, btnW, btnH);
        } completion:nil];
        
        
    }
    
    //    _animationLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkaction)];
    //    _animationLink.preferredFramesPerSecond = 30;
    //    [_animationLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
}
- (void)animationPauseOrResume:(UIBarButtonItem *)item{
    
    if ([item.title isEqualToString:@"暂停"]) {
        [item setTitle:@"恢复"];
        [self pauseAnimation];
    }else{
        [item setTitle:@"暂停"];
        [self resumeAnimation];
    }
    
}
- (void)btnAction:(UIButton *)sender{
    
    CABasicAnimation *animation = nil;
    
    switch (sender.tag) {
        case 0:
            animation = [CABasicAnimation animationWithKeyPath:@"position"];
            animation.byValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
            break;
        case 1:
            animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            animation.toValue = @(0.5);
            break;
        case 2:
            animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
            animation.toValue = @(0.1);
            break;
        case 3:
            animation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
            animation.toValue = @(50);//cornerRadius
            break;
        case 4:
            animation = [CABasicAnimation animationWithKeyPath:@"transform"];
            animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2, 0, 1, 1)];
            break;
        case 5:
            [self springAnimation];
            break;
        case 6:
            [self keypathRoationAnimaion];
            break;
        default:
            break;
    }
    
    animation.duration = 2.0;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.autoreverses = YES;
    [_animationLayer addAnimation:animation forKey:NSStringFromSelector(_cmd)];
}
//弹簧动画
- (void)springAnimation{
    
    CASpringAnimation *springAnimation = [CASpringAnimation animationWithKeyPath:@"position"];
    springAnimation.damping = 10;//阻尼系数（系数越大，停止越快）
    springAnimation.stiffness = 1200;//弹簧劲度系数(系数越大弹簧运动越快)
    springAnimation.mass = 1;//小球质量 影响惯性
    springAnimation.initialVelocity = 10;//初始速度
    springAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 500)];
    springAnimation.duration = springAnimation.stiffness;
    [_animationLayer addAnimation:springAnimation forKey:NSStringFromSelector(_cmd)];
    
    
}
- (void)keypathRoationAnimaion{
    
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    keyAnimation.duration = 0.3;
    //
    keyAnimation.values =  @[@(-(4) / 180.0*M_PI),@((4) / 180.0*M_PI),@(-(4) / 180.0*M_PI),@(4/(180*M_PI))];
    keyAnimation.repeatCount = MAXFLOAT;
    [_animationLayer addAnimation:keyAnimation forKey:@"transform.rotation"];
}
- (void)pauseAnimation{
    CFTimeInterval interval = [_animationLayer convertTime:CACurrentMediaTime() toLayer:nil];
    _animationLayer.timeOffset = interval;
    _animationLayer.speed = 0;
}
- (void)resumeAnimation{
    
    CFTimeInterval beginTime = CACurrentMediaTime() - _animationLayer.timeOffset;
    _animationLayer.beginTime = beginTime;
    _animationLayer.timeOffset = 0;
    _animationLayer.speed = 1;
    
}
@end
