//
//  UIImageView+MLBSDImageLoader.m
//  MLBArmyKnife
//
//  Created by meilbn on 4/18/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "UIImageView+MLBSDImageLoader.h"

@implementation UIImageView (MLBSDImageLoader)

/**
 *  加载网络图片，默认保存
 *
 *  @param url                  图片地址
 *  @param placeholderImageName 占位图
 */
- (void)mlb_sd_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage {
	[self mlb_sd_setImageWithURL:url placeholderImage:placeholderImage storeImage:YES];
}

/**
 *  加载网络图片
 *
 *  @param url              图片地址
 *  @param placeholderImage 占位图
 *  @param storeImage       是否保存网络图片
 */
- (void)mlb_sd_setImageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholderImage storeImage:(BOOL)storeImage {
	if ([[SDImageCache sharedImageCache] diskImageExistsWithKey:url]) {
		self.image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url];
	} else {
		[self sd_setImageWithURL:[url mlb_encodedURL] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
			if (storeImage) {
				dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
					[[SDImageCache sharedImageCache] storeImage:image forKey:url toDisk:YES];
				});
			}
		}];
	}
}

@end
