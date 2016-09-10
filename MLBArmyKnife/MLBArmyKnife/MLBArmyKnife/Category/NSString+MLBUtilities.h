//
//  NSString+MLBUtilities.h
//  MLBArmyKnife
//
//  Created by meilbn on 12/1/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;
@import CoreGraphics;

@interface NSString (MLBUtilities)

#pragma mark - Class Methods

/**
 *  计算文字的 rect
 *
 *  @param attributedString  文字
 *  @param size             大小范围
 *
 *  @return 计算结果
 */
+ (CGRect)mlb_rectWithAttributedString:(NSAttributedString * _Null_unspecified)attributedString size:(CGSize)size;

#pragma mark - Public Methods

/**
 *  md5 加密
 *
 *  @return 加密后的字符串
 */
- (NSString * _Nullable)mlb_md5EncodedString;

/**
 *  URL 字符串转 URL，去除中文影响（图片链接）
 *
 *  @return UTF-8 编码后的 URL
 */
- (NSURL * _Nullable)mlb_encodedURL;

/**
 *  去掉字符串两边的空格或者空行
 *
 *  @return 去掉字符串两边的空格或者空行之后的新字符串
 */
- (NSString * _Nullable)mlb_trimming;

/**
 *  去掉字符串两边的空格或者空行
 *
 *  @return 去掉字符串两边的空格或者空行之后的新字符串
 */
- (NSString * _Nullable)mlb_stingTrimmedWhitespace;

/**
 *  判断字符串是否为空
 *
 *  @return  判断结果
 */
- (BOOL)mlb_isEmpty;

/**
 *  判断字符串是否是字母
 *
 *  @return  是否是字母
 */
- (BOOL)mlb_matchLetter;

/**
 *  中文转拼音
 *
 *  @return 拼音
 */
- (NSString * _Nullable)mlb_stringTransformedToPinyin;

/**
 *  拼成 iTunes URL
 *
 *  @return iTunes URL
 */
- (NSURL * _Nullable)ma_iTunesURL;

/**
 *  base64 加密
 *
 *  @return 加密后的字符串
 */
- (NSString * _Nullable)mlb_base64EncodedString;

/**
 *  base64 解密
 *
 *  @return  解密后的字符串
 */
- (NSString * _Nullable)mlb_base64DecodeString;

/**
 *  计算文字宽度
 *
 *  @param font   字体类型
 *  @param height 高度限制
 *
 *  @return 文字宽度
 */
- (CGFloat)mlb_widthWithFont:(UIFont * _Nonnull)font height:(CGFloat)height;

/**
 *  计算文字高度
 *
 *  @param font  字体类型
 *  @param width 宽度限制
 *
 *  @return 文字高度
 */
- (CGFloat)mlb_heightWithFont:(UIFont * _Nonnull)font width:(CGFloat)width;

/**
 *  转成 HTML 字符串
 *
 *  @param fontSize  字体大小
 *  @param textColor 字体颜色
 *
 *  @return HTML 字符串
 */
- (NSAttributedString * _Nullable)mlb_htmlAttributedStringWithFontSize:(CGFloat)fontSize textColor:(UIColor * _Nonnull)textColor;

/**
 *  判断是否包含特殊字符
 *
 *  @return 是否包含特殊字符
 */
- (BOOL)mlb_containsSpecialCharacter;

/**
 *  添加了行间距的文字
 *
 *  @param lineSpacing 行间距
 *  @param font        字体
 *  @param textColor   字体颜色
 *
 *  @return 带有行间距的文字
 */
- (NSAttributedString * _Nullable)mlb_attributedStringWithLineSpacing:(CGFloat)lineSpacing font:(UIFont * _Nonnull)font textColor:(UIColor * _Nonnull)textColor;

/**
 *  防止对 NSString 进行取 key 操作而使程序崩溃
 *
 *  @param key key
 *
 *  @return 空字符串
 */
- (nullable id)objectForKeyedSubscript:(id _Null_unspecified)key;

@end
