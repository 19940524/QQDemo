//
//  CircularLayer.h
//  LayerAnimation
//
//  Created by 薛国宾 on 16/4/23.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CircularLayer : CALayer

- (id)initWithView:(CGFloat)wh image:(UIImage *)image;
+ (CALayer *)setShadow:(CGFloat)height shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowSize;


- (CALayer *)addTranslucentLayer:(CGFloat)wh position:(CGPoint)position backgroundColor: (UIColor *)backgroundColor;
+ (CALayer *)addTranslucentLayer:(CGFloat)wh position:(CGPoint)position backgroundColor: (UIColor *)backgroundColor;

@end
