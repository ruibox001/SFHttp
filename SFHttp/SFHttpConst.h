//
//  SFHttpConst.h
//  SFRequest
//
//  Created by 王声远 on 17/3/20.
//  Copyright © 2017年 王声远. All rights reserved.
//

#ifndef SFHttpConst_h
#define SFHttpConst_h

#import "SFHttpResolveModel.h"

@protocol SFResolveToolDelegate <NSObject>

@optional

- (id)resolveWithResolveInfo:(SFHttpResolveModel *)resolveModel data:(id)data;

@end

#define httpRequestTimeOut 15

#endif /* SFHttpConst_h */
