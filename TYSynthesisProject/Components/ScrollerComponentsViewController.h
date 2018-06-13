//
//  ScrollerComponentsViewController.h
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/12.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollerComponentsViewController : UIViewController

/**
 选中字体颜色（默认红色）
 */
@property (nonatomic, strong) UIColor *selectedColor;

/**
 正常字体颜色(默认黑色)
 */
@property (nonatomic, strong) UIColor *normalColor;

/**
 是否添加下划线(默认NO)
 */
@property (nonatomic, getter=isShowUnderLine) BOOL ShowUnderLine;

/**
 选中标题Index（默认0）第一个
 */
@property (nonatomic, assign) NSInteger selectedIndex;

@end
