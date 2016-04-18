//
//  MLBUtilities.m
//  MLBArmyKnife
//
//  Created by meilbn on 4/15/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "MLBUtilities.h"

static NSDateFormatter *longDateFormatter;

@implementation MLBUtilities

#pragma mark - App 相关

/**
 *  获取 App 当前的版本号
 *
 *  @return App 版本号
 */
+ (NSString *)mlb_appCurrentVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

/**
 *  获取 App 当前的 Build 号
 *
 *  @return  App Build 号
 */
+ (NSString *)mlb_appCurrentBuild {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
}

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
+ (NSInteger)mlb_rowWithCount:(NSInteger)count colNumber:(NSInteger)colNumber {
    NSInteger row = ceilf(count / (CGFloat)colNumber);
    
    return row;
}

#pragma mark - Date / 日期

/**
 *  将时间字符串转成 NSDate
 *
 *  @param string 时间字符串
 *
 *  @return 转换后的 NSDate
 */
+ (NSDate *)mlb_longDateWithString:(NSString *)string {
    if (!longDateFormatter) {
        longDateFormatter = [NSDateFormatter new];
        longDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        longDateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    }
    
    return [longDateFormatter dateFromString:string];
}

/**
 *  计算时间字符串的时间到当前的时间差（秒）
 *
 *  @param dateString 时间字符串
 *
 *  @return  时间差
 */
+ (NSTimeInterval)mlb_diffTimeIntervalSinceNowFromDateString:(NSString *)dateString {
    NSDate *date = [MLBUtilities mlb_longDateWithString:dateString];
    NSTimeInterval interval = [date timeIntervalSinceNow];
    
    return interval;
}

@end
