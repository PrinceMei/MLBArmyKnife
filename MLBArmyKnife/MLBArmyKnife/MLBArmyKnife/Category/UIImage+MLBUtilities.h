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

#pragma mark - Class Methods

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
 *  生成二维码
 *
 *  @param qrString        二维码中带的字符串
 *  @param scale           缩放, like 5
 *  @param color           颜色
 *  @param backgroundColor 背景色
 *
 *  @return 二维码
 */
+ (UIImage *)mlb_generateQRCodeImageWithString:(NSString *)qrString scale:(CGFloat)scale color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor;

/**
 *  生成条形码
 *
 *  @param codeString      条形码中的数字
 *  @param scale           缩放
 *  @param color           颜色
 *  @param backgroundColor 背景色
 *
 *  @return 条形码
 */
+ (UIImage *)mlb_generateBarcodeImageWithString:(NSString *)codeString scale:(CGFloat)scale color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor;

/**
 *  根据 view 创建 image
 *
 *  @param view   view
 *  @param frame  frame
 *  @param insets insets
 *
 *  @return image
 */
+ (UIImage *)renderImageFromView:(UIView *)view withRect:(CGRect)frame transparentInsets:(UIEdgeInsets)insets;

/**
 *  加载图片
 *
 *  @param name    图片名
 *  @param isCache 是否缓存
 *
 *  @return 图片
 */
+ (UIImage *)mlb_imageWithNamed:(NSString *)name cache:(BOOL)isCache;

/**
 *  加载图片
 *
 *  @param name    图片名
 *  @param type    图片类型
 *  @param isCache 是否缓存
 *
 *  @return 图片
 */
+ (UIImage *)mlb_imageWithNamed:(NSString *)name fileType:(NSString *)type cache:(BOOL)isCache;

#pragma mark - Public Methods

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
