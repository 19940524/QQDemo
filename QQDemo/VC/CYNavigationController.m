//
//  CYNavigationController.m
//  QQDemo
//
//  Created by 薛国宾 on 16/4/24.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import "CYNavigationController.h"

@interface CYNavigationController ()

@end

@implementation CYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"header_bg_blue"] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
