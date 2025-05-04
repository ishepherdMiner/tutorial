//
//  PersonViewController.m
//  KVODemo
//
//  Created by Shepherd on 2025/5/3.
//

#import "PersonViewController.h"
#import "Person.h"

@interface PersonViewController ()

@property (nonatomic,strong) Person *person;

@end

@implementation PersonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [[Person alloc] init];
    self.person.name = @"Wang";
    [self.person addObserver:self
                  forKeyPath:@"name"
                     options:NSKeyValueObservingOptionNew
                     context:nil];
    self.person.name = @"Li";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"name"]) {
        if ([change objectForKey:NSKeyValueChangeNewKey]) {
            NSLog(@"[OC]New name is:%@",[change objectForKey:NSKeyValueChangeNewKey]);
        }
    }
}

@end
