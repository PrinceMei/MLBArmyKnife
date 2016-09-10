//
//  MLBUIFactory.h
//  MLBArmyKnife
//
//  Created by meilbn on 9/10/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MLBTopImageButton;

@interface MLBUIFactory : NSObject

+ (MLBTopImageButton *)topButtonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action;

+ (MLBTopImageButton *)topButtonWithTitle:(NSString *)title imageName:(NSString *)imageName boldTitleFontSize:(NSInteger)fontSize target:(id)target action:(SEL)action;

+ (MLBTopImageButton *)topButtonWithTitle:(NSString *)title imageName:(NSString *)imageName titleFontSize:(NSInteger)fontSize target:(id)target action:(SEL)action;

+ (UIButton *)buttonWithTitle:(NSString *)title target:(id)target action:(SEL)action;

+ (UIButton *)buttonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action;

+ (UIButton *)buttonWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;

+ (UIButton *)buttonWithImageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName target:(id)target action:(SEL)action;

+ (UIButton *)buttonWithImageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action;

+ (UIButton *)buttonWithTitle:(NSString *)title imageName:(NSString *)imageName highlightedImageName:(NSString *)highlightedImageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action;

#pragma mark - UILabel

+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font;

+ (UILabel *)labelWithTextColor:(UIColor *)textColor font:(UIFont *)font numberOfLine:(NSInteger)numberOfLine;

@end
