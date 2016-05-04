//
//  HeadView.h
//  QQDemo
//
//  Created by 薛国宾 on 16/5/3.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DirectoryGroup;

@protocol HeadViewDelegate <NSObject>

@optional
- (void)clickHeadView;

@end

@interface HeadView : UITableViewHeaderFooterView

@property (nonatomic, strong) DirectoryGroup *directoryGroup;

@property (nonatomic, weak) id<HeadViewDelegate> delegate;

+ (instancetype)headViewWithTableView:(UITableView *)tableView;

- (void)setOnlineRatioText:(NSString *)onlineRatioText;

@end
