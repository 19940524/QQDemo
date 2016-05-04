//
//  NewsCell.h
//  QQDemo
//
//  Created by 薛国宾 on 16/4/28.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsListModel;

@interface NewsCell : UITableViewCell
- (void)setCellData:(NewsListModel *)dataModel;

@end
