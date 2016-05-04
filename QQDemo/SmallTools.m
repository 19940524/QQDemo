//
//  SmallTools.m
//  QQDemo
//
//  Created by 薛国宾 on 16/4/25.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import "SmallTools.h"
#import "MenuButton.h"

@implementation SmallTools

+ (SmallTools *)sharedManager {
    static SmallTools *sharedManager = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

+ (void)createTimer:(dispatch_source_t)timerSource allowCall:(AllowCall)block {
    
    double interval = 0.05f * NSEC_PER_SEC;
    dispatch_source_set_timer(timerSource, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    __block float i = 0;
    dispatch_source_set_event_handler(timerSource, ^{
        i += 0.5f;
        dispatch_main_sync_safe(^{
//            NSLog(@"i = %f",i);
            block(i);
        });
    });
    dispatch_resume(timerSource);
}

+ (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

+ (MenuButton *)setupLeftMenuButton:(UINavigationItem *)navigationItem popMenu:(void(^)())block {
    MenuButton *menuBtn = [[MenuButton alloc] init];
    [menuBtn showInNavigationItem:navigationItem];
    menuBtn.leftDrawerButtonPress = ^{
        block();
    };
    return menuBtn;
}

@end
