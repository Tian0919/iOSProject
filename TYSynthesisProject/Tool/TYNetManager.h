//
//  TYNetManager.h
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/13.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^TYSuccessBlock)(id responseObject);
typedef void(^TYFailedBlock)(NSError *error);

@interface TYNetManager : NSObject

+ (instancetype)shareManager;

- (void)get:(NSString *)url
 parameters:(NSDictionary *)parameters
    success:(TYSuccessBlock)success
     failed:(TYFailedBlock)failed;

@end
