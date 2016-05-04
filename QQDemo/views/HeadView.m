//
//  HeadView.m
//  QQDemo
//
//  Created by 薛国宾 on 16/5/3.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import "HeadView.h"
#import "DirectoryGroup.h"

@interface HeadView()
{
    UIButton *_bgButton;
}

@property (strong, nonatomic) UILabel *onlineRatio;

@end


@implementation HeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (instancetype)headViewWithTableView:(UITableView *)tableView {
	static NSString *headIdentifier = @"headView";
    HeadView *headView = (HeadView *)[tableView dequeueReusableCellWithIdentifier:headIdentifier];
    if (!headView) {
        headView = [[HeadView alloc] initWithReuseIdentifier:headIdentifier];
    }
    return headView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [bgButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
//        [bgButton setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        [bgButton setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [bgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        bgButton.imageView.contentMode = UIViewContentModeCenter;
        bgButton.imageView.clipsToBounds = NO;
        bgButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        bgButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        bgButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        bgButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [bgButton addTarget:self action:@selector(headBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [bgButton setBackgroundColor:[UIColor clearColor]];
        [self addSubview:bgButton];
        _bgButton = bgButton;
        
        UILabel *onlineRatio = [[UILabel alloc] init];
        onlineRatio.textAlignment = NSTextAlignmentRight;
        onlineRatio.font = [UIFont systemFontOfSize:14];
        onlineRatio.textColor = [UIColor colorWithRed:100 / 255.0f green:100 / 255.0f blue:100 / 255.0f alpha:1];
        onlineRatio.text = @"3/3";
        [self addSubview:onlineRatio];
        _onlineRatio = onlineRatio;
    }
    return self;
}

- (void)headBtnClick
{
    _directoryGroup.opened = !_directoryGroup.isOpened;
    if ([_delegate respondsToSelector:@selector(clickHeadView)]) {
        [_delegate clickHeadView];
    }
}

- (void)setDirectoryGroup:(DirectoryGroup *)directoryGroup
{
    _directoryGroup = directoryGroup;
    [_bgButton setTitle:directoryGroup.groupName forState:UIControlStateNormal];
    _bgButton.titleLabel.font = [UIFont systemFontOfSize:15];
    //    _numLabel.text = [NSString stringWithFormat:@"%ld", (long)directoryGroup.online];
}

- (void)didMoveToSuperview
{
    _bgButton.imageView.transform = _directoryGroup.isOpened ? CGAffineTransformMakeRotation(M_PI_2) : CGAffineTransformMakeRotation(0);
}

- (void)setOnlineRatioText:(NSString *)onlineRatioText {
    _onlineRatio.text = onlineRatioText;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _bgButton.frame = self.bounds;
    _onlineRatio.frame = CGRectMake(self.frame.size.width - 58, 15, 50, 20);
    //    _numLabel.frame = CGRectMake(self.frame.size.width - 70, 0, 60, self.frame.size.height);
}

@end
