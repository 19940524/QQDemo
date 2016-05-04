//
//  ContacterListModel.h
//  QQDemo
//
//  Created by 薛国宾 on 16/5/2.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ContacterListModel : NSObject

@property (copy, nonatomic) NSString *nickname;
@property (copy, nonatomic) NSString *imageName;
@property (copy, nonatomic) NSString *signature;
@property (copy, nonatomic) NSString *network;
@property (copy, nonatomic) NSString *isOnLine;

@end
