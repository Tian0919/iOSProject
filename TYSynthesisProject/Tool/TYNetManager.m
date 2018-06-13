//
//  TYNetManager.m
//  TYSynthesisProject
//
//  Created by eeesysmini2 on 2018/6/13.
//  Copyright © 2018年 TianY. All rights reserved.
//

#import "TYNetManager.h"

@interface TYNetManager()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation TYNetManager
- (instancetype)init{
    if (self = [super init]) {
        self.manager = [AFHTTPSessionManager manager];
        AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
        
        [serializer setHTTPShouldHandleCookies:NO];
    }
    return self;
}
+ (instancetype)shareManager{
    
    static TYNetManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        manager = [[self alloc]init];
    });
    return  manager;
    
}
- (void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(TYSuccessBlock)success failed:(TYFailedBlock)failed{
    
    AFHTTPSessionManager *manager = [self getManagerWithWithPath:url parameters:parameters netIdentifier:nil success:success failure:failed];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    if (!manager) return;
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];
    
    
}



#pragma  mark - 私有方法
- (AFHTTPSessionManager *)getManagerWithWithPath:(const NSString *)path
                                      parameters:(id)parameters
                                   netIdentifier:(NSString *)netIdentifier
                                         success:(void (^)(id responseObject))success
                                         failure:(void (^)(NSError   *error))failure {
    
//    // 1.当前的请求是否正在进行
//    for (NSDictionary *dict in self.networkingManagerArray) {
//        NSString *key = [[dict allKeys] firstObject];
//        if ([key isEqualToString:netIdentifier]) {
//            if (failure) {
//                NSErrorDomain domain = [NSString stringWithFormat:@"\"%@\"请求正在进行!",netIdentifier];
//                NSError *cancelError = [NSError errorWithDomain:domain code:(-12001) userInfo:nil];
//                failure(cancelError);
//            }
//            return nil;
//        }
//    }
//
    // 2.检测是否有网络
    AFNetworkReachabilityStatus net = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    if ( net == AFNetworkReachabilityStatusNotReachable) {
        if (failure) {
            NSError *cancelError = [NSError errorWithDomain:@"没有网络,请检测网络!" code:(-12002) userInfo:nil];
            failure(cancelError);
        }
        return nil;
    }
    
    return self.manager;
}
@end
