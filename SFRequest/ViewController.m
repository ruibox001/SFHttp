//
//  ViewController.m
//  SFRequest
//
//  Created by 王声远 on 17/3/17.
//  Copyright © 2017年 王声远. All rights reserved.
//

#import "ViewController.h"
#import "SFHttpRequest.h"
#import "MyModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    get.url(@"http://www.weather.com.cn/data/sk/101110101.html").addPara(@{@"userId":@"111"}).addPara(@{@"userName":@"222"}).resolve(@"weatherinfo",@"MyModel",^(id model){
        if ([model isKindOfClass:[MyModel class]]) {
            NSLog(@"\n解析返回：%@",model);
        }
        else if ([model isKindOfClass:[NSArray class]]){
            for (MyModel *p in model) {
                NSLog(@"\n数组解析返回：%@",p);
            }
        }
   }).start();
}

@end
