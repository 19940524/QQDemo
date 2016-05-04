//
//  DirectoryGroup.m
//  QQDemo
//
//  Created by 薛国宾 on 16/5/2.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import "DirectoryGroup.h"
#import "MJExtension.h"

@implementation DirectoryGroup

+ (NSArray *)getContLocalResource {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"ContacterList.plist" withExtension:nil];
    NSArray *tempArr = [NSArray arrayWithContentsOfURL:url];
    
    [DirectoryGroup mj_setupObjectClassInArray:^NSDictionary *{
        return @{@"directorys" : @"ContacterListModel"};
    }];
    
    NSArray *modelArr = [DirectoryGroup mj_objectArrayWithKeyValuesArray:tempArr];
    return modelArr;
}

@end
