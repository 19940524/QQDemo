//
//  MenuButton.m
//  QQDemo
//
//  Created by 薛国宾 on 16/4/27.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import "MenuButton.h"

@implementation MenuButton

- (id)init {
    self = [super init];
    if (self) {
        
        UIImage *image = [UIImage imageNamed:@"head_portrait"];
        self.frame = CGRectMake(0, 0, 40, 40);
        [self setImage:image forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        self.layer.cornerRadius = 20;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)showInNavigationItem:(UINavigationItem *)navigationItem {
    UIBarButtonItem *leftDrawerButton = [[UIBarButtonItem alloc] initWithCustomView:self];
    [navigationItem setLeftBarButtonItem:leftDrawerButton animated:NO];
}

#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender {
    if (self.leftDrawerButtonPress) {
        self.leftDrawerButtonPress();
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"frame"]) {
        CGFloat x = [[change objectForKey:NSKeyValueChangeNewKey] CGRectValue].origin.x;
        if (x >= 30 && x < 210) {
            self.alpha = fabs(x - 210) / 210;
        } else if (x >= 210) {
            self.alpha = 0;
        } else {
            self.alpha = 1;
        }
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
