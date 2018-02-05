//
//  NSObject+SFNetwork.h
//  SFRequest
//
//  Created by 王声远 on 17/3/17.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFHttpManager.h"

#define SFHttp SFHttpRequest

#define get     request(mGet)
#define post    request(mPost)

@interface SFHttpRequest : NSObject

SFHttp *request(RequestMethod method);
- (SFHttp *(^)(NSString *))url;
- (SFHttp *(^)(NSDictionary *))addPara;
- (SFHttp *(^)(NSDictionary *))addHeaders;
- (SFHttp *(^)(void (^)(id json)))succ;
- (SFHttp *(^)(NSString *key,NSString *className,void (^)(id model)))resolve;
- (SFHttp *(^)(void (^)(NSError *error)))fail;
- (NSURLSessionDataTask *(^)())start;
- (NSURLSessionDataTask *(^)(NSString *key,NSString *className,void (^)(id model)))startWithResolve;
- (SFHttp *(^)(NSURLSessionDataTask *))cancelTask;

/* 使用例子 **
[GET.url(@"http://www.weather.com.cn/data/sk/101110101.html").addPara(@{@"userId":@"111"}).addPara(@{@"userName":@"222"}).resolve(@"weatherinfo",@"MyModel",^(id model){
    if ([model isKindOfClass:[MyModel class]]) {
        NSLog(@"解析返回：%@",model);
        
    }
    else if ([model isKindOfClass:[NSArray class]]){
        for (MyModel *p in model) {
            NSLog(@"数组解析返回：%@",p);
        }
    }
}).start() cancel];
 */

@end
