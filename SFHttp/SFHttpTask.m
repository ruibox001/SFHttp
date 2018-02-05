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
    return [self requestWithHttpManager:httpManager];
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

+ (NSURLSessionDataTask *)requestWithHttpManager:(id)httpManager {
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

+ (NSURLSessionDataTask *)requestPost:(SFHttpManager *)httpManager
{
    AFHTTPSessionManager *manager = [self manager];
    [manager.requestSerializer setTimeoutInterval:httpRequestTimeOut];
    for (NSString *key in httpManager.headers.allKeys) {
        [manager.requestSerializer setValue:[httpManager.headers objectForKey:key] forHTTPHeaderField:key];
    }
    return [manager POST:httpManager.url parameters:httpManager.parameter progress:httpManager.progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [httpManager processSuccWithTask:task data:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         [httpManager processFailWithTask:task error:error];
    }];
}

+ (NSURLSessionDataTask *)requestGet:(SFHttpManager *)httpManager
{
    AFHTTPSessionManager *manager = [self manager];
    [manager.requestSerializer setTimeoutInterval:httpRequestTimeOut];
    for (NSString *key in httpManager.headers.allKeys) {
        [manager.requestSerializer setValue:[httpManager.headers objectForKey:key] forHTTPHeaderField:key];
    }
    return [manager GET:httpManager.url parameters:httpManager.parameter progress:httpManager.progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [httpManager processSuccWithTask:task data:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [httpManager processFailWithTask:task error:error];
    }];
}

@end
