//
//  ChannelListModel.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/20.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "ChannelListModel.h"

@implementation ChannelListModel

+ (NSDictionary *)modelContainerPropertyGennericClass{
    
    return @{@"channelList":[ChannelSubListModel class]};
}

@end

@implementation ChannelSubListModel

@end
