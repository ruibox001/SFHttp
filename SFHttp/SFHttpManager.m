//
//  RequestInfo.m
//  SFRequest
//
//  Created by 王声远 on 17/3/17.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "SFHttpManager.h"
#import "SFHttpLog.h"

@implementation SFHttpManager

- (void)processSuccWithTask:(NSURLSessionDataTask *)task data:(id)data {
    [SFHttpLog log:data url:self.url parameter:self.parameter];
    if (self.succBlock) {
        self.succBlock(data);
    }
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(resolveWithResolveInfo:data:)]) {
            id m = [self.delegate resolveWithResolveInfo:self.resolveInfo data:data];
            if (!m) {
                m = data;
            }
            if (self.resolveInfo.resolvBlock) {
                self.resolveInfo.resolvBlock(m);
            }
        }
    }
}

- (void)processFailWithTask:(NSURLSessionDataTask *)task error:(NSError *)error {
    requestLog(@"请求失败信息: url: \n%@ \nparameter: \n%@ \n错误数据: \n%@",self.url,self.parameter,error);
    if (self.failBlock) {
        self.failBlock(error);
    }
    
    if (self.resolveInfo && self.resolveInfo.resolvBlock) {
        self.resolveInfo.resolvBlock(error);
    }
}

- (void)processNetworkError {
    requestLog(@"请求无网络失败");
    if (self.failBlock) {
        NSError *error = [NSError errorWithDomain:@"stk.network.error" code:SFHttpNoNerworkErrorCode userInfo:@{SFHttpErrorInfoKey:@"请连接网络再试"}];
        self.failBlock(error);
    }
}

- (NSMutableDictionary *)parameter {
    if (!_parameter) {
        _parameter = [NSMutableDictionary dictionary];
    }
    return _parameter;
}

- (NSMutableDictionary *)headers {
    if (!_headers) {
        _headers = [NSMutableDictionary dictionary];
    }
    return _headers;
}

- (void)dealloc
{
    requestLog(@"请求结束了：%@",self.url);
}

@end
