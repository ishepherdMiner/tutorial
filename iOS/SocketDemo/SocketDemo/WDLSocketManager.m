//
//  WDLSocketManager.m
//  SocketDemo
//
//  Created by Shepherd on 2025/5/4.
//

#import "WDLSocketManager.h"
#import <sys/socket.h>
#import <sys/types.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@interface WDLSocketManager ()

@property (nonatomic,assign) int clientSocket;

@end

@implementation WDLSocketManager

+ (instancetype)sharedManager {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        _clientSocket = -1;
        [self pullMsg];
    }
    return self;
}

- (void)initSocket {
    // 断开连接
    if (_clientSocket != -1) {
        [self disconnect];
        _clientSocket = -1;
    }
    
    // 创建客户端socket
    _clientSocket = createClientSocket();
    
    // 等于0说明连接失败
    if(connectToServer(_clientSocket) == 0) {
        printf("Connect to server error\n");
        return ;
    }
    printf("Connect to server OK\n");
}

static int createClientSocket(void) {
    /// 创建Socket
    /// 第一个参数addressFamily IPv4(AF_INET)或IPv6(AF_INET6)
    /// 第二个参数type表示Socket的类型,通常是流stream(SOCK_STREAM)或数据报文datagram(SOCK_DGRAM)
    /// 第三个参数 protocol 参数通常设置为0,以便让系统自动适合的协议，对于stream socket来说会是TCP协议(IPPROTO_TCP),而对于datagram来说会是UDP协议(IPPROTO_UDP)
    return socket(AF_INET, SOCK_STREAM, 0);
}

static int connectToServer(int clientSocket) {
    // 服务器IP
    const char *severIp = "127.0.0.1";
    
    // 服务端端口
    short serverPort = 7878;
    
    // 生成一个sockaddr_in类型结构体
    struct sockaddr_in sAddr = {};
    // socket长度
    sAddr.sin_len = sizeof(sAddr);
    // IPv4
    sAddr.sin_family = AF_INET;
    
    /// 字符串IP转成32位的网络序列IP地址
    /// 若这个函数成功,函数的返回值非零,如果输入地址不正确则会返回零
    int success = inet_aton(severIp,&sAddr.sin_addr);
    if (success) {
        // htons是将整形变量从主机字节顺序转变成网络字节顺序,赋值端口号
        sAddr.sin_port = htons(serverPort);
        
        // 用socket和服务端地址,发起连接
        // 客户端向特定网络地址的服务器发送请求连接，连接成功返回0，失败返回 -1
        // 注意: 该接口调用会阻塞当前线程,直到服务器返回
        if(connect(clientSocket, (struct sockaddr *)&sAddr, sizeof(sAddr)) == 0) {
            return clientSocket;
        }
    }
    
    return 0;
}

- (void)pullMsg {
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(receiveAction:) object:nil];
    [thread start];
}

- (void)receiveAction:(NSString *)msg {
    while(YES) {
        if (self.clientSocket == -1) {
            continue;
        }
        char recvMsg[1024] = {0};
        recv(self.clientSocket, recvMsg, sizeof(recvMsg), 0);
        printf("%s\n",recvMsg);
    }
}

- (void)dealloc {
    printf("%s",__FUNCTION__);
}

#pragma mark - Public

- (void)connect {
    [self initSocket];
}

- (void)disconnect {
    close(self.clientSocket);
}

/// 发送消息
- (void)send:(NSString *)msg {
    const char *sendMsg = [msg UTF8String];
    send(self.clientSocket, sendMsg, strlen(sendMsg) + 1, 0);
}

@end
