//
//  CollectionAutoScroll.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/15.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "CollectionAutoScroll.h"

static NSString *const kCellIdentifier = @"imageCell";
@interface CollectionAutoScroll()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation CollectionAutoScroll

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    
    self  = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
        self.pagingEnabled = YES;
        
//        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:50 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
         _imageArr = @[@"0",@"1",@"2",@"3",@"4",@"5"];
        [self scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:500] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        _currentIndex = 0;
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [self setPage];
    }
    
    return self;
}
- (void)setPage{
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(TYSCREENWIDTH - 100, 160, 50, 30)];
    _pageControl.numberOfPages = _imageArr.count;
    _pageControl.pageIndicatorTintColor = [UIColor redColor];
    _pageControl.currentPageIndicatorTintColor = [UIColor greenColor];
    [self addSubview:_pageControl];
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return  _imageArr.count * 1000;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imageArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:cell.contentView.bounds];
    [cell.contentView addSubview:imageView];
    NSInteger index = indexPath.item % _imageArr.count;
    imageView.image = [UIImage imageNamed:_imageArr[index]];
    
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / TYSCREENWIDTH;
    self.pageControl.currentPage = index % _imageArr.count;
    
}
- (void)timerAction{
    
    NSIndexPath *currentPath = [[self indexPathsForVisibleItems]lastObject];
    NSIndexPath *currenpathre = [NSIndexPath indexPathForItem:currentPath.item inSection:50];
    
    
    [self scrollToItemAtIndexPath:currenpathre atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    NSInteger nextItem = currenpathre.item +1;
    NSInteger nextSection = currenpathre.section;
    if (nextItem==_imageArr.count) {
        
        nextItem=0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    [self scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    

 
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
   _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    NSInteger ccc = scrollView.contentOffset.x / TYSCREENWIDTH;
    _currentIndex = ccc + 1;
}
@end
