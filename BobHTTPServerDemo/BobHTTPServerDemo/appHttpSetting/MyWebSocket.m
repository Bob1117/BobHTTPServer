#import "MyWebSocket.h"
#import "HTTPLogging.h"

// Log levels: off, error, warn, info, verbose
// Other flags : trace
static const int httpLogLevel = HTTP_LOG_LEVEL_WARN | HTTP_LOG_FLAG_TRACE;


@implementation MyWebSocket

singletonImplemention(MyWebSocket)

- (void)didOpen {
	HTTPLogTrace();
	
	[super didOpen];
    
	[self sendMessage:@"WebSocket调试"];
    NSLog(@"opened");
}

- (void)didReceiveMessage:(NSString *)msg {
	HTTPLogTrace2(@"%@[%p]: didReceiveMessage: %@", THIS_FILE, self, msg);
    [super didReceiveMessage:msg];
    self.msg = msg;
    NSLog(@"%@",msg);
//	[self sendMessage:@"didReceiveMessage"];
}

- (void)didClose {
	HTTPLogTrace();

	[super didClose];
    NSLog(@"closed");
   // [self start];
   // [self stop];
}

@end
