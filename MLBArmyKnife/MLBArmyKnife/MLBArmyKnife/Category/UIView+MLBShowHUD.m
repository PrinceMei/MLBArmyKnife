//
//  UIView+MLBShowHUD.m
//  MLBArmyKnife
//
//  Created by meilbn on 9/10/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "UIView+MLBShowHUD.h"

@implementation UIView (MLBShowHUD)

#pragma mark - Private Method

- (MBProgressHUD *)hudWithMode:(MBProgressHUDMode)mode {
	MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self animated:YES];
	hud.mode = mode;
	hud.removeFromSuperViewOnHide = YES;
	hud.delegate = self;
	
	return hud;
}

#pragma mark - Public Method

/**
 *  按照显示的文字计算 HUD 显示的时间长度
 *
 *  @param text 显示的文字
 *
 *  @return 显示的时间长度
 */
- (CGFloat)timeForHUDHideDelayWithText:(NSString *)text {
	CGFloat stringTime = [text mlb_trimming].length / 5.0 * 1.0;
	
	return MIN(3, MAX(MLB_HUD_DELAY, stringTime));
}

/**
 *  隐藏 HUD
 */
- (void)hideHUD {
	MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
	if (hud && !hud.isHidden) {
		[hud hideAnimated:YES];
	}
}

/**
 *  只显示文字的 HUD
 *
 *  @param text  显示的文字
 */
- (void)showHUDOnlyText:(NSString *)text {
	MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
	if (!hud) {
		hud = [self hudWithMode:MBProgressHUDModeText];
	} else {
		hud.mode = MBProgressHUDModeText;
	}
	
	hud.detailsLabel.text = text;
	[hud hideAnimated:YES afterDelay:[self timeForHUDHideDelayWithText:text]];
}

/**
 *  显示网络异常的 HUD
 */
- (void)showHUDNetError {
	[self showHUDErrorWithText:MLBServerConnectError];
}

/**
 *  显示网络异常并且显示 HTTP Code
 *
 *  @param statusCode HTTP Code
 */
- (void)showHUDNetErrorWithStatusCode:(NSInteger)statusCode {
	[self showHUDErrorWithText:[NSString stringWithFormat:@"%@, Code:%ld", MLBServerConnectError, statusCode]];
}

/**
 *  显示错误信息 HUD
 *
 *  @param text 错误信息
 */
- (void)showHUDErrorWithText:(NSString *)text {
	[self showHUDWithImageName:@"common_icon_error" text:text];
}

/**
 *  显示成功 HUD
 */
- (void)showHUDSuccess {
	[self showHUDSuccessWithText:@"成功"];
}

/**
 *   显示成功信息 HUD
 *
 *  @param text 成功信息
 */
- (void)showHUDSuccessWithText:(NSString *)text {
	[self showHUDWithImageName:@"common_icon_completed" text:text];
}

/**
 *  显示指定图片和文字 HUD
 *
 *  @param imageName  图片名字
 *  @param text      文字
 */
- (void)showHUDWithImageName:(NSString *)imageName text:(NSString *)text {
	MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
	if (!hud) {
		hud = [self hudWithMode:MBProgressHUDModeCustomView];
	} else {
		hud.mode = MBProgressHUDModeCustomView;
	}
	
	UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	hud.customView = [[UIImageView alloc] initWithImage:image];
	hud.square = NO;
	hud.detailsLabel.text = text;
	hud.removeFromSuperViewOnHide = YES;
	hud.delegate = self;
	[hud hideAnimated:YES afterDelay:[self timeForHUDHideDelayWithText:text]];
}

/**
 *  显示等待的 HUd
 *
 *  @param text  等待信息
 */
- (void)showHUDWaitWithText:(NSString *)text {
	MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
	if (!hud) {
		hud = [self hudWithMode:MBProgressHUDModeIndeterminate];
	} else {
		hud.mode = MBProgressHUDModeIndeterminate;
	}
	
	hud.removeFromSuperViewOnHide = YES;
	hud.delegate = self;
	hud.detailsLabel.text = text;
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
	[hud removeFromSuperview];
}

@end
