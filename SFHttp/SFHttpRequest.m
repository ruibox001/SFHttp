//
//  NSObject+SFNetwork.m
//  SFRequest
//
//  Created by 王声远 on 17/3/17.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "SFHttpRequest.h"
#import "SFHttpTask.h"
#import "SFHttpResolve.h"

@interface SFHttpRequest()

@property (nonatomic,strong) SFHttpManager *manager;

@end

@implementation SFHttpRequest

SFHttp *request(RequestMethod method) {
    SFHttp *req = SFHttp.new;
    req.manager = [SFHttpManager new];
    req.manager.method = method;
    return req;
}

- (SFHttp *(^)(NSString *))url {
    return ^(NSString *url){
        self.manager.url = url;
        return self;
    };
}

- (SFHttp *(^)(NSDictionary *))addPara {
    return ^(NSDictionary *dict){
        if (dict) {
            for (NSString *key in dict.allKeys) {
                [self.manager.parameter setObject:dict[key] forKey:key];
            }
        }
        return self;
    };
}

- (SFHttp *(^)(NSDictionary *))addHeaders {
    return ^(NSDictionary *dict){
        if (dict) {
            for (NSString *key in dict.allKeys) {
                [self.manager.headers setObject:dict[key] forKey:key];
            }
        }
        return self;
    };
}

- (SFHttp *(^)(void (^)(id json)))succ {
    return ^(void (^succBlock)(id json)){
        self.manager.succBlock = succBlock;
        return self;
    };
}

- (SFHttp *(^)(NSString *key,NSString *className,void (^)(id model)))resolve {
    return ^(NSString *modelKey,NSString *modelName,void (^resolveBlock)(id model)){
        self.manager.resolveInfo = resolveModelUtil.resolveBlock(modelKey,modelName,resolveBlock);
        self.manager.delegate = resolveTool;
        return self;
    };
}

- (SFHttp *(^)(void (^)(NSError *error)))fail {
    return ^(void (^failBlock)(NSError *error)){
        self.manager.failBlock = failBlock;
        return self;
    };
}

- (NSURLSessionDataTask *(^)())start {
    return ^(){
        return [SFHttpTask startRequest:self.manager];
    };
}

- (NSURLSessionDataTask *(^)(NSString *key,NSString *className,void (^)(id model)))startWithResolve {
    return ^(NSString *modelKey,NSString *modelName,void (^resolveBlock)(id model)){
        self.manager.resolveInfo = resolveModelUtil.resolveBlock(modelKey,modelName,resolveBlock);
        self.manager.delegate = resolveTool;
        return [SFHttpTask startRequest:self.manager];
    };
}

- (SFHttp *(^)(NSURLSessionDataTask *))cancelTask {
    return ^(NSURLSessionDataTask *task){
        [task cancel];
        return self;
    };
}

@end
