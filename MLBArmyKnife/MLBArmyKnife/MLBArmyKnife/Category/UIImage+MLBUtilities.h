//
//  UIImage+MLBUtilities.h
//  MLBArmyKnife
//
//  Created by meilbn on 4/15/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import <UIKit/UIKit.h>

@import AssetsLibrary;

@interface UIImage (MLBUtilities)

/**
 *  根据给定的颜色生成一张图片
 *
 *  @param color 颜色
 *
 *  @return 生成的图片
 */
+ (UIImage *)mlb_imageWithColor:(UIColor *)color;

/**
 *  根据给定的颜色和 frame 生成一张图片
 *
 *  @param color 颜色
 *  @param frame frame
 *
 *  @return  生成的图片
 */
+ (UIImage *)mlb_imageWithColor:(UIColor *)color withFrame:(CGRect)frame;

+ (UIImage *)mlb_fullResolutionImageFromALAsset:(ALAsset *)asset;

+ (UIImage *)mlb_fullScreenImageALAsset:(ALAsset *)asset;

/**
 *  根据给定的大小生成一张图片
 *
 *  @param targetSize 大小
 *
 *  @return 生成的图片
 */
- (UIImage *)mlb_scaledToSize:(CGSize)targetSize;

/**
 *  根据给定的大小和是否高质量生成一张图片
 *
 *  @param targetSize  大小
 *  @param highQuality 是否高质量
 *
 *  @return 生成的图片
 */
- (UIImage *)mlb_scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality;

- (UIImage *)mlb_scaledToMaxSize:(CGSize )size;

@end
