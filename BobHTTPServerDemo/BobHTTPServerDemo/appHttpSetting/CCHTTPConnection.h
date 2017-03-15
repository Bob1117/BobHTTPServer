//
//  CCHTTPConnection.h
//  catClaw
//
//  Created by iOS Developer 1 on 16/3/11.
//  Copyright © 2016年 Joey. All rights reserved.
//

#import "HTTPConnection.h"
#import "MyWebSocket.h"
@interface CCHTTPConnection : HTTPConnection
{
    MyWebSocket *ws;
}
@end
