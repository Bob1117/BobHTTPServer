//
//  CCHttpDataReponse.m
//  catClaw
//
//  Created by iOS Developer 1 on 16/3/11.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "CCHttpDataReponse.h"

@implementation CCHttpDataReponse

- (NSDictionary *)httpHeaders
{
    return @{@"Access-Control-Allow-Origin":@"*",@"Access-Control-Allow-Methods": @"GET" };
}


@end
