//
//  MLBUtilities.m
//  MLBArmyKnife
//
//  Created by meilbn on 4/15/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "MLBUtilities.h"

@import MapKit;

static NSDateFormatter *longDateFormatter;
static NSDateFormatter *shortDateFormatter;

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

/**
 *  将对象转成字符串
 *
 *  @param object 对象
 *
 *  @return 字符串
 */
+ (NSString *)mlb_stringWithObject:(id)object {
	if ((NSNull *)object == [NSNull null]) {
		return @"";
	}
	
	if ([object isKindOfClass:[NSString class]]) {
		return object;
	} else if (object) {
		return [NSString stringWithFormat:@"%@", object];
	} else {
		return @"";
	}
}

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

+ (void)configureLongDateFormatter {
	if (!longDateFormatter) {
		longDateFormatter = [NSDateFormatter new];
		longDateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
		longDateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
	}
}

+ (void)configureShortDateFormatter {
	if (!shortDateFormatter) {
		shortDateFormatter = [NSDateFormatter new];
		shortDateFormatter.dateFormat = @"yyyy-MM-dd";
		shortDateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
	}
}

/**
 *  将日期转成字符串
 *
 *  @param date 日期
 *
 *  @return 字符串
 */
+ (NSString *)mlb_stringWithDate:(NSDate *)date {
	[self configureLongDateFormatter];
	
	return [longDateFormatter stringFromDate:date];
}

/**
 *  将时间字符串转成 NSDate
 *
 *  @param string 时间字符串
 *
 *  @return 转换后的 NSDate
 */
+ (NSDate *)mlb_longDateWithString:(NSString *)string {
    [self configureLongDateFormatter];
    
    return [longDateFormatter dateFromString:string];
}

/**
 *  将时间字符串转成 NSDate，没有时分秒
 *
 *  @param date 时间
 *
 *  @return 普通日期字符串，没有时分秒
 */
+ (NSString *)mlb_shortStringWithDate:(NSDate *)date {
	[self configureShortDateFormatter];
	
	return [shortDateFormatter stringFromDate:date];
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

#pragma mark - 地图相关

/**
 *  打开系统地图
 *
 *  @param latitude  纬度
 *  @param longitude 经度
 *  @param name      显示的文字
 */
+ (void)mlb_showMapWithlatitude:(double)latitude longitude:(double)longitude name:(NSString *)name {
    CLLocationDistance regionDistance = 500;
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latitude, longitude);
    CLLocationCoordinate2D coordGCJ = [self mlb_transformFromWGSToGCJ:coord];
    MKCoordinateRegion regionSpan = MKCoordinateRegionMakeWithDistance(coordGCJ, regionDistance, regionDistance);
    NSDictionary *options = @{MKLaunchOptionsMapCenterKey : [NSValue valueWithMKCoordinate:regionSpan.center],
                              MKLaunchOptionsMapSpanKey : [NSValue valueWithMKCoordinateSpan:regionSpan.span]};
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordGCJ addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = name;
    [mapItem openInMapsWithLaunchOptions:options];
}

const double pi = 3.14159265358979324;
const double x_pi = pi * 3000.0 / 180.0;
const double a = 6378245.0;
const double ee = 0.00669342162296594323;

+ (void)bdLat:(double)bd_lat Lon:(double)bd_lon toAMapLat:(double *)gg_lat aMaplng:(double *)gg_lon {
    double x = bd_lon - 0.0065, y = bd_lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    *gg_lon = z * cos(theta);
    *gg_lat = z * sin(theta);
}

/**
 *  将 WGS 的经纬度（GPS）转成 GCJ 的经纬度（比如高德）
 *
 *  @param wgsLoc wgs 经纬度
 *
 *  @return GCJ 经纬度
 */
+ (CLLocationCoordinate2D)mlb_transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc {
    CLLocationCoordinate2D adjustLoc;
    
    if([self isLocationOutOfChina:wgsLoc]){
        adjustLoc = wgsLoc;
    } else {
        double adjustLat = [self transformLatWithX:wgsLoc.longitude - 105.0 withY:wgsLoc.latitude - 35.0];
        double adjustLon = [self transformLonWithX:wgsLoc.longitude - 105.0 withY:wgsLoc.latitude - 35.0];
        double radLat = wgsLoc.latitude / 180.0 * pi;
        double magic = sin(radLat);
        magic = 1 - ee * magic * magic;
        double sqrtMagic = sqrt(magic);
        adjustLat = (adjustLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi);
        adjustLon = (adjustLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi);
        adjustLoc.latitude = wgsLoc.latitude + adjustLat;
        adjustLoc.longitude = wgsLoc.longitude + adjustLon;
    }
    
    return adjustLoc;
}

/**
 *  判断经纬度是否在中国
 *
 *  @param location  经纬度
 *
 *  @return 是否在中国
 */
+ (BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location {
    if (location.longitude < 72.004 || location.longitude > 137.8347 || location.latitude < 0.8293 || location.latitude > 55.8271)
        return YES;
    return NO;
}

+ (double)transformLatWithX:(double)x withY:(double)y {
    double lat = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    lat += (20.0 * sin(6.0 * x * pi) + 20.0 *sin(2.0 * x * pi)) * 2.0 / 3.0;
    lat += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0;
    lat += (160.0 * sin(y / 12.0 * pi) + 320 * sin(y * pi / 30.0)) * 2.0 / 3.0;
    
    return lat;
}

+ (double)transformLonWithX:(double)x withY:(double)y {
    double lon = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    lon += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0;
    lon += (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0;
    lon += (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0 * pi)) * 2.0 / 3.0;
    
    return lon;
}

/**
 *  GJC 经纬度（比如高德）转成 WGS 经纬度（GPS）
 *
 *  @param location GJC 经纬度
 *
 *  @return WGS 经纬度
 */
+ (CLLocationCoordinate2D)mlb_transformFromGCJ02ToWGS84:(CLLocationCoordinate2D)location {
    return [self gcj02Decrypt:location.latitude gjLon:location.longitude];
}

+ (CLLocationCoordinate2D)gcj02Decrypt:(double)gjLat gjLon:(double)gjLon {
    CLLocationCoordinate2D  gPt = [self gcj02Encrypt:gjLat bdLon:gjLon];
    double dLon = gPt.longitude - gjLon;
    double dLat = gPt.latitude - gjLat;
    CLLocationCoordinate2D pt;
    pt.latitude = gjLat - dLat;
    pt.longitude = gjLon - dLon;
    return pt;
}

+ (CLLocationCoordinate2D)gcj02Encrypt:(double)ggLat bdLon:(double)ggLon {
    CLLocationCoordinate2D resPoint;
    double mgLat;
    double mgLon;
    if ([self isLocationOutOfChina:CLLocationCoordinate2DMake(ggLat, ggLon)]) {
        resPoint.latitude = ggLat;
        resPoint.longitude = ggLon;
        return resPoint;
    }
    
    double dLat = [self transformLatWithX:(ggLon - 105.0) withY:(ggLat - 35.0)];
    double dLon = [self transformLonWithX:(ggLon - 105.0) withY:(ggLat - 35.0)];
    double radLat = ggLat / 180.0 * M_PI;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * M_PI);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * M_PI);
    mgLat = ggLat + dLat;
    mgLon = ggLon + dLon;
    
    resPoint.latitude = mgLat;
    resPoint.longitude = mgLon;
    return resPoint;
}

@end
