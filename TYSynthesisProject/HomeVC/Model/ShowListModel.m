//
//  ShowListModel.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/19.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "ShowListModel.h"

@implementation ShowListModel

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.location forKey:@"location"];
}

- (instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
    self.location = [aDecoder decodeObjectForKey:@"location"];
    return self;
}




@end

