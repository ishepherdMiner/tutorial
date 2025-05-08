//
//  CGDSocketManager.m
//  SocketDemo
//
//  Created by Shepherd on 2025/5/5.
//

#import "CGDSocketManager.h"
#import <CocoaAsyncSocket/GCDAsyncSocket.h>

@interface CGDSocketManager () <GCDAsyncSocketDelegate>

@property (nonatomic,strong) GCDAsyncSocket *gcdSocket;

@end

@implementation CGDSocketManager

+ (instancetype)sharedManager {
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)initSocket {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    _gcdSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:queue];
    
}

// 建立连接
- (BOOL)connect {
    return [_gcdSocket connectToHost:@"127.0.0.1" onPort:7878 error:nil];
}

// 断开连接
- (void)disconnect {
    [_gcdSocket disconnect];
}

// 发送消息
- (void)send:(NSString *)msg {
    NSData *data = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [_gcdSocket writeData:data withTimeout:-1 tag:110];
}

// 监听最新的消息
- (void)pullTheMsg {
    // 监听读数据的代理 -1永远监听，不超时，但是只收一次信息
    // 所以每次收到消息还需要调用调用一次
    [_gcdSocket readDataWithTimeout:-1 tag:110];
}

#pragma mark - GCDAsyncSocketDelegate
// 连接成功调用
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"连接成功,host:%@,port:%d",host,port);
       
    [self pullTheMsg];
    
    // 心跳写在这...
}

// 断开连接的时候调用
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    NSLog(@"断开连接,host:%@,port:%d",sock.localHost,sock.localPort);
    // 断线重连写在这...
}

// 写成功的回调
- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag {
    NSLog(@"写的回调,tag:%ld",tag);
}

// 收到消息的回调
- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    NSString *msg = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到消息：%@",msg);
    
    [self pullTheMsg];
}



@end
