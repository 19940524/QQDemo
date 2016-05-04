//
//  NewsListModel.h
//  QQDemo
//
//  Created by 薛国宾 on 16/4/28.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsListModel : NSObject

@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *message;
@property (copy, nonatomic) NSString *imageName;
@property (copy, nonatomic) NSString *time;
@property (copy, nonatomic) NSString *messageNumber;

+ (NSArray *)getLocalResource;

@end
