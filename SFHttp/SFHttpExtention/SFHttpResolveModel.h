//
//  SFHttpResolveModel.h
//  SFRequest
//
//  Created by 王声远 on 17/3/20.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <Foundation/Foundation.h>

#define resolveModelUtil resolveModel()

@interface SFHttpResolveModel : NSObject

SFHttpResolveModel *resolveModel();
- (SFHttpResolveModel *(^)(NSString *key,NSString *className,void (^)(id model)))resolveBlock;

@property (nonatomic,strong) NSString *key;
@property (nonatomic,strong) NSString *className;
@property (nonatomic,copy) void (^resolvBlock)(id model);

@end
