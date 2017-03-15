//
//  AppDelegate.m
//  BobHTTPServerDemo
//
//  Created by 吴豹 on 17/3/15.
//  Copyright © 2017年 stnts. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "CCHTTPConnection.h"
@interface AppDelegate ()
//用来保持服务器持续运行
@property(nonatomic,strong)AVAudioPlayer *audioPlayer;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    NSString *docPath = [[NSBundle mainBundle]pathForResource:@"Web" ofType:nil];
    //查找文件存在不，不存在就转到沙盒中
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    if (![fileManager isExecutableFileAtPath:[HOME_DOCUMENT stringByAppendingString:@"/Web"]]) {
        //将本地的路径的web文件拷贝到document路径下（当然您也可以直接创建）
        BOOL filesPresent = [self copyMissingFile:docPath toPath:HOME_DOCUMENT];
        if (filesPresent) {
            NSLog(@"OK");
        }
        else
        {
            NSLog(@"NO");
        }
        
    } else {
        //        NSLog(@"已经存在");
    }

   
    [self setLog];
    [self playBackground];
    
    [self configLocalHttpServer];
    
    
    
    return YES;
}

#pragma mark -- 本地服务器 --
#pragma mark -服务器
#pragma mark - 搭建本地服务器 并且启动
- (void)configLocalHttpServer{
    //先停止之前的,再开启
    [_localHttpServer stop];
    _localHttpServer = [[HTTPServer alloc] init];
    //协议
    [_localHttpServer setType:@"_http.tcp"];
    //设置端口号
    [_localHttpServer setPort:12345];
    
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    if (![fileManager fileExistsAtPath:HOME_DOCUMENT]){
        
        NSLog(@"File path error!");
    }else{
        //获取到沙盒web下的路径
        NSString *webLocalPath = [HOME_DOCUMENT stringByAppendingString:@"/Web"];
        [_localHttpServer setDocumentRoot:webLocalPath];
        [self.localHttpServer setConnectionClass:[CCHTTPConnection class]];
        NSLog(@"webLocalPath:%@",webLocalPath);
        [self startServer];
    }
}
- (void)startServer
{
    NSError *error;
    if([_localHttpServer start:&error]){
        
        NSLog(@"start server success in port : %d  name : %@",[_localHttpServer listeningPort],[_localHttpServer publishedName]);
        
    }
    else{
        NSLog(@"Error starting HTTP Server: %@", error);
    }
}


#pragma 打印服务器状态
- (void)setLog
{
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor greenColor] backgroundColor:[UIColor clearColor] forFlag:LOG_FLAG_INFO];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor yellowColor] backgroundColor:[UIColor clearColor] forFlag:LOG_FLAG_WARN];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor] backgroundColor:[UIColor clearColor] forFlag:LOG_FLAG_ERROR];
}
#pragma 保持服务器持久运行
- (void)playBackground {
    
    NSError *setCategoryErr = nil;
    NSError *activationErr  = nil;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback withOptions:kAudioSessionProperty_OverrideCategoryMixWithOthers error: &setCategoryErr];
    [[AVAudioSession sharedInstance] setActive:YES error: &activationErr];
    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"background" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:musicPath];
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_audioPlayer prepareToPlay];
    [_audioPlayer setVolume:1];
    _audioPlayer.numberOfLoops = -1; //设置音乐播放次数  -1为一直循环
    [_audioPlayer play];
}
#pragma 将本地的web文件移动到沙盒中
- (BOOL)copyMissingFile:(NSString *)sourcePath toPath:(NSString *)toPath
{
    BOOL retVal = YES; // If the file already exists, we'll return success…
    NSString * finalLocation = [toPath stringByAppendingPathComponent:[sourcePath lastPathComponent]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:finalLocation])
    {
        retVal = [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:finalLocation error:NULL];
    }
    return retVal;
}



@end
