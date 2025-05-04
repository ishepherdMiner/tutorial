//
//  Person.m
//  KVODemo
//
//  Created by Shepherd on 2025/5/3.
//

#import "Person.h"

@implementation Person

// 重写下面任意一个方法就会使KVO失效

//- (void)willChangeValueForKey:(NSString *)key {
//    NSLog(@"will:%@",key);
//}
//
//- (void)didChangeValueForKey:(NSString *)key {
//    NSLog(@"did:%@",key);
//}

@end
