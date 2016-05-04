//
//  NewsListModel.m
//  QQDemo
//
//  Created by 薛国宾 on 16/4/28.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import "NewsListModel.h"
#import "MJExtension.h"

@implementation NewsListModel

+ (NSArray *)getLocalResource {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"NewsList.plist" withExtension:nil];
    NSArray *tempArr = [NSArray arrayWithContentsOfURL:url];
    NSArray *modelArr = [NewsListModel mj_objectArrayWithKeyValuesArray:tempArr];
    return modelArr;
}

@end
