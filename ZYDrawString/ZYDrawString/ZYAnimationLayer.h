//
//  ZYAnimationLayer.h
//  ZYDrawString
//
//  Created by soufun on 15-1-9.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
@interface ZYAnimationLayer : CALayer
+(void)createAnimationLayerWithString:(NSString*)string andRect:(CGRect)rect andView:(UIView*)view andFont:(CTFontRef)font andStrokeColor:(UIColor*)color;
@end
