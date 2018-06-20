//
//  ChannelListModel.h
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/20.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ChannelSubListModel;
@interface ChannelListModel : NSObject

@property (nonatomic, copy) NSString *categoryId;

@property (nonatomic, copy) NSString *categoryName;

@property (nonatomic, strong) NSMutableArray *channelList;

@end


@interface ChannelSubListModel : NSObject

@property (nonatomic, copy) NSString *categoryId;

@property (nonatomic, copy) NSString *categoryName;

@property (nonatomic, copy) NSString *daytimeModeColor;

@property (nonatomic, copy) NSString *iconFlag;

@property (nonatomic, copy) NSString *id;

@property (nonatomic, copy) NSString *interval;

@property (nonatomic, copy) NSString *isBold;

@property (nonatomic, copy) NSString *isForceToFirst;

@property (nonatomic, copy) NSString *isMixStream;

@property (nonatomic, copy) NSString *localType;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *nightModeColor;

@property (nonatomic, copy) NSString *showType;

@property (nonatomic, copy) NSString *tips;

@property (nonatomic, copy) NSString *tipsInterval;

@property (nonatomic, copy) NSString *top;

@property (nonatomic, copy) NSString *topCount;

@property (nonatomic, copy) NSString *topNewsTimes;

@end
