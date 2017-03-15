#import <Foundation/Foundation.h>
#import "WebSocket.h"
#import "singleton.h"
@interface MyWebSocket : WebSocket
{
	
}
singletonInterface(MyWebSocket)

@property (nonatomic, copy) NSString *msg;
@end
