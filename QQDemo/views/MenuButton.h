//
//  MenuButton.h
//  QQDemo
//
//  Created by 薛国宾 on 16/4/27.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuButton : UIButton

@property (copy, nonatomic) dispatch_block_t leftDrawerButtonPress;
- (void)showInNavigationItem:(UINavigationItem *)navigationItem;

@end
