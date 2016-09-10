//
//  UIImageView+MLBSDImageLoader.h
//  MLBArmyKnife
//
//  Created by meilbn on 4/18/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (MLBSDImageLoader)

/**
 *  加载网络图片，默认保存
 *
 *  @param url                  图片地址
 *  @param placeholderImageName 占位图
 */
- (void)mlb_sd_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage;

/**
 *  加载网络图片
 *
 *  @param url              图片地址
 *  @param placeholderImage 占位图
 *  @param storeImage       是否保存网络图片
 */
- (void)mlb_sd_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage storeImage:(BOOL)storeImage;

@end
