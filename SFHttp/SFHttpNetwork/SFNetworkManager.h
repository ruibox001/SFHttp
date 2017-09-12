//
//  SFNetworkManager.h
//  SofficeMoi
//
//  Created by Mac mini on 17/1/13.
//  Copyright © 2017年 Soffice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworkReachabilityManager.h"

@interface SFNetworkManager : NSObject

/**
 是否有网络判断(返回YES有网络)
 */
+ (BOOL)isNetworkReachable;

+ (void)setNetworkChangeBlock:(void (^)(AFNetworkReachabilityStatus status))block;
    
@end
