//
//  UIImageView+MLBSDImageLoader.h
//  MLBArmyKnife
//
//  Created by meilbn on 4/18/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (MLBSDImageLoader)

- (void)mlb_sd_setImageWithURL:(NSString *)url placeholderImageName:(NSString *)placeholderImageName;

- (void)mlb_sd_setImageWithURL:(NSString *)url placeholderImageName:(NSString *)placeholderImageName storeImage:(BOOL)storeImage;

@end
