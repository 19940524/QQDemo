//
//  AppDelegate.m
//  QQDemo
//
//  Created by 薛国宾 on 16/4/24.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import "AppDelegate.h"
#import "SmallTools.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "MMExampleDrawerVisualStateManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    [self initDrawer];
    
    return YES;
}

- (void)initDrawer {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *rootVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    UIViewController *menuVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"menu"];
    drawerController = [[MMDrawerController alloc]
                        initWithCenterViewController:rootVC
                            leftDrawerViewController:menuVC];
    
    [drawerController setDrawerVisualStateBlock:[MMDrawerVisualState slideAndScaleVisualStateBlock]];
    [drawerController setMaximumLeftDrawerWidth:self.window.frame.size.width * 0.75f];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [[MMExampleDrawerVisualStateManager sharedManager] setRightDrawerAnimationType:MMDrawerAnimationTypeParallax];
    drawerController.showsShadow = NO;
    drawerController.shouldStretchDrawer = NO;
    [drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerCont, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager] drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerCont, drawerSide, percentVisible);
         }
     }];
    self.window.rootViewController = drawerController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
