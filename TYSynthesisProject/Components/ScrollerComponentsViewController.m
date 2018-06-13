//
//  ScrollerComponentsViewController.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/12.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "ScrollerComponentsViewController.h"

static const CGFloat TitleHeight = 40;
@interface ScrollerComponentsViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *contentScrollerView;
@property (nonatomic, strong) UIScrollView *titleScrollerView;
@property (nonatomic, strong) NSMutableArray *titleWidthArr;
@property (nonatomic, assign) CGFloat totlaTitleWidth;
@property (nonatomic, strong) UILabel *selectedLab;
@property (nonatomic, strong) UIView *underLine;
@end

@implementation ScrollerComponentsViewController
#pragma mark 设置显示属性
- (UIColor *)selectedColor{
    if (!_selectedColor) {
        _selectedColor = [UIColor redColor];
    }
    return _selectedColor;
}
- (UIColor *)normalColor{
    
    if(!_normalColor) _normalColor = [UIColor blackColor];
    return _normalColor;
}
- (NSMutableArray *)titleWidthArr{
    if (!_titleWidthArr) {
        _titleWidthArr = [NSMutableArray array];
    }
    return  _titleWidthArr;
}
- (NSInteger)selectedIndex{
    if(!_selectedIndex) _selectedIndex = 0;
    return _selectedIndex;
}
#pragma mark 懒加载scrollerView
- (UIScrollView *)titleScrollerView{
  
    if (!_titleScrollerView) {
        _titleScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, NavHeight + StatusbarHeight, TYSCREENWIDTH, TitleHeight)];
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
        _contentScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleScrollerView.frame), TYSCREENWIDTH, TYSCREENHEIGHT -TitleHeight - StatusbarHeight - NavHeight)];
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
#pragma mark view生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self cacluateWidths];
    [self AllTitles];
    
    [self contentVC:self.selectedIndex];
    
}
#pragma mark 设置顶部滚动标题
- (void)AllTitles{
    
    CGFloat labX = 0;
    CGFloat labW = 0.0;
    
    self.underLine = [UIView new];
    self.underLine.backgroundColor = self.selectedColor;
    
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UILabel *lab = [UILabel new];
        lab.text = self.childViewControllers[i].title;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.userInteractionEnabled = YES;
        lab.tag = i;
        lab.textColor = self.normalColor;
        
        if (_totlaTitleWidth < TYSCREENWIDTH) {
            labW = TYSCREENWIDTH / self.childViewControllers.count;
            lab.frame = CGRectMake(i * labW, 0, labW, 40);
        }else{
            labW = [self.titleWidthArr[i] floatValue];
            lab.frame = CGRectMake(labX, 0, labW, 40);
            labX += labW;
        }
        
        
        if (i == self.selectedIndex) {
            self.selectedLab = lab;
            self.selectedLab.textColor = self.selectedColor;
            self.underLine.bounds = CGRectMake(0, 0, labW * 0.4, 2);
            self.underLine.center = CGPointMake(self.selectedLab.center.x, self.selectedLab.frame.size.height-5);
        }
        
        
        [self.titleScrollerView addSubview:lab];
        if (self.ShowUnderLine) {
            [self.titleScrollerView addSubview:_underLine];
        }
        self.titleScrollerView.contentSize = CGSizeMake(CGRectGetMaxX(lab.frame), 0);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labClick:)];
        [lab addGestureRecognizer:tap];
        
    }
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
#pragma mark 标题点击事件
- (void)labClick:(UITapGestureRecognizer *)tap{
    
    [self.contentScrollerView scrollRectToVisible:CGRectMake(tap.view.tag * TYSCREENWIDTH, 0, TYSCREENWIDTH, self.contentScrollerView.frame.size.height) animated:NO];
    [self titleLabClick:tap.view.tag];
}
#pragma mark 选中标题显示处理
- (void)titleLabClick:(NSInteger)index{
    
    UILabel *clickLab = self.titleScrollerView.subviews[index];
    if (clickLab == self.selectedLab) {
        return;
    }
    
    [self setTitleScrollertoCenter:clickLab];
    
    clickLab.textColor = self.selectedColor;
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint center = self.underLine.center;
        center.x = clickLab.center.x;
        self.underLine.center = center;
    }];
    self.selectedLab.textColor = self.normalColor;
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
    //根据应该出现的view的frame判断当前view是否已添加到contentScrollerView上 否则添加view发出首次加载的通知,
     UIViewController *vc = self.childViewControllers[index];
    if (!vc.view.frame.origin.x) {
          vc.view.frame = CGRectMake(index * TYSCREENWIDTH, 0, TYSCREENWIDTH, self.contentScrollerView.frame.size.height);
          [self.contentScrollerView addSubview:vc.view];
        UILabel *lab = self.titleScrollerView.subviews[index];
        [self setTitleScrollertoCenter:lab];
        [self.contentScrollerView scrollRectToVisible:CGRectMake(index * TYSCREENWIDTH, 0, TYSCREENWIDTH, self.contentScrollerView.frame.size.height) animated:NO];
        //每次新加view发出通知，界面自动刷新，否则只手动刷新
        [[NSNotificationCenter defaultCenter]postNotificationName:TYComponentClickOrScrollerViewDidfinishLoadView object:vc];
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


@end
