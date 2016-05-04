//
//  ContacterCell.m
//  QQDemo
//
//  Created by 薛国宾 on 16/5/2.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import "ContacterCell.h"
#import "ContacterListModel.h"

@interface ContacterCell () {
    
    __weak IBOutlet UIImageView *headerphoto;
    __weak IBOutlet UILabel *nameLabel;
    __weak IBOutlet UILabel *isOnLineLabel;
    __weak IBOutlet UILabel *signatureLabel;
    __weak IBOutlet UILabel *networkLabel;
}

@end

@implementation ContacterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setCellData:(ContacterListModel *)modelData {
    headerphoto.image   = [UIImage imageNamed:modelData.imageName];
    nameLabel.text      = modelData.nickname;
    isOnLineLabel.text  = modelData.isOnLine;
    signatureLabel.text = modelData.signature;
    networkLabel.text   = modelData.network;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
