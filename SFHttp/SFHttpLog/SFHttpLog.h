//
//  SFLogFormatJSON.h
//  SofficeMoi
//
//  Created by soffice on 6/2/16.
//  Copyright © 2016 Soffice. All rights reserved.
//

#import <Foundation/Foundation.h>

#define HYString [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent
#define requestLog(...) printf("%s 第%d行: %s\n", [HYString UTF8String] ,__LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);

@interface SFHttpLog : NSObject

+ (void) log:(id)responseObject
         url:(NSString *)URLString
   parameter:(NSDictionary *)bodyParameter;

@end
