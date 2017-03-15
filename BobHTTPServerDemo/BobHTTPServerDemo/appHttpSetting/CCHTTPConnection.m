//
//  CCHTTPConnection.m
//  catClaw
//
//  Created by iOS Developer 1 on 16/3/11.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "CCHTTPConnection.h"
#import "CCHttpDataReponse.h"
#import "MJExtension.h"
#import "HTTPDynamicFileResponse.h"
#import "HTTPMessage.h"
#import "GCDAsyncSocket.h"


@interface CCHTTPConnection ()

@end


@implementation CCHTTPConnection



- (BOOL) supportsMethod:(NSString *)method atPath:(NSString *)path
{
    //This is very important, if not this code, no response when uploading
    if ([method isEqualToString:@"POST"] && [path isEqualToString:@"/index.html"])
        return YES;
    return [super supportsMethod:method atPath:path];
}

- (BOOL) expectsRequestBodyFromMethod:(NSString *)method atPath:(NSString *)path
{
    
    DDLogCInfo(@"%@",path);
    //通过这个判断访问的是localhost:12345/apps接口
    if ([path hasPrefix:@"/apps?"]) {
        NSString *senderStr = [path substringFromIndex:6];
        NSLog(@"后面就是接收到传递的参数值: %@",senderStr);
        
    }
    
    return [super expectsRequestBodyFromMethod:method atPath:path];
}


- (NSObject<HTTPResponse> *) httpResponseForMethod:(NSString *)method URI:(NSString *)path
{
    if ([path isEqualToString:@"/asdasds.html"]){
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSArray *arr = @[@{
                             @"Name" : @"Alfreds Futterkiste",
                             @"City" : @"Berlin",
                             @"Country" : @"Germany"
                             },
                         @{
                             @"Name" : @"Joey",
                             @"City" : @"Beijing",
                             @"Country" : @"China"
                             },
                         @{
                             @"Name" : @"美国队长",
                             @"City" : @"纽约",
                             @"Country" : @"当然是美国啦"
                             },
                         ];
        [dic setObject:arr forKey:@"records"];
        NSData *data =[dic mj_JSONData];
        
        CCHttpDataReponse *response = [[CCHttpDataReponse alloc] initWithData:data];
        
        return response;
    }
    
    
    // webSocket部分
    if ([path isEqualToString:@"/ios10.html"])
    {
        NSString *wsLocation;
        
        NSString *wsHost = [request headerField:@"Host"];
        if (wsHost == nil)
        {
            NSString *port = [NSString stringWithFormat:@"%hu", [asyncSocket localPort]];
            wsLocation = [NSString stringWithFormat:@"ws://localhost:%@/service", port];
        }
        else
        {
            wsLocation = [NSString stringWithFormat:@"ws://%@/service", wsHost];
        }
        
        NSDictionary *replacementDict = [NSDictionary dictionaryWithObject:wsLocation forKey:@"ws://localhost:63341/service"];
        
        return [[HTTPDynamicFileResponse alloc] initWithFilePath:[self filePathForURI:path]
                                                   forConnection:self
                                                       separator:@"%%"
                                           replacementDictionary:replacementDict];
    }
    
    return [super httpResponseForMethod:method URI:path];
}



- (WebSocket *)webSocketForURI:(NSString *)path {
    
    if([path isEqualToString:@"/service"])
    {
        
        return [[MyWebSocket alloc] initWithRequest:request socket:asyncSocket];
    }
    
    return [super webSocketForURI:path];
}




@end
