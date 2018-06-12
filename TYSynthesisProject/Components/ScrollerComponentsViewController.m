//
//  ScrollerComponentsViewController.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/12.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "ScrollerComponentsViewController.h"

@interface ScrollerComponentsViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollerView;
@property (nonatomic, strong) UIScrollView *titleScrollerView;
@property (nonatomic, strong) NSMutableArray *titleWidthArr;
@property (nonatomic, assign) CGFloat totlaTitleWidth;
@property (nonatomic, strong) UILabel *selectedLab;
@end

@implementation ScrollerComponentsViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self cacluateWidths];
    [self AllTitles];
    [self contentVC:0];
}

- (NSMutableArray *)titleWidthArr{
    if (!_titleWidthArr) {
        _titleWidthArr = [NSMutableArray array];
    }
    return  _titleWidthArr;
}

#pragma mark 计算标题宽度
- (void)cacluateWidths{
    
    NSArray *titleArr = [self.childViewControllers valueForKey:@"title"];
    
    for (NSString *title in titleArr) {
        CGFloat tempW = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.width + 30;
        _totlaTitleWidth += tempW;
        [self.titleWidthArr addObject:@(tempW)];
    }
}
#pragma mark 设置顶部滚动标题
- (void)AllTitles{
    
    CGFloat labX = 0;
    CGFloat labW;
    
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UILabel *lab = [UILabel new];
        lab.text = self.childViewControllers[i].title;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.userInteractionEnabled = YES;
        lab.tag = i;
        lab.textColor = [UIColor blackColor];
        if (i ==0 ) {
            self.selectedLab = lab;
            self.selectedLab.textColor = [UIColor redColor];
        }
        
        if (_totlaTitleWidth < TYSCREENWIDTH) {
            labW = TYSCREENWIDTH / self.childViewControllers.count;
            lab.frame = CGRectMake(i * labW, 0, labW, 40);
        }else{
            labW = [self.titleWidthArr[i] floatValue];
            lab.frame = CGRectMake(labX, 0, labW, 40);
            labX += labW;
        }
        
        [self.titleScrollerView addSubview:lab];
        self.titleScrollerView.contentSize = CGSizeMake(CGRectGetMaxX(lab.frame), 0);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labClick:)];
        [lab addGestureRecognizer:tap];
        
    }
}
- (void)labClick:(UITapGestureRecognizer *)tap{
    
    [self.contentScrollerView scrollRectToVisible:CGRectMake(tap.view.tag * TYSCREENWIDTH, 0, TYSCREENWIDTH, self.contentScrollerView.frame.size.height) animated:NO];
    [self titleLabClick:tap.view.tag];
}
#pragma mark title点击
- (void)titleLabClick:(NSInteger)index{
    
    UILabel *clickLab = self.titleScrollerView.subviews[index];
    if (clickLab == self.selectedLab) {
        return;
    }
    
    [self setTitleScrollertoCenter:clickLab];
    
    clickLab.textColor = [UIColor redColor];
    self.selectedLab.textColor = [UIColor blackColor];
    self.selectedLab = clickLab;
}
#pragma mark 设置顶部title居中显示
- (void)setTitleScrollertoCenter:(UILabel *)lab{
    
    CGFloat offset = lab.center.x - TYSCREENWIDTH * 0.5;
    if (offset <= 0) {
        offset = 0;
    }
    
    CGFloat maxOffset = self.titleScrollerView.contentSize.width - TYSCREENWIDTH;
    
    if (offset > maxOffset) {
        offset = maxOffset;
    }
    [self.titleScrollerView setContentOffset:CGPointMake(offset, 0) animated:YES];
    
}
#pragma mark 设置内容
- (void)contentVC:(NSInteger)index{
    
    if (self.contentScrollerView.subviews.count - 1 < index || !self.contentScrollerView.subviews.count) {
        UIViewController *vc = self.childViewControllers[index];
        vc.view.frame = CGRectMake(index * TYSCREENWIDTH, 0, TYSCREENWIDTH, self.contentScrollerView.frame.size.height);
        [self.contentScrollerView addSubview:vc.view];
      
    }else{
        NSLog(@"已经存在了");
    }

}
#pragma mark ScrollerView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat offset = scrollView.contentOffset.x / TYSCREENWIDTH;
    [self contentVC:offset];
     [self titleLabClick:offset];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    NSInteger index = scrollView.contentOffset.x /  TYSCREENWIDTH;
    UILabel *lab = self.titleScrollerView.subviews[index];
    [self setTitleScrollertoCenter:lab];
    
}
#pragma mark 懒加载scrollerView
- (UIScrollView *)titleScrollerView{
    
    if (!_titleScrollerView) {
        _titleScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, TYSCREENWIDTH, 40)];
        _titleScrollerView.backgroundColor = [UIColor whiteColor];
        _titleScrollerView.showsVerticalScrollIndicator = NO;
        _titleScrollerView.showsHorizontalScrollIndicator = NO;
        _titleScrollerView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _titleScrollerView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [self.view addSubview:_titleScrollerView];
    }
    return  _titleScrollerView;
}
- (UIScrollView *)contentScrollerView{
    
    if (!_contentScrollerView) {
        _contentScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleScrollerView.frame), TYSCREENWIDTH, TYSCREENHEIGHT - 40 - 20)];
        _contentScrollerView.delegate = self;
        _contentScrollerView.showsHorizontalScrollIndicator = NO;
        _contentScrollerView.showsVerticalScrollIndicator = NO;
        _contentScrollerView.bounces = NO;
        _contentScrollerView.pagingEnabled = YES;
        _contentScrollerView.contentSize = CGSizeMake(TYSCREENWIDTH * self.childViewControllers.count, _contentScrollerView.frame.size.height);
        [self.view addSubview:_contentScrollerView];
    }
    return _contentScrollerView;
}
@end
