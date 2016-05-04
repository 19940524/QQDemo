//
//  TransparentView.m
//  QQDemo
//
//  Created by 薛国宾 on 16/4/25.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import "TransparentView.h"
#import "SmallTools.h"

@implementation TransparentView

- (id)init {
    self = [super init];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        UIViewController *vc = [SmallTools appRootViewController];
        [vc.view addSubview:self];
        [vc.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[self]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
        [vc.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[self]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)]];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapEvent {
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

@end
