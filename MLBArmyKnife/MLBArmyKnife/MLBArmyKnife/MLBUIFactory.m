//
//  MLBUIFactory.m
//  MLBArmyKnife
//
//  Created by meilbn on 9/10/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "MLBUIFactory.h"
#import "MLBTopImageButton.h"

@implementation MLBUIFactory

+ (MLBTopImageButton *)topButtonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action {
	MLBTopImageButton *button = [MLBTopImageButton buttonWithType:UIButtonTypeCustom];
	
	if (IsStringNotEmpty(imageName)) {
		[button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
	}
	
	if (target) {
		[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	}
	
	[button setTitle:title forState:UIControlStateNormal];
	[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	
	return button;
}

+ (MLBTopImageButton *)topButtonWithTitle:(NSString *)title imageName:(NSString *)imageName boldTitleFontSize:(NSInteger)fontSize target:(id)target action:(SEL)action {
	MLBTopImageButton *button = [MLBUIFactory topButtonWithTitle:title imageName:imageName target:target action:action];
	button.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
	
	return button;
}

+ (MLBTopImageButton *)topButtonWithTitle:(NSString *)title imageName:(NSString *)imageName titleFontSize:(NSInteger)fontSize target:(id)target action:(SEL)action {
	MLBTopImageButton *button = [MLBUIFactory topButtonWithTitle:title imageName:imageName target:target action:action];
	button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
	
	return button;
}

+ (UIButton *)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
	return [MLBUIFactory buttonWithTitle:title imageName:nil highlightedImageName:nil selectedImageName:nil target:target action:action];
}

+ (UIButton *)buttonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action {
	return [MLBUIFactory buttonWithTitle:title imageName:imageName highlightedImageName:nil selectedImageName:nil target:target action:action];
}

+ (UIButton *)buttonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action {
	return [MLBUIFactory buttonWithTitle:nil imageName:imageName highlightedImageName:nil selectedImageName:nil target:target action:action];
}

+ (UIButton *)buttonWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(id)target action:(SEL)action {
	return [MLBUIFactory buttonWithTitle:nil imageName:imageName highlightedImageName:highlightedImageName selectedImageName:nil target:target action:action];
}

+ (UIButton *)buttonWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action {
	return [MLBUIFactory buttonWithTitle:nil imageName:imageName highlightedImageName:nil selectedImageName:selectedImageName target:target action:action];
}

+ (UIButton *)buttonWithTitle:(NSString *)title imageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action {
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	if (IsStringNotEmpty(title)) {
		[button setTitle:title forState:UIControlStateNormal];
	}
	
	if (IsStringNotEmpty(imageName)) {
		[button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
	}
	
	if (IsStringNotEmpty(highlightedImageName)) {
		[button setImage:[UIImage imageNamed:highlightedImageName] forState:UIControlStateHighlighted];
		[button setTitle:title forState:UIControlStateHighlighted];
	}
	
	if (IsStringNotEmpty(selectedImageName)) {
		[button setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
		[button setTitle:title forState:UIControlStateSelected];
	}
	
	if (target) {
		[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	}
	
	return button;
}

#pragma mark - UILabel

+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font {
	return [MLBUIFactory labelWithTextColor:textColor font:font numberOfLine:1];
}

+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font numberOfLine:(NSInteger)numberOfLine {
	UILabel *label = [UILabel new];
	label.backgroundColor = [UIColor whiteColor];
	label.textColor = textColor;
	label.font = font;
	label.numberOfLines = numberOfLine;
	
	return label;
}

@end
