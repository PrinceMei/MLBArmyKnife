//
//  NSString+MLBUtilities.m
//  meilbn
//
//  Created by meilbn on 12/1/15.
//  Copyright © 2015 meilbn. All rights reserved.
//

#import "NSString+MLBUtilities.h"

@implementation NSString (MLBUtilities)

#pragma mark - Instance Method

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
    return !self || [self isEqualToString:@""];
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
                                  attributes:@{NSFontAttributeName : font}
                                     context:nil];
    return ceil(rect.size.height);
}

@end
