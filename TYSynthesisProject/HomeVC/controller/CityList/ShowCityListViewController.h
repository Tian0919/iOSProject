//
//  ShowCityListViewController.h
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/19.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ShowCityBlock)(NSString *name);

@interface ShowCityListViewController : UIViewController

@property (nonatomic, copy) ShowCityBlock block;

@end
