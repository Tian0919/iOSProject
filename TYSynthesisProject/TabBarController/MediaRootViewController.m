//
//  MediaRootViewController.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/12.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "MediaRootViewController.h"
#import "CollectionAutoScroll.h"
@interface MediaRootViewController ()

@end

@implementation MediaRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(TYSCREENWIDTH, 200);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    CollectionAutoScroll *autosc = [[CollectionAutoScroll alloc]initWithFrame:CGRectMake(0, 64, TYSCREENWIDTH, 200) collectionViewLayout:layout];
    [self.view addSubview:autosc];
}



@end
