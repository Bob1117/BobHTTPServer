//
//  AppDelegate.h
//  BobHTTPServerDemo
//
//  Created by 吴豹 on 17/3/15.
//  Copyright © 2017年 stnts. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPServer.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//服务器对象
@property(nonatomic,strong)HTTPServer *localHttpServer;
//端口号
@property(nonatomic,copy)NSString *port;

@end

