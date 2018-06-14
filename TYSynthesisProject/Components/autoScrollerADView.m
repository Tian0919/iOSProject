//
//  autoScrollerADView.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/14.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "autoScrollerADView.h"

@interface autoScrollerADView()<UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *leftImageView;

@property (nonatomic, strong) UIImageView *middleImageView;

@property (nonatomic, strong) UIImageView *rightImageView;

@property (nonatomic, strong) UIScrollView *contentScrollerView;

@property (nonatomic, assign) NSInteger scrollerCount;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UIPageControl *pageControl;

@end


@implementation autoScrollerADView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}
- (NSInteger)scrollerTimeInterval{
    if (!_scrollerTimeInterval) _scrollerTimeInterval = 3.0;
    return _scrollerTimeInterval;
}
- (UIColor *)pageControlIndicatorColor{
    if(!_pageControlIndicatorColor) _pageControlIndicatorColor = [UIColor lightGrayColor];
    
    return _pageControlIndicatorColor;
}
- (UIColor *)pageControlCurrentColor{
    if(!_pageControlCurrentColor) _pageControlCurrentColor = [UIColor whiteColor];
    return  _pageControlCurrentColor;
}
- (void)setImageArr:(NSArray *)imageArr{
    
    _imageArr = imageArr;
    _scrollerCount = 0;
    [self setUI];
    [self startTimer];
    [self setPage];
    
}
#pragma mark 设置pageControl
- (void)setPage{
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(TYSCREENWIDTH - 100, 160, 50, 30)];
    _pageControl.numberOfPages = _imageArr.count;
    _pageControl.pageIndicatorTintColor = self.pageControlIndicatorColor;
    _pageControl.currentPageIndicatorTintColor = self.pageControlCurrentColor;
    [self addSubview:_pageControl];
   
}
#pragma mark 生成定时器
- (void)startTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.scrollerTimeInterval target:self selector:@selector(timeAction) userInfo:nil repeats:YES];

    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
#pragma mark 定时器事件
- (void)timeAction{
    
    [self.contentScrollerView scrollRectToVisible:CGRectMake(2 * TYSCREENWIDTH, 0, TYSCREENWIDTH,  self.frame.size.height) animated:YES];
}
#pragma mark 销毁定时器
- (void)invalidateTimer{
    [_timer invalidate];
    _timer = nil;
}
#pragma mark 界面初始化
- (void)setUI{
    
    _contentScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, TYSCREENWIDTH, self.frame.size.height)];
    _contentScrollerView.showsVerticalScrollIndicator = NO;
    _contentScrollerView.showsHorizontalScrollIndicator = NO;
    _contentScrollerView.delegate = self;
    _contentScrollerView.backgroundColor = [UIColor greenColor];
    _contentScrollerView.contentSize = CGSizeMake(TYSCREENWIDTH * 3,  self.frame.size.height);
    _contentScrollerView.pagingEnabled = YES;
    _contentScrollerView.bounces = NO;
    [self addSubview:_contentScrollerView];
    
    
    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, TYSCREENWIDTH,  self.frame.size.height)];
    _leftImageView.image = [UIImage imageNamed:_imageArr[_imageArr.count-1]];
    [_contentScrollerView addSubview:_leftImageView];
    
    _middleImageView = [[UIImageView alloc]initWithFrame:CGRectMake(TYSCREENWIDTH, 0, TYSCREENWIDTH,  self.frame.size.height)];
    _middleImageView.image = [UIImage imageNamed:_imageArr[0]];
    _middleImageView.userInteractionEnabled = YES;
    [_contentScrollerView addSubview:_middleImageView];
    
    _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(TYSCREENWIDTH * 2, 0, TYSCREENWIDTH,  self.frame.size.height)];
    _rightImageView.image = [UIImage imageNamed:_imageArr[1]];
    [_contentScrollerView addSubview:_rightImageView];
    
    
    [_contentScrollerView scrollRectToVisible:CGRectMake(TYSCREENWIDTH, 0, TYSCREENWIDTH,  self.frame.size.height) animated:YES];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
 //当前显示的永远是middleImageView所以点击手势添加middleImageView上
    [_middleImageView addGestureRecognizer:tap];
    
    
}
#pragma mark imageView点击事件
- (void)imageClick:(UITapGestureRecognizer *)tap{

    if (self.imageBlock) {
        self.imageBlock(_scrollerCount % _imageArr.count);
    }
}
#pragma mark scrollerVIew代理方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger offsetX = scrollView.contentOffset.x;
    
    if (offsetX==TYSCREENWIDTH * 2) {
        _scrollerCount ++;
        [self changeImage];
        
    }else if(scrollView.contentOffset.x == 0){
        //避免首次向左划_scrollerCount会出现负数
        _scrollerCount = _scrollerCount + _imageArr.count;
        _scrollerCount --;
        [self changeImage];
    }
    
}
#pragma mark 监听手势代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self invalidateTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}
#pragma mark 定时器触发的代理方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 2 * TYSCREENWIDTH) {
        _scrollerCount ++;
        [self changeImage];
    }
}
#pragma mark 根据scrollerView的滚动切换图片实现无限轮播
- (void)changeImage{
    _leftImageView.image = [UIImage imageNamed:_imageArr[(_scrollerCount - 1)%_imageArr.count]];
    
    _middleImageView.image = [UIImage imageNamed:_imageArr[_scrollerCount%_imageArr.count]];
    _rightImageView.image = [UIImage imageNamed:_imageArr[(_scrollerCount + 1)%_imageArr.count]];
    _pageControl.currentPage = _scrollerCount % _imageArr.count;
    _contentScrollerView.contentOffset = CGPointMake(TYSCREENWIDTH, 0);
}
@end
