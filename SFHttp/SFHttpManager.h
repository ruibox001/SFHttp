//
//  RequestInfo.h
//  SFRequest
//
//  Created by 王声远 on 17/3/17.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFHttpConst.h"

#define SFHttpErrorInfoKey          @"SFHttpErrorInfoKey"
#define SFHttpNoNerworkErrorCode    0xfffffff1

@class SFHttpResolveModel;

typedef NS_ENUM(NSInteger, RequestMethod){
    mGet,
    mPost
};

@interface SFHttpManager : NSObject

#pragma mark - 请求相关
@property (nonatomic,strong) NSString *url;
@property (nonatomic,strong) NSMutableDictionary *parameter;
@property (nonatomic,strong) NSMutableDictionary *headers;
@property (nonatomic,assign) RequestMethod method;
@property (nonatomic,copy) void (^succBlock)(id json);
@property (nonatomic,copy) void (^failBlock)(NSError *error);
@property (nonatomic,copy) void (^progress)(NSProgress *p);

#pragma mark - 解析相关
@property (nonatomic,strong) SFHttpResolveModel *resolveInfo;
@property (nonatomic,assign) id <SFResolveToolDelegate> delegate;

#pragma mark - 处理相关
- (void)processSuccWithTask:(NSURLSessionDataTask *)task data:(id)data;
- (void)processFailWithTask:(NSURLSessionDataTask *)task error:(NSError *)error;

#pragma mark - 网络相关
- (void)processNetworkError;

@end
