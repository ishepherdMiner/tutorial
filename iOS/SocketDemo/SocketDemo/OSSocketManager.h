//
//  OSSocketManager.h
//  SocketDemo
//
//  Created by Shepherd on 2025/5/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OSSocketManager : NSObject

+ (instancetype)sharedManager;
- (void)connect;
- (void)disconnect;
- (void)send:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
