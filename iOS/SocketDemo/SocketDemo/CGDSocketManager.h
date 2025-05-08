//
//  CGDSocketManager.h
//  SocketDemo
//
//  Created by Shepherd on 2025/5/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGDSocketManager : NSObject

+ (instancetype)sharedManager;
- (BOOL)connect;
- (void)disconnect;

@end

NS_ASSUME_NONNULL_END
