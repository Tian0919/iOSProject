//
//  autoScrollerADView.h
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/14.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 轮播图图片点击Block
 */
typedef void(^adImageClickBlock)(NSInteger index);


@interface autoScrollerADView : UIView

/**
 图片数组
 */
@property (nonatomic, strong) NSArray *imageArr;

/**
 自动滚动时间间隔（默认为3秒）
 */
@property (nonatomic, assign) NSInteger scrollerTimeInterval;


/**
 pagecontrol指示颜色(默认LightGrayColor)
 */
@property (nonatomic, strong) UIColor *pageControlIndicatorColor;

/**
 pagecontrol当前颜色(默认WhiteColor)
 */
@property (nonatomic, strong) UIColor *pageControlCurrentColor;

/**
 图片点击回掉
 */
@property (nonatomic, copy) adImageClickBlock imageBlock;
- (void)startTimer;
- (void)invalidateTimer;
@end
