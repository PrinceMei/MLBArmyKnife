//
//  NSString+MLBUtilities.h
//  meilbn
//
//  Created by meilbn on 12/1/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;
@import CoreGraphics;

@interface NSString (MLBUtilities)

#pragma mark - Instance Method

/**
 *  URL 字符串转 URL，去除中文影响（图片链接）
 *
 *  @return UTF-8 编码后的 URL
 */
- (NSURL *)mlb_encodedURL;

/**
 *  去掉字符串两边的空格或者空行
 *
 *  @return 去掉字符串两边的空格或者空行之后的新字符串
 */
- (NSString *)mlb_stingTrimmedWhitespace;

/**
 *  判断字符串是否为空
 *
 *  @return  判断结果
 */
- (BOOL)mlb_isEmpty;

/**
 *  中文转拼音
 *
 *  @return 拼音
 */
- (NSString *)mlb_stringTransformedToPinyin;

/**
 *  base64 加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)mlb_base64EncodedString;

/**
 *  base64 解密
 *
 *  @return  解密后的字符串
 */
- (NSString *)mlb_base64DecodeString;

/**
 *  计算文字高度
 *
 *  @param font  字体类型
 *  @param width 宽度限制
 *
 *  @return 文字高度
 */
- (CGFloat)mlb_heightWithFont:(UIFont *)font width:(CGFloat)width;

@end
