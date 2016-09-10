//
//  NSString+MLBUtilities.m
//  MLBArmyKnife
//
//  Created by meilbn on 12/1/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "NSString+MLBUtilities.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (MLBUtilities)

#pragma mark - Class Methods

/**
 *  计算文字的 rect
 *
 *  @param attributedString  文字
 *  @param size             大小范围
 *
 *  @return 计算结果
 */
+ (CGRect)mlb_rectWithAttributedString:(NSAttributedString *)attributedString size:(CGSize)size {
	CGRect rect = [attributedString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil];
	
	return rect;
}

#pragma mark - Public Methods

/**
 *  md5 加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)mlb_md5EncodedString {
	const char *cStr = [self UTF8String];
	unsigned char digest[16];
	CC_MD5(cStr, (unsigned int)strlen(cStr), digest); // This is the md5 call
	
	NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
	
	for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
		[output appendFormat:@"%02x", digest[i]];
	}
	
	return  [NSString stringWithFormat:@"%@", output];
}

/**
 *  URL 字符串转 URL，去除中文影响（图片链接）
 *
 *  @return UTF-8 编码后的 URL
 */
- (NSURL *)mlb_encodedURL {
    return [NSURL URLWithString:[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

/**
 *  去掉字符串两边的空格或者空行
 *
 *  @return 去掉字符串两边的空格或者空行之后的新字符串
 */
- (NSString *)mlb_trimming {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

/**
 *  去掉字符串两边的空格或者空行
 *
 *  @return 去掉字符串两边的空格或者空行之后的新字符串
 */
- (NSString *)mlb_stingTrimmedWhitespace {
    NSMutableString *str = [self mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef)str);
    
    return str;
}

/**
 *  判断字符串是否为空
 *
 *  @return  判断结果
 */
- (BOOL)mlb_isEmpty {
    BOOL result = !self || [self isEqualToString:@""];
	if (!result) {
		NSString *trimWhitespace = [self mlb_trimming];
		return !trimWhitespace || [trimWhitespace isEqualToString:@""];
	}
	
	return result;
}

/**
 *  判断字符串是否是字母
 *
 *  @return  是否是字母
 */
- (BOOL)mlb_matchLetter {
	NSString *alphabetRegex = @"^[A-Za-z]+$";
	NSPredicate *regexPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", alphabetRegex];
	
	return [regexPredicate evaluateWithObject:self];
}

/**
 *  中文转拼音
 *
 *  @return 拼音
 */
- (NSString *)mlb_stringTransformedToPinyin {
    if (self.length <= 0) {
        return self;
    }
    
    NSString *tempString = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)tempString, NULL, kCFStringTransformToLatin, false);
    tempString = (NSMutableString *)[tempString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    tempString = [tempString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return [tempString uppercaseString];
}

/**
 *  拼成 iTunes URL
 *
 *  @return iTunes URL
 */
- (NSURL *)ma_iTunesURL {
	return [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/apple-store/id%@?mt=8", self]];
}

/**
 *  base64 加密
 *
 *  @return 加密后的字符串
 */
- (NSString *)mlb_base64EncodedString {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64EncodedString = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return base64EncodedString;
}

/**
 *  base64 解密
 *
 *  @return  解密后的字符串
 */
- (NSString *)mlb_base64DecodeString {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSString *base64DecodeString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];;
    
    return base64DecodeString;
}

/**
 *  计算文字宽度
 *
 *  @param font   字体类型
 *  @param height 高度限制
 *
 *  @return 文字宽度
 */
- (CGFloat)mlb_widthWithFont:(UIFont *)font height:(CGFloat)height {
	CGRect rect = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height)
									 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
								  attributes:@{ NSFontAttributeName : font }
									 context:nil];
	return ceil(rect.size.width);
}

/**
 *  计算文字高度
 *
 *  @param font  字体类型
 *  @param width 宽度限制
 *
 *  @return 文字高度
 */
- (CGFloat)mlb_heightWithFont:(UIFont *)font width:(CGFloat)width {
    CGRect rect = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:@{ NSFontAttributeName : font }
                                     context:nil];
    return ceil(rect.size.height);
}

/**
 *  转成 HTML 字符串
 *
 *  @param fontSize  字体大小
 *  @param textColor 字体颜色
 *
 *  @return HTML 字符串
 */
- (NSAttributedString *)mlb_htmlAttributedStringWithFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor {
	NSDictionary *attributes = @{ NSFontAttributeName : FontWithSize(fontSize),
								 NSForegroundColorAttributeName : textColor };
	
	return [[NSAttributedString alloc] initWithData:[self dataUsingEncoding:NSUnicodeStringEncoding]
											options:@{ NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType }
								 documentAttributes:&attributes
											  error:nil];
}

/**
 *  判断是否包含特殊字符
 *
 *  @return 是否包含特殊字符
 */
- (BOOL)mlb_containsSpecialCharacter {
    NSString *regex = @".*[`~!@#$^&*()=|{}':;',\\[\\].<>/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？].*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [pred evaluateWithObject:self];
}

/**
 *  添加了行间距的文字
 *
 *  @param lineSpacing 行间距
 *  @param font        字体
 *  @param textColor   字体颜色
 *
 *  @return 带有行间距的文字
 */
- (NSAttributedString *)mlb_attributedStringWithLineSpacing:(CGFloat)lineSpacing font:(UIFont *)font textColor:(UIColor *)textColor {
	NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
	paragraphStyle.lineSpacing = lineSpacing;
	
	NSDictionary *attrsDictionary = @{NSFontAttributeName : font, NSForegroundColorAttributeName : textColor, NSParagraphStyleAttributeName : paragraphStyle};
	NSAttributedString *attributedString =  [[NSAttributedString alloc] initWithString:self attributes:attrsDictionary];
	
	return attributedString;
}

/**
 *  防止对 NSString 进行取 key 操作而使程序崩溃
 *
 *  @param key key
 *
 *  @return 空字符串
 */
- (nullable id)objectForKeyedSubscript:(id)key {
	return @"";
}

@end
