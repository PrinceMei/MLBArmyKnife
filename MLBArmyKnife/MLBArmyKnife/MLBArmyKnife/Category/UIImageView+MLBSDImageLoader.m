//
//  UIImageView+MLBSDImageLoader.m
//  MLBArmyKnife
//
//  Created by meilbn on 4/18/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "UIImageView+MLBSDImageLoader.h"

@implementation UIImageView (MLBSDImageLoader)

- (void)mlb_sd_setImageWithURL:(NSString *)url placeholderImageName:(NSString *)placeholderImageName {
    [self mlb_sd_setImageWithURL:url placeholderImageName:placeholderImageName storeImage:NO];
}

- (void)mlb_sd_setImageWithURL:(NSString *)url placeholderImageName:(NSString *)placeholderImageName storeImage:(BOOL)storeImage {
//    if ([[SDImageCache sharedImageCache] diskImageExistsWithKey:url]) {
//        self.image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url];
//    } else {
//        UIImage *placeholderImage;
//        if (IsStringNotEmpty(placeholderImageName)) {
//            placeholderImage = [UIImage imageNamed:placeholderImageName];
//        }
//        [self sd_setImageWithURL:[url mlb_encodedURL] placeholderImage:placeholderImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//            if (storeImage) {
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    [[SDImageCache sharedImageCache] storeImage:image forKey:url toDisk:YES];
//                });
//            }
//        }];
//    }
}

@end
