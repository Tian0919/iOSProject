//
//  TCollectionViewController.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/21.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "TCollectionViewController.h"
#import "TYFlowLayout.h"
#import "TYLayout.h"
static NSString *const kCollectionCellIndentifier = @"tCell";
@interface TCollectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) NSArray *sectionArr;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation TCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArr = [NSMutableArray arrayWithObjects:@"OC",@"Swift",@"Java",@"C",@"C++",@"flutter", nil];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Section" ofType:@"plist"];
    _sectionArr = [NSArray arrayWithContentsOfFile:path];
    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    layout.minimumLineSpacing = 5;
//    layout.minimumInteritemSpacing = 5;
//    layout.itemSize = CGSizeMake((TYSCREENWIDTH - 20) / 4, 100);
    TYFlowLayout *layout = [TYFlowLayout new];
    layout.rowSpacing = 10;
    layout.columnSpacing = 10;
//    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    [layout setItemHeightBlock:^CGFloat(CGFloat itemHeight, NSIndexPath *indexPath) {
        return arc4random()%(400-300);
    }];

    self.mainCollectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    _mainCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_mainCollectionView];
    [_mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCollectionCellIndentifier];
    [_mainCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderCell"];
//    _mainCollectionView.pagingEnabled = YES;
    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    [_mainCollectionView addGestureRecognizer:press];
}
- (void)longPressAction:(UILongPressGestureRecognizer *)press{
    NSIndexPath *indexpath = [_mainCollectionView indexPathForItemAtPoint:[press locationInView:press.view]];
    UICollectionViewCell *cell = [_mainCollectionView cellForItemAtIndexPath:indexpath];
//    if (indexpath.item == 0) {
//        [_mainCollectionView cancelInteractiveMovement];
//    }
    switch (press.state) {
        case UIGestureRecognizerStateBegan:
            [_mainCollectionView beginInteractiveMovementForItemAtIndexPath:indexpath];
            cell.transform = CGAffineTransformMakeScale(1.5, 1.5);
            break;
        case UIGestureRecognizerStateChanged:
            [_mainCollectionView updateInteractiveMovementTargetPosition:[press locationInView:press.view]];
            break;
        case UIGestureRecognizerStateEnded:
            [_mainCollectionView endInteractiveMovement];
             cell.transform = CGAffineTransformMakeScale(1.0, 1.0);
        default:
            [_mainCollectionView cancelInteractiveMovement];
             cell.transform = CGAffineTransformMakeScale(1.0, 1.0);
            break;
    }
    
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionCellIndentifier forIndexPath:indexPath];
    if (indexPath.item % 2 == 0) {
         cell.backgroundColor = [UIColor redColor];
    }else{
        cell.backgroundColor = [UIColor yellowColor];
    }
   
//    UILabel *name = [[UILabel alloc]initWithFrame:cell.contentView.frame];
//    name.textColor = [UIColor blackColor];
//    [cell.contentView addSubview:name];
//    name.backgroundColor = [UIColor whiteColor];
//    name.text = _dataArr[indexPath.item];
//    name.textAlignment = NSTextAlignmentCenter;
    return cell;
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderCell" forIndexPath:indexPath];
        UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
        name.textColor = [UIColor whiteColor];
        [header addSubview:name];
        name.backgroundColor = [UIColor lightGrayColor];
        name.text = _sectionArr[indexPath.section];
        return header;
    }else{
        
        return nil;
    }
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//
//    return CGSizeMake(100, 30);
//}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 20;
}
//- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
//    return YES;
//}
//
//
//- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
//
//    [_dataArr exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
//}


@end
