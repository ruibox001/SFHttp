//
//  MyModel.m
//  SFRequest
//
//  Created by 王声远 on 17/3/21.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "MyModel.h"

@implementation MyModel

/*
 @property (nonatomic,strong) NSString *time;
 @property (nonatomic,strong) NSString *WD;
 @property (nonatomic,strong) NSString *city;
 @property (nonatomic,strong) NSString *njd;
 @property (nonatomic,assign) NSInteger temp;*/

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ - %@ - %@ - %@ - %ld",self.time,self.WD,self.city,self.njd,self.temp];
}

@end
