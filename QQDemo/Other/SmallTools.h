//
//  SmallTools.h
//  QQDemo
//
//  Created by 薛国宾 on 16/4/25.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define CYColorFromRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define CYColorFromRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define CYColorFromRGBValue(rgbValue) [UIColor \ colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \ green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \ blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define CodeHere [NSString stringWithFormat: @"\n文件路径：%@\n行数：第%d行\n方法：%s", [NSString stringWithUTF8String:__FILE__], __LINE__,  __FUNCTION__]

#define CYAssert(condition, desc) NSAssert(condition, @"\n报错文件：%@\n报错行数：第%d行\n报错方法：%s\n错误描述：%@", [NSString stringWithUTF8String:__FILE__], __LINE__,  __FUNCTION__, desc)
#define CYAssertParamNotNil(param) GBAssert(param, [[NSString stringWithFormat:@#param] stringByAppendingString:@"参数不能为nil"])


#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
    block();\
} else {\
    dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
    block();\
} else {\
    dispatch_async(dispatch_get_main_queue(), block);\
}

#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define ScreenWidth [UIScreen mainScreen].bounds.size.width

//// 是否iPad
//#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//// 是否iPad
//#define someThing (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? ipad: iphone
//
////获取系统版本
//#define IOS_VERSION ［[UIDevice currentDevice] systemVersion] floatValue]
//#define CurrentSystemVersion ［UIDevice currentDevice] systemVersion]
//
////获取当前语言
//#define CurrentLanguage (［NSLocale preferredLanguages] objectAtIndex:0])
//
////判断是否 Retina屏、设备是否%fhone 5、是否是iPad
//#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), ［UIScreen mainScreen] currentMode].size) : NO)
//#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), ［UIScreen mainScreen] currentMode].size) : NO)
//#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//
////判断设备的操做系统是不是ios7
//#define IOS7 (［[UIDevice currentDevice].systemVersion doubleValue] >= 7.0]
//
////----------------------图片----------------------------
//
////读取本地图片
//#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:［NSBundle mainBundle]pathForResource:file ofType:ext］
//
////定义UIImage对象
//#define IMAGE(A) [UIImage imageWithContentsOfFile:［NSBundle mainBundle] pathForResource:A ofType:nil］
//
////定义UIImage对象
//#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer］

//建议使用前两种宏定义,性能高于后者

//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

typedef void(^AllowCall)(float indexSec);
@class SmallTools;
@class MenuButton;

@interface SmallTools : NSObject

@property (strong, nonatomic) MenuButton *newsButton;
@property (strong, nonatomic) MenuButton *contacterButton;
@property (strong, nonatomic) MenuButton *dynamicButton;

+ (SmallTools *)sharedManager;

+ (void)createTimer:(dispatch_source_t)timerSource allowCall:(AllowCall)block;

+ (UIViewController *)appRootViewController;

+ (MenuButton *)setupLeftMenuButton:(UINavigationItem *)navigationItem popMenu:(void(^)())block;

@end
