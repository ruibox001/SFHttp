//
//  SFResolveModel.h
//  SFRequest
//
//  Created by 王声远 on 17/3/17.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFHttpResolveModel.h"
#import "SFHttpConst.h"

#define resolveTool resolveUtil()

@interface SFHttpResolve : NSObject <SFResolveToolDelegate>

SFHttpResolve *resolveUtil();

@end


