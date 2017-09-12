//
//  RequestAction.h
//  SFRequest
//
//  Created by 王声远 on 17/3/17.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFHttpTask : NSObject

+ (NSURLSessionDataTask *)startRequest:(id)httpManager;

@end
