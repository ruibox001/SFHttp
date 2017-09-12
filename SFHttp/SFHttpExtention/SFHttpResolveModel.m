//
//  SFHttpResolveModel.m
//  SFRequest
//
//  Created by 王声远 on 17/3/20.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "SFHttpResolveModel.h"

@implementation SFHttpResolveModel

SFHttpResolveModel *resolveModel() {
    return SFHttpResolveModel.new;
}

- (SFHttpResolveModel *(^)(NSString *key,NSString *className,void (^)(id model)))resolveBlock {
    return ^(NSString *key,NSString *className,void (^resolveBlock)(id model)){
        self.key = key;
        self.className = className;
        self.resolvBlock = resolveBlock;
        return self;
    };
}

@end
