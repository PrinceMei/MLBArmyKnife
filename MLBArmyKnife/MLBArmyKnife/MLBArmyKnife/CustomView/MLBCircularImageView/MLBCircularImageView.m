//
//  MLBCircularImageView.m
//  MLBArmyKnife
//
//  Created by meilbn on 8/3/15.
//  Copyright (c) 2015 meilbn. All rights reserved.
//

#import "MLBCircularImageView.h"
#import "MLBCircularLoaderView.h"

@interface MLBCircularImageView ()

@property (nonatomic, strong) MLBCircularLoaderView *progressIndicatorView;

@end

@implementation MLBCircularImageView

- (instancetype)init {
	self = [super init];
	
	if (self) {
		self.progressIndicatorView = [[MLBCircularLoaderView alloc] initWithFrame:CGRectZero];
		[self addSubview:self.progressIndicatorView];
	}
	
	return self;
}

- (void)configureImageViwWithImageURL:(NSURL *)url animated:(BOOL)animated {
	if (animated) {
		self.progressIndicatorView.frame = self.bounds;
		[self.progressIndicatorView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
		
		[self sd_setImageWithURL:url placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
			self.progressIndicatorView.progress = @(receivedSize).floatValue / @(expectedSize).floatValue;
		} completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
			[self.progressIndicatorView reveal];
		}];
	} else {
		self.progressIndicatorView.frame = CGRectZero;
		[self sd_setImageWithURL:url];
	}
}

@end
