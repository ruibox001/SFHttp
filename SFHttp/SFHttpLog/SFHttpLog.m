//
//  SFLogFormatJSON.m
//  SofficeMoi
//
//  Created by soffice on 6/2/16.
//  Copyright © 2016 Soffice. All rights reserved.
//

#import "SFHttpLog.h"

@implementation SFHttpLog

+ (void) log:(id)responseObject
         url:(NSString *)URLString
   parameter:(NSDictionary *)bodyParameter {
    requestLog(@"\n请求信息:\nURL: %@ \n参数: %@ \nJSON: %@",URLString,bodyParameter,[self dictionaryToJson:responseObject]);
}

+ (NSString*)dictionaryToJson:(NSDictionary *)dict
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

@end
