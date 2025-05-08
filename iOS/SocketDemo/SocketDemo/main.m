//
//  main.m
//  SocketDemo
//
//  Created by Shepherd on 2025/5/4.
//

#import <Foundation/Foundation.h>
#import "OSSocketManager.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        OSSocketManager *mg = [OSSocketManager sharedManager];
        [mg connect];
        while (YES) {
            sleep(1);
            [mg send:@"Hello world"];
        }
        
    }
    return 0;
}
