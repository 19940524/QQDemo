//
//  CircularLayer.m
//  LayerAnimation
//
//  Created by 薛国宾 on 16/4/23.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import "CircularLayer.h"

@interface CircularLayer ()
@property (strong, nonatomic) UIImage *photo;
@end

@implementation CircularLayer

- (id)initWithView:(CGFloat)wh image:(UIImage *)image {
    self = [super init];
    if (self) {
        self.photo = image;
        
        
        CGPoint position = CGPointMake(wh / 2, wh / 2);
        CGRect bounds = CGRectMake(0, 0, wh, wh);
        CGFloat cornerRadius = wh / 2;
        CGFloat borderWidth = 2;
        
        self.bounds = bounds;
        self.position = position;
        self.backgroundColor = [UIColor redColor].CGColor;
        self.cornerRadius = cornerRadius;
        //注意仅仅设置圆角，对于图形而言可以正常显示，但是对于图层中绘制的图片无法正确显示
        //如果想要正确显示则必须设置masksToBounds=YES，剪切子图层
        self.masksToBounds = YES;
        //阴影效果无法和masksToBounds同时使用，因为masksToBounds的目的就是剪切外边框，
        //而阴影效果刚好在外边框
        //设置边框
        self.borderColor = [UIColor whiteColor].CGColor;
        self.borderWidth = borderWidth;
        
        //设置图层代理
        self.delegate = self;

        [self setNeedsDisplay];
    }
    return self;
}

- (void)drawInContext:(CGContextRef)ctx {
    CGFloat height = self.frame.size.height;
    
    CGContextSaveGState(ctx);
    
    //图形上下文形变，解决图片倒立的问题
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -height);
    
    //注意这个位置是相对于图层而言的不是屏幕
    CGContextDrawImage(ctx, CGRectMake(0, 0, height, height), _photo.CGImage);
    
    CGContextRestoreGState(ctx);
}

+ (CALayer *)setShadow:(CGFloat)height shadowColor:(UIColor *)shadowColor shadowOffset:(CGSize)shadowSize {
    
    CALayer *shadow = [CALayer layer];
    shadow.bounds = CGRectMake(0, 0, height, height);
    shadow.position = CGPointMake(height / 2, height / 2);
    shadow.cornerRadius = height / 2;
    shadow.shadowColor = shadowColor.CGColor;
    shadow.shadowOffset = shadowSize;
    shadow.shadowOpacity = 1;
    shadow.borderColor = [UIColor whiteColor].CGColor;
    shadow.borderWidth = 2;
    return shadow;
}

- (CALayer *)addTranslucentLayer:(CGFloat)wh position:(CGPoint)position backgroundColor: (UIColor *)backgroundColor {
    CALayer *translucentLayer = [[CALayer alloc] init];
    translucentLayer.bounds = CGRectMake(0, 0, wh, wh);
    translucentLayer.position = position;
    translucentLayer.cornerRadius = wh / 2;
    translucentLayer.backgroundColor = backgroundColor.CGColor;
    return translucentLayer;
}

+ (CALayer *)addTranslucentLayer:(CGFloat)wh position:(CGPoint)position backgroundColor: (UIColor *)backgroundColor {
    CALayer *translucentLayer = [[CALayer alloc] init];
    translucentLayer.bounds = CGRectMake(0, 0, wh, wh);
    translucentLayer.position = position;
    translucentLayer.cornerRadius = wh / 2;
    translucentLayer.backgroundColor = backgroundColor.CGColor;
    return translucentLayer;
}

@end
