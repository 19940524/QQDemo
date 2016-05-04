//
//  ContacterCell.h
//  QQDemo
//
//  Created by 薛国宾 on 16/5/2.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ContacterListModel;

@interface ContacterCell : UITableViewCell
- (void)setCellData:(ContacterListModel *)modelData;

@end
