//
//  TYNavigationViewController.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/13.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "TYNavigationViewController.h"

@interface TYNavigationViewController ()

@end

@implementation TYNavigationViewController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count == 1) {
        //解决在push时导航栏底色会有黑色一闪而过 (二选一)
        self.view.backgroundColor = [UIColor whiteColor];
//        self.navigationBar.translucent = NO;
        
        
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.view.backgroundColor = [UIColor whiteColor];
    }
    [super pushViewController:viewController animated:animated];
}
-(CGFloat)navHeight{
    return self.navigationBar.frame.size.height;
}
@end
