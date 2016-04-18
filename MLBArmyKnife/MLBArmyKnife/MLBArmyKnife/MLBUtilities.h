//
//  MLBUtilities.h
//  MLBArmyKnife
//
//  Created by meilbn on 4/15/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreGraphics;

@interface MLBUtilities : NSObject

#pragma mark - App 相关

/**
 *  获取 App 当前的版本号
 *
 *  @return App 版本号
 */
+ (NSString *)mlb_appCurrentVersion;

/**
 *  获取 App 当前的 Build 号
 *
 *  @return  App Build 号
 */
+ (NSString *)mlb_appCurrentBuild;

#pragma mark - String / 字符串



#pragma mark - Int

/**
 *  按照给定的总数和每列的个数计算行数
 *
 *  @param count     总数
 *  @param colNumber 列数
 *
 *  @return 行数
 */
+ (NSInteger)mlb_rowWithCount:(NSInteger)count colNumber:(NSInteger)colNumber;

#pragma mark - Date / 日期

/**
 *  将时间字符串转成 NSDate
 *
 *  @param string 时间字符串
 *
 *  @return 转换后的 NSDate
 */
+ (NSDate *)mlb_longDateWithString:(NSString *)string;

/**
 *  计算时间字符串的时间到当前的时间差（秒）
 *
 *  @param dateString 时间字符串
 *
 *  @return  时间差
 */
+ (NSTimeInterval)mlb_diffTimeIntervalSinceNowFromDateString:(NSString *)dateString;

@end
