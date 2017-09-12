//
//  SFNetworkManager.m
//  SofficeMoi
//
//  Created by Mac mini on 17/1/13.
//  Copyright © 2017年 Soffice. All rights reserved.
//

#import "SFNetworkManager.h"

@interface SFNetworkManager()

@property (nonatomic, copy) void (^networkChange)(AFNetworkReachabilityStatus status);

@end

@implementation SFNetworkManager

+ (void)initialize {
    [self manager];
}

+ (SFNetworkManager *)manager {
    static SFNetworkManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [SFNetworkManager new];
        [instance startNetworkMonitor];
    });
    return instance;
}

/**
 开始监听网络变化并赋值
 */
- (void) startNetworkMonitor {
    typeof(self) __weak weakSelf = self;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //如果别的界面需要监听网络变化则打开这里回调然后分发到各个监听网络节点
        NSLog(@"网络改变：%ld",(long)status);
        if (weakSelf.networkChange) {
            weakSelf.networkChange(status);
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

/**
 是否有网络判断(返回YES有网络)
 */
+ (BOOL)isNetworkReachable {
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) { //说明网络开始初始化监听，默认是有网络的
        return YES;
    }
    return [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
}

+ (void)setNetworkChangeBlock:(void (^)(AFNetworkReachabilityStatus))block
{
    [self manager].networkChange = block;
}
    
@end
