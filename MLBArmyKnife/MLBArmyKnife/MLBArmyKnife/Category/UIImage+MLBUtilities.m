//
//  UIImage+MLBUtilities.m
//  MLBArmyKnife
//
//  Created by meilbn on 4/15/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "UIImage+MLBUtilities.h"

@implementation UIImage (MLBUtilities)

#pragma mark - Class Methods

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
 *  生成二维码
 *
 *  @param qrString        二维码中带的字符串
 *  @param scale           缩放, like 5
 *  @param color           颜色
 *  @param backgroundColor 背景色
 *
 *  @return 二维码
 */
+ (UIImage *)mlb_generateQRCodeImageWithString:(NSString *)qrString scale:(CGFloat)scale color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor {
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    if (!qrFilter) {
        NSLog(@"Error: Could not load filter");
        return nil;
    }
    
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];//NSISOLatin1StringEncoding
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    
    CIFilter *colorQRFilter = [CIFilter filterWithName:@"CIFalseColor"];
    [colorQRFilter setValue:qrFilter.outputImage forKey:@"inputImage"];
    
    // 二维码颜色
    if (color == nil) {
        color = [UIColor blackColor];
    }
    
    if (backgroundColor == nil) {
        backgroundColor = [UIColor whiteColor];
    }
    
    [colorQRFilter setValue:[CIColor colorWithCGColor:color.CGColor] forKey:@"inputColor0"];
    // 背景颜色
    [colorQRFilter setValue:[CIColor colorWithCGColor:backgroundColor.CGColor] forKey:@"inputColor1"];
    
    CIImage *ciImage = colorQRFilter.outputImage;
    
    UIImage *qrCodeImage = [self createNonInterpolatedUIImageFromCIImage:ciImage withScale:scale * [UIScreen mainScreen].scale];
    
    return qrCodeImage;
}

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
+ (UIImage *)mlb_generateBarcodeImageWithString:(NSString *)codeString scale:(CGFloat)scale color:(UIColor *)color backgroundColor:(UIColor *)backgroundColor {
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    if (!filter) {
        NSLog(@"Error: Could not load filter");
        return nil;
    }
    
    NSData *data = [codeString dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    [filter setValue:data forKey:@"inputMessage"];
    
    CIFilter * colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    [colorFilter setValue:filter.outputImage forKey:@"inputImage"];
    
    // 条形码颜色
    if (color == nil) {
        color = [UIColor blackColor];
    }
    
    if (backgroundColor == nil) {
        backgroundColor = [UIColor whiteColor];
    }
    
    [colorFilter setValue:[CIColor colorWithCGColor:color.CGColor] forKey:@"inputColor0"];
    // 背景颜色
    [colorFilter setValue:[CIColor colorWithCGColor:backgroundColor.CGColor] forKey:@"inputColor1"];
    
    CIImage *ciImage = colorFilter.outputImage;
    
    UIImage *barCodeImage = [self createNonInterpolatedUIImageFromCIImage:ciImage withScale:scale * [UIScreen mainScreen].scale];
    
    return barCodeImage;
}

+ (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image withScale:(CGFloat)scale {
    // Render the CIImage into a CGImage
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:image fromRect:image.extent];
    // Now we'll rescale using CoreGraphics
    UIGraphicsBeginImageContext(CGSizeMake(image.extent.size.width * scale, image.extent.size.width * scale));
    CGContextRef context = UIGraphicsGetCurrentContext();
    // We don't want to interpolate (since we've got a pixel-correct image)
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    // Get the image out
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // Tidy up
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    
    return scaledImage;
}

/**
 *  根据 view 创建 image
 *
 *  @param view
 *
 *  @return image
 */
+ (UIImage *)captureView:(UIView *)view {
	// hide controls if needed
	CGRect rect = view.bounds;
	
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetShouldAntialias(context, true);
	CGContextSetAllowsAntialiasing(context, true);
	
	[view.layer renderInContext:context];
	
	UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return img;
}

/**
 *  加载图片
 *
 *  @param name    图片名
 *  @param isCache 是否缓存
 *
 *  @return 图片
 */
+ (UIImage *)mlb_imageWithNamed:(NSString *)name cache:(BOOL)isCache {
	return [UIImage mlb_imageWithNamed:name fileType:@"png" cache:isCache];
}

/**
 *  加载图片
 *
 *  @param name    图片名
 *  @param type    图片类型
 *  @param isCache 是否缓存
 *
 *  @return 图片
 */
+ (UIImage *)mlb_imageWithNamed:(NSString *)name fileType:(NSString *)type cache:(BOOL)isCache {
	if (isCache) {
		return [UIImage imageNamed:name];
	} else {
		NSString *pathOfImage = [[NSBundle mainBundle] pathForResource:name ofType:type];
		
		return [UIImage imageWithContentsOfFile:pathOfImage];
	}
}

#pragma mark - Public Methods

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
