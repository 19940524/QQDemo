//
//  AppDelegate.h
//  QQDemo
//
//  Created by 薛国宾 on 16/4/24.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MMDrawerController;

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    @private
    MMDrawerController *drawerController;
}

@property (strong, nonatomic) UIWindow *window;


@end

