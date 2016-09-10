//
//  MLBUtilities.h
//  MLBArmyKnife
//
//  Created by meilbn on 4/15/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;
@import CoreGraphics;
@import CoreLocation;

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

/**
 *  将对象转成字符串
 *
 *  @param object 对象
 *
 *  @return 字符串
 */
+ (NSString *)mlb_stringWithObject:(id)object;

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
 *  将日期转成字符串
 *
 *  @param date 日期
 *
 *  @return 字符串
 */
+ (NSString *)mlb_stringWithDate:(NSDate *)date;

/**
 *  将时间字符串转成 NSDate
 *
 *  @param string 时间字符串
 *
 *  @return 转换后的 NSDate
 */
+ (NSDate *)mlb_longDateWithString:(NSString *)string;

/**
 *  将时间字符串转成 NSDate，没有时分秒
 *
 *  @param date 时间
 *
 *  @return 普通日期字符串，没有时分秒
 */
+ (NSString *)mlb_shortStringWithDate:(NSDate *)date;

/**
 *  计算时间字符串的时间到当前的时间差（秒）
 *
 *  @param dateString 时间字符串
 *
 *  @return  时间差
 */
+ (NSTimeInterval)mlb_diffTimeIntervalSinceNowFromDateString:(NSString *)dateString;

#pragma mark - 地图相关

/**
 *  打开系统地图
 *
 *  @param latitude  纬度
 *  @param longitude 经度
 *  @param name      显示的文字
 */
+ (void)mlb_showMapWithlatitude:(double)latitude longitude:(double)longitude name:(NSString *)name;

+ (void)bdLat:(double)bd_lat Lon:(double)bd_lon toAMapLat:(double *)gg_lat aMaplng:(double *)gg_lon;

/**
 *  判断经纬度是否在中国
 *
 *  @param location  经纬度
 *
 *  @return 是否在中国
 */
+ (BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location;

/**
 *  将 WGS 的经纬度（GPS）转成 GCJ 的经纬度（比如高德）
 *
 *  @param wgsLoc wgs 经纬度
 *
 *  @return GCJ 经纬度
 */
+ (CLLocationCoordinate2D)mlb_transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc;

/**
 *  GJC 经纬度（比如高德）转成 WGS 经纬度（GPS）
 *
 *  @param location GJC 经纬度
 *
 *  @return WGS 经纬度
 */
+ (CLLocationCoordinate2D)mlb_transformFromGCJ02ToWGS84:(CLLocationCoordinate2D)location;

@end
