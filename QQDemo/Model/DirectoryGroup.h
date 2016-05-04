//
//  DirectoryGroup.h
//  QQDemo
//
//  Created by 薛国宾 on 16/5/2.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DirectoryGroup : NSObject

@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, strong) NSArray *directorys; //@[ContacterListModel...]
@property (nonatomic, assign, getter = isOpened) BOOL opened;
+ (NSArray *)getContLocalResource;

@end
