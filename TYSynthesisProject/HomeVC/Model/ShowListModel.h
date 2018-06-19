//
//  ShowListModel.h
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/19.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShowListModel : NSObject<NSCoding>

/**
 城市ID
 */
@property (nonatomic, copy) NSString *cid;

/**
 地区/城市名称
 */
@property (nonatomic, copy) NSString *location;

/**
 该地区/城市的上级城市
 */
@property (nonatomic, copy) NSString *parent_city;

/**
 所属行政区域
 */
@property (nonatomic, copy) NSString *admin_area;

/**
 所属国家名称
 */
@property (nonatomic, copy) NSString *cnty;

@property (nonatomic, copy) NSString *lat;

@property (nonatomic, copy) NSString *lon;

@property (nonatomic, copy) NSString *type;

@end
