//
//  UIColor+MLBUtilities.h
//  MLBArmyKnife
//
//  Created by meilbn on 12/11/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (MLBUtilities)

@property (nonatomic, readonly) CGColorSpaceModel colorSpaceModel;
@property (nonatomic, readonly) BOOL canProvideRGBComponents;
@property (nonatomic, readonly) CGFloat red; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat green; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat blue; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat white; // Only valid if colorSpaceModel == kCGColorSpaceModelMonochrome
@property (nonatomic, readonly) CGFloat alpha;
@property (nonatomic, readonly) UInt32 rgbHex;

#pragma mark - Class Method

/**
 *  生成一个随机颜色
 *
 *  @return 随机颜色
 */
+ (UIColor *)randomColor;

/**
 *  根据 hex 值 生成对应的颜色
 *
 *  @param hex hex 值
 *
 *  @return 对应的颜色
 */
+ (UIColor *)colorWithRGBHex:(UInt32)hex;

/**
 *  根据 hex 字符串生成对应的颜色
 *
 *  @param stringToConvert  hex 字符串
 *
 *  @return 对应的颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

/**
 *  根据 hex 字符串和 alpha 值生成对应的颜色
 *
 *  @param stringToConvert  hex 字符串
 *  @param alpha            alpha 值
 *
 *  @return 对应的颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha;

@end
