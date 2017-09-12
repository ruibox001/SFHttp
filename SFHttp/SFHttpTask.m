//
//  RequestAction.m
//  SFRequest
//
//  Created by 王声远 on 17/3/17.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "SFHttpTask.h"
#import "SFHttpManager.h"
#import "AFNetworking.h"
#import "SFNetworkManager.h"

@implementation SFHttpTask

+ (NSURLSessionDataTask *)startRequest:(id)httpManager {
    if (![SFNetworkManager isNetworkReachable]) {
        [httpManager processNetworkError];
        return nil;
    }
    
    return [self requestWithInfo:httpManager];
}

+ (AFHTTPSessionManager *)manager {
    static AFHTTPSessionManager *manager = nil;
    if (!manager) {
        manager = [AFHTTPSessionManager manager];
//        manager.requestSerializer = [AFHTTPRequestSerializer serializer]; //这个在传输数组字典时可能有问题
        manager.requestSerializer = [AFJSONRequestSerializer serializer]; //最好使用这个
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        manager.requestSerializer.timeoutInterval = 15;
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html",nil];
    }
    return manager;
}

+ (NSURLSessionDataTask *)requestWithInfo:(id)httpManager {
    if ([httpManager isKindOfClass:[SFHttpManager class]]) {
        SFHttpManager *m = httpManager;
        if (m.method == mPost) {
            return [self requestPost:m];
        }
        else if (m.method == mGet) {
            return [self requestGet:m];
        }
    }
    return nil;
}

+ (NSURLSessionDataTask *)requestPost:(SFHttpManager *)info
{
    return [[self manager] POST:info.url parameters:info.parameter progress:info.progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [info processSuccWithTask:task data:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [info processFailWithTask:task error:error];
    }];
}

+ (NSURLSessionDataTask *)requestGet:(SFHttpManager *)info
{
    return [[self manager] GET:info.url parameters:info.parameter progress:info.progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [info processSuccWithTask:task data:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [info processFailWithTask:task error:error];
    }];
}

@end
