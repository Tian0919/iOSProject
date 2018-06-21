//
//  ShowAllTitleViewController.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/20.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "ShowAllTitleViewController.h"
#import "ShowCollectionViewCell.h"
#import "ChannelListModel.h"
#import "ShowCollectionReusableView.h"
@interface ShowAllTitleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *showCollectionView;
@property (nonatomic, strong) NSArray *sectionArr;
@property (nonatomic, strong) NSIndexPath *dragIndexPath;
@property (nonatomic, strong) NSIndexPath *targetIndexPath;
@property (nonatomic, strong) UICollectionViewCell *dragcell;
@end

@implementation ShowAllTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AFHTTPSessionManager *mnaager = [AFHTTPSessionManager manager];
    [mnaager GET:@"https://api.k.sohu.com/api/channel/v7/list.go?activeChn=1020&apiVersion=42&bid=Y29tLnNvaHUubmV3c3BhcGVy&change=0&gid=010101110600010c766a57f628044bbb96c5b69946922f&isStartUp=1&local=0&p1=NjQxMzI3MDg5OTI2ODk1NjI1Nw%3D%3D&pid=-1&rt=json&sid=18&supportLive=1&supportWeibo=1&u=1&up=1%252C13557%252C2981%252C3%252C2%252C4%252C6%252C5%252C283%252C247%252C45%252C11%252C351%252C279%252C12%252C954509%252C98%252C50%252C16%252C177%252C248%252C49%252C359980%252C46%252C250%252C960377%252C25%252C960516&v=6.0.9" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *arr = [NSArray yy_modelArrayWithClass:[ChannelListModel class] json:responseObject[@"data"]];
        NSLog(@"%@",arr);
        self.sectionArr = arr;
        [self.showCollectionView reloadData];
        
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    [self.showCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"dragcell"];
    
//    UICollectionViewCell *dragcell = [[UICollectionViewCell alloc]initWithFrame:CGRectMake(0, 0, TYSCREENWIDTH/4, 50)];
//    dragcell.hidden = YES;
//    _dragcell = dragcell;
//    _dragcell.backgroundColor = [UIColor redColor];
//    [self.showCollectionView addSubview:dragcell];
    
    UILongPressGestureRecognizer *gesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longGesture:)];
    gesture.minimumPressDuration = 0.5;
    [self.showCollectionView addGestureRecognizer:gesture];
    
    
}
- (void)longGesture:(UILongPressGestureRecognizer *)longPress{
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"began");
            [self drawBegin:longPress];
            break;
        case UIGestureRecognizerStateChanged:
            NSLog(@"changed");
            [self draeChnaged:longPress];
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"End");
            _dragcell.hidden = YES;
            break;
        default:
            break;
    }
}
- (void)drawBegin:(UILongPressGestureRecognizer *)press{
    CGPoint point = [press locationInView:self.showCollectionView];
    _dragIndexPath = [self getDragIndexpathWithPoint:point];
    
    if (!_dragIndexPath) return;
    
    [self.showCollectionView bringSubviewToFront:_dragcell];
    ShowCollectionViewCell *cell = (ShowCollectionViewCell *)[self.showCollectionView cellForItemAtIndexPath:_dragIndexPath];
//    _dragcell.frame = [self.showCollectionView cellForItemAtIndexPath:_dragIndexPath].frame;
//    _dragcell.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        [cell setTransform:CGAffineTransformMakeScale(1.2, 1.2)];
    }];
}
- (void)draeChnaged:(UILongPressGestureRecognizer *)press{
    
    CGPoint point = [press locationInView:self.showCollectionView];
    _dragcell.center = point;
    _targetIndexPath = [self getDragIndexpathWithPoint:point];
    
    if (_targetIndexPath && _dragIndexPath)  {

//        ChannelListModel *drawModel = _sectionArr[_dragIndexPath.section];
//        ChannelListModel *targetModel = _sectionArr[_targetIndexPath.section];
//
//        NSDictionary *drawdic = drawModel.channelList[_dragIndexPath.item];
//        [targetModel.channelList addObject:drawdic];
//        [drawModel.channelList removeObject:drawdic];

        
        

        [self.showCollectionView moveItemAtIndexPath:_dragIndexPath toIndexPath:_targetIndexPath];
        [self.showCollectionView reloadData];
        _dragIndexPath = _targetIndexPath;
    }

    
}
- (void)drawEnd:(UILongPressGestureRecognizer *)press{
    if(!_dragcell)return;

    CGRect endFrame = [self.showCollectionView cellForItemAtIndexPath:_dragIndexPath].frame;
     ShowCollectionViewCell *cell = (ShowCollectionViewCell *)[self.showCollectionView cellForItemAtIndexPath:_dragIndexPath];

    [UIView animateWithDuration:0.3 animations:^{
        [cell setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
       cell.frame = endFrame;
    }completion:^(BOOL finished) {

    }];
}
//获取到当前cellindexPath
- (NSIndexPath *)getDragIndexpathWithPoint:(CGPoint)point{
    
    NSIndexPath *dragIndexPath = nil;
    
    for (NSIndexPath *index in self.showCollectionView.indexPathsForVisibleItems) {
        if (CGRectContainsPoint([self.showCollectionView cellForItemAtIndexPath:index].frame, point)) {
            dragIndexPath = index;
            break;
        }
    }
    return dragIndexPath;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return _sectionArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    ChannelListModel *model = _sectionArr[section];
    return  model.channelList.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"showCell" forIndexPath:indexPath];
      ChannelListModel *model = _sectionArr[indexPath.section];
  NSDictionary *dic = model.channelList[indexPath.item];
    
    cell.titleLab.text = dic[@"name"];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (indexPath.section != 0) {
        ChannelListModel *model = _sectionArr[indexPath.section];
        NSDictionary *dic = model.channelList[indexPath.item];
        
        ChannelListModel *model1 = _sectionArr[0];
        [model1.channelList addObject:dic];
        [model.channelList removeObject:dic];
        [self.showCollectionView reloadData];
        
    }
  
    
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(TYSCREENWIDTH/4, 50);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if (kind == UICollectionElementKindSectionHeader) {
        ShowCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"showHeader" forIndexPath:indexPath];
        ChannelListModel *model = _sectionArr[indexPath.section];
        header.sectionHeader.text = model.categoryName;
        return header;
    }
    return [UICollectionReusableView new];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(TYSCREENWIDTH, 40);
}
- (IBAction)dismissBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
