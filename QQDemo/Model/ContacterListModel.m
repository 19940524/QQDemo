//
//  ContacterListModel.m
//  QQDemo
//
//  Created by 薛国宾 on 16/5/2.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import "ContacterListModel.h"
#import "MJExtension.h"

@implementation ContacterListModel
@synthesize imageName;

- (void)setImageName:(NSString *)name {
    if ([name hasPrefix:@"contacter"]) {
        imageName = [NSString stringWithFormat:@"ContacterImage.bundle/%@.jpg",name];
    }  else {
        imageName = [NSString stringWithFormat:@"ContacterImage.bundle/%@",name];
    }
}

@end
