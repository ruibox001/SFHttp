//
//  SFResolveModel.m
//  SFRequest
//
//  Created by 王声远 on 17/3/17.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "SFHttpResolve.h"
#import "NSObject+YYModel.h"

@interface SFHttpResolve()

@end

@implementation SFHttpResolve

SFHttpResolve *resolveUtil() {
    static SFHttpResolve *resolve = nil;
    if (resolve == nil) {
        resolve = SFHttpResolve.new;
    }
    return resolve;
}

- (id)resolveWithResolveInfo:(SFHttpResolveModel *)resolveModel data:(id)data {
    if (!data || !resolveModel) {
        return nil;
    }
    
    id m = [self getDictFromDict:data keyName:resolveModel.key];
    if (m) {
        
        if (!resolveModel.className) {
            NSLog(@"ERROR: 解析的模型不能为空");
            return nil;
        }
        
        Class class = NSClassFromString(resolveModel.className);
        if (!class) {
            NSLog(@"ERROR: 找不到解析的模型：%@,请检查解析的模型是否存在",resolveModel.className);
            return nil;
        }
        
        if ([m isKindOfClass:[NSDictionary class]]) {
            return [class yy_modelWithDictionary:m];
        }
        else if ([m isKindOfClass:[NSArray class]]) {
            return [NSArray yy_modelArrayWithClass:class json:m];
        }
        else {
            NSLog(@"ERROR: JSON中未解析成功，请检查json数据");
        }
    }
    else {
        NSLog(@"ERROR: JSON中未找到对应的key,请检查给定的key是否正确");
    }
    return nil;
}

- (NSDictionary *)getDictFromDict:(NSDictionary *)dict keyName:(NSString *)keyName{
    if (dict[keyName]) {
        return dict[keyName];
    }
    for (NSString *key in dict.allKeys) {
        id d = dict[key];
        if ([d isKindOfClass:[NSDictionary class]]) {
            return [self getDictFromDict:d keyName:keyName];
        }
    }
    return nil;
}

- (NSData *)dataNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    if (!path) return nil;
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

- (NSDictionary *)toDict:(NSString *)str {
        NSError *err = nil;
        NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                options:NSJSONReadingMutableContainers
                                                                  error:&err];
        return dic;
}

- (NSDictionary *)datatoDict:(NSData *)jsonData {
    NSError *err = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    return dic;
}

@end
