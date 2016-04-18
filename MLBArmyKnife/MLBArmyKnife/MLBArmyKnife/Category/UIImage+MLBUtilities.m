//
//  UIImage+MLBUtilities.m
//  MLBArmyKnife
//
//  Created by meilbn on 4/15/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "UIImage+MLBUtilities.h"

@implementation UIImage (MLBUtilities)

/**
 *  根据给定的颜色生成一张图片
 *
 *  @param color 颜色
 *
 *  @return 生成的图片
 */
+ (UIImage *)mlb_imageWithColor:(UIColor *)color {
    return [UIImage mlb_imageWithColor:color withFrame:CGRectMake(0, 0, 1, 1)];
}

/**
 *  根据给定的颜色和 frame 生成一张图片
 *
 *  @param color 颜色
 *  @param frame frame
 *
 *  @return  生成的图片
 */
+ (UIImage *)mlb_imageWithColor:(UIColor *)color withFrame:(CGRect)frame {
    UIGraphicsBeginImageContext(frame.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

+ (UIImage *)mlb_fullResolutionImageFromALAsset:(ALAsset *)asset {
    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
    CGImageRef imgRef = [assetRep fullResolutionImage];
    UIImage *img = [UIImage imageWithCGImage:imgRef scale:assetRep.scale orientation:(UIImageOrientation)assetRep.orientation];
    
    return img;
}

+ (UIImage *)mlb_fullScreenImageALAsset:(ALAsset *)asset {
    ALAssetRepresentation *assetRep = [asset defaultRepresentation];
    CGImageRef imgRef = [assetRep fullScreenImage];//fullScreenImage已经调整过方向了
    UIImage *img = [UIImage imageWithCGImage:imgRef];
    
    return img;
}

/**
 *  根据给定的大小生成一张图片
 *
 *  @param targetSize 大小
 *
 *  @return 生成的图片
 */
- (UIImage *)mlb_scaledToSize:(CGSize)targetSize {
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat scaleFactor = 0.0;
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        CGFloat widthFactor = targetSize.width / imageSize.width;
        CGFloat heightFactor = targetSize.height / imageSize.height;
        if (widthFactor < heightFactor)
            scaleFactor = heightFactor; // scale to fit height
        else
            scaleFactor = widthFactor; // scale to fit width
    }
    
    scaleFactor = MIN(scaleFactor, 1.0);
    CGFloat targetWidth = imageSize.width* scaleFactor;
    CGFloat targetHeight = imageSize.height* scaleFactor;
    
    targetSize = CGSizeMake(floorf(targetWidth), floorf(targetHeight));
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    [sourceImage drawInRect:CGRectMake(0, 0, ceilf(targetWidth), ceilf(targetHeight))];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        //        DebugLog(@"could not scale image");
        newImage = sourceImage;
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  根据给定的大小和是否高质量生成一张图片
 *
 *  @param targetSize  大小
 *  @param highQuality 是否高质量
 *
 *  @return 生成的图片
 */
- (UIImage *)mlb_scaledToSize:(CGSize)targetSize highQuality:(BOOL)highQuality {
    if (highQuality) {
        targetSize = CGSizeMake(2*targetSize.width, 2*targetSize.height);
    }
    
    return [self mlb_scaledToSize:targetSize];
}

- (UIImage *)mlb_scaledToMaxSize:(CGSize )size {
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    CGFloat oldWidth = self.size.width;
    CGFloat oldHeight = self.size.height;
    
    CGFloat scaleFactor = (oldWidth > oldHeight) ? width / oldWidth : height / oldHeight;
    
    // 如果不需要缩放
    if (scaleFactor > 1.0) {
        return self;
    }
    
    CGFloat newHeight = oldHeight * scaleFactor;
    CGFloat newWidth = oldWidth * scaleFactor;
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
