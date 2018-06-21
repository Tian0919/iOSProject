//
//  TYLayout.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/21.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "TYLayout.h"

@implementation TYLayout

- (NSMutableArray *)attrArr{
    
    if (!_attrArr) {
        _attrArr = [NSMutableArray array];
    }
    return _attrArr;
}
-(id)init {
    self = [super init];
    if (self) {
        CGFloat margin = (TYSCREENWIDTH - TYSCREENWIDTH * 0.6)/2.0;
        self.itemSize = CGSizeMake(TYSCREENWIDTH * 0.6, 200);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(0, ABS(margin), 0, ABS(margin));
        
        self.minimumLineSpacing = 50;
    }
    return self;
}
- (void)prepareLayout{
    
    [super prepareLayout];
    
    CGFloat inset = (self.collectionView.frame.size.width - self.itemSize.width)/ 2;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
//    NSInteger  count = [self. collectionView numberOfItemsInSection:0];
//    [self.attrArr removeAllObjects];
//
//    for (NSInteger i = 0; i < count; i++) {
//        UICollectionViewLayoutAttributes *aaa = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
//        [self.attrArr addObject:aaa];
//    }
    
}
//- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    UICollectionViewLayoutAttributes *attt = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
//
//    CATransform3D t = CATransform3DIdentity;
//    attt.transform3D = CATransform3DScale(t, 0.8, 1.0, 0.9);
//
//    attt.frame = CGRectMake(TYSCREENWIDTH * indexPath.row, 0, TYSCREENWIDTH, 200);
//    return attt;
//
//}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    
    return YES;
}

//- (CGSize)collectionViewContentSize{
//
//    return CGSizeMake(TYSCREENWIDTH * self.attrArr.count , 200);
//}
//返回rect范围内item的attributes
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    NSArray *arr = [[NSArray alloc]initWithArray:[super layoutAttributesForElementsInRect:rect]];
   
    CGFloat centerX = self.collectionView.frame.size.width / 2 + self.collectionView.contentOffset.x;
    
    for (UICollectionViewLayoutAttributes *att in arr) {
        CGFloat space = ABS(att.center.x - centerX);
        CGFloat scale = 1 -(space/ self.collectionView.frame.size.width / 5);
        att.transform = CGAffineTransformMakeScale(scale, scale);
    }

    return arr;
}
// 自动对齐到网格
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset
                                 withScrollingVelocity:(CGPoint)velocity {
    // 计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;//最终要停下来的X
    rect.size = self.collectionView.frame.size;
    
    //获得计算好的属性
    NSArray * original = [super layoutAttributesForElementsInRect:rect];
    NSArray * attsArray = [[NSArray alloc] initWithArray:original copyItems:YES];
    //计算collection中心点X
    //视图中心点相对于collectionView的content起始点的位置
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width / 2;
    CGFloat minSpace = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in attsArray) {
        //找到距离视图中心点最近的cell，并将minSpace值置为两者之间的距离
        if (ABS(minSpace) > ABS(attrs.center.x - centerX)) {
            minSpace = attrs.center.x - centerX;        //各个不同的cell与显示中心点的距离
        }
    }
    // 修改原有的偏移量
    proposedContentOffset.x += minSpace;
    return proposedContentOffset;
}
@end
