//
//  MLBTopImageWithPointButton.m
//  FZClothesReview
//
//  Created by meilbn on 7/22/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "MLBTopImageWithPointButton.h"

@implementation MLBTopImageWithPointButton

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	if (self) {
		[self setup];
	}
	
	return self;
}

- (instancetype)init {
	self = [super init];
	
	if (self) {
		[self setup];
	}
	
	return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	
	if (self) {
		[self setup];
	}
	
	return self;
}

- (void)setup {
	self.imageLabelMargin = 15;
	
	if (_pointLabel) {
		return;
	}
	
	_pointLabel = [UILabel new];
	_pointLabel.backgroundColor = MLBPointRedBGColor;
	_pointLabel.textColor = [UIColor whiteColor];
	_pointLabel.font = FontWithSize(10);
	_pointLabel.textAlignment = NSTextAlignmentCenter;
	_pointLabel.clipsToBounds = YES;
	_pointLabel.layer.cornerRadius = 6;
	[self addSubview:_pointLabel];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	[_pointLabel sizeToFit];
	CGSize pointSize = _pointLabel.frame.size;
	pointSize.width = MAX(pointSize.width + 6, 12);
	pointSize.height = 12;
	
	CGPoint titleLabelRightTopPoint = CGPointMake(CGRectGetMaxX(self.titleLabel.frame), CGRectGetMinY(self.titleLabel.frame));
	
	_pointLabel.frame = (CGRect){{titleLabelRightTopPoint.x - 3, titleLabelRightTopPoint.y - pointSize.height + 4}, pointSize};
}

- (void)setPointText:(NSString *)pointText {
	if (![_pointText isEqualToString:pointText]) {
		_pointText = pointText.copy;
		_pointLabel.text = _pointText;
		_pointLabel.hidden = IsStringEmpty(_pointText);
		[self setNeedsLayout];
	}
}

@end
