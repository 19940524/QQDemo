//
//  NewsCell.m
//  QQDemo
//
//  Created by 薛国宾 on 16/4/28.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import "NewsCell.h"
#import "NewsListModel.h"
#import "WHC_BadgeView.h"
#import "SmallTools.h"

#define PNRed           [UIColor colorWithRed:245.0 / 255.0 green:74.0 / 255.0 blue:63.0 / 255.0 alpha:1.0f]

@interface NewsCell ()

@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headPortraitView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//@property (strong, nonatomic) WHC_BadgeView *badgeView;

@end

@implementation NewsCell
@synthesize nicknameLabel;
@synthesize messageLabel;
@synthesize headPortraitView;
@synthesize timeLabel;
//@synthesize mesNumView;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    headPortraitView.layer.cornerRadius = headPortraitView.frame.size.height / 2;
    headPortraitView.layer.masksToBounds = YES;
    self.clipsToBounds = NO;
//    self.badgeView = [[WHC_BadgeView alloc]initWithSuperView:self position:CGPointMake(ScreenWidth - 50.0, 27.0) radius:10.0];
}

- (void)setCellData:(NewsListModel *)dataModel {
    nicknameLabel.text      = dataModel.nickname;
    messageLabel.text       = dataModel.message;
    headPortraitView.image  = [UIImage imageNamed:dataModel.imageName];
    timeLabel.text          = dataModel.time;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
