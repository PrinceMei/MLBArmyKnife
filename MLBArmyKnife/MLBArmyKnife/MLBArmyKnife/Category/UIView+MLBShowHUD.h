//
//  UIView+MLBShowHUD.h
//  MLBArmyKnife
//
//  Created by meilbn on 9/10/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIView (MLBShowHUD) <MBProgressHUDDelegate>

/**
 *  按照显示的文字计算 HUD 显示的时间长度
 *
 *  @param text 显示的文字
 *
 *  @return 显示的时间长度
 */
- (CGFloat)timeForHUDHideDelayWithText:(NSString *)text;

/**
 *  隐藏 HUD
 */
- (void)hideHUD;

/**
 *  只显示文字的 HUD
 *
 *  @param text  显示的文字
 */
- (void)showHUDOnlyText:(NSString *)text;

/**
 *  显示网络异常的 HUD
 */
- (void)showHUDNetError;

/**
 *  显示网络异常并且显示 HTTP Code
 *
 *  @param statusCode HTTP Code
 */
- (void)showHUDNetErrorWithStatusCode:(NSInteger)statusCode;

/**
 *  显示错误信息 HUD
 *
 *  @param text 错误信息
 */
- (void)showHUDErrorWithText:(NSString *)text;

/**
 *  显示成功 HUD
 */
- (void)showHUDSuccess;

/**
 *   显示成功信息 HUD
 *
 *  @param text 成功信息
 */
- (void)showHUDSuccessWithText:(NSString *)text;

/**
 *  显示指定图片和文字 HUD
 *
 *  @param imageName  图片名字
 *  @param text      文字
 */
- (void)showHUDWithImageName:(NSString *)imageName text:(NSString *)text;

/**
 *  显示等待的 HUd
 *
 *  @param text  等待信息
 */
- (void)showHUDWaitWithText:(NSString *)text;

@end
