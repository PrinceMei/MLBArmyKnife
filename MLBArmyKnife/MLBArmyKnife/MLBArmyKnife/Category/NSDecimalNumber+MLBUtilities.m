//
//  NSDecimalNumber+MLBUtilities.m
//  MLBArmyKnife
//
//  Created by meilbn on 9/10/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "NSDecimalNumber+MLBUtilities.h"

@implementation NSDecimalNumber (MLBUtilities)

/**
 *  判断是否为 NaN
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isEqualToNaN {
	NSComparisonResult result = [self compare:@(NAN)];
	
	return result == NSOrderedSame;
}

/**
 *  判断是否为0
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isEqualToZero {
	NSComparisonResult result = [self compare:@(0)];
	
	return result == NSOrderedSame;
}

/**
 *  判断是否为1
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isEqualToOne {
	NSComparisonResult result = [self compare:@(1)];
	
	return result == NSOrderedSame;
}

/**
 *  判断是否大于等于0
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isGreetThanOrEqualToZero {
	return [self mlb_isGreetThanOrEqualToDecimalNumber:[NSDecimalNumber zero]];
}

/**
 *  判断是否小于等于0
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isLessThanOrEqualToZero {
	return [self mlb_isLessThanOrEqualToDecimalNumber:[NSDecimalNumber zero]];
}

/**
 *  判断是否大于等于1
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isGreetThanOrEqualToOne {
	return [self mlb_isGreetThanOrEqualToDecimalNumber:[NSDecimalNumber one]];
}

/**
 *  判断是否小于等于1
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isLessThanOrEqualToOne {
	return [self mlb_isLessThanOrEqualToDecimalNumber:[NSDecimalNumber one]];
}

/**
 *  判断是否大于0
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isGreetThanZero {
	return [self mlb_isGreetThanDecimalNumber:[NSDecimalNumber zero]];
}

/**
 *  判断是否小于0
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isLessThanZero {
	return [self mlb_isLessThanDecimalNumber:[NSDecimalNumber zero]];
}

/**
 *  判断是否大于1
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isGreetThanOne {
	return [self mlb_isGreetThanDecimalNumber:[NSDecimalNumber one]];
}

/**
 *  判断是否小于1
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isLessThanOne {
	return [self mlb_isLessThanDecimalNumber:[NSDecimalNumber one]];
}

/**
 *  判断是否等于某个数
 *
 *  @param decimalNumber <#decimalNumber description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isEqualToDecimalNumber:(NSDecimalNumber *)decimalNumber {
	NSComparisonResult result = [self compare:decimalNumber];
	
	return result == NSOrderedSame;
}

/**
 *  判断是否大于某个数
 *
 *  @param decimalNumber <#decimalNumber description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isGreetThanDecimalNumber:(NSDecimalNumber *)decimalNumber {
	NSComparisonResult result = [self compare:decimalNumber];
	
	return result == NSOrderedDescending;
}

/**
 *  判断是否小于某个数
 *
 *  @param decimalNumber <#decimalNumber description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isLessThanDecimalNumber:(NSDecimalNumber *)decimalNumber {
	NSComparisonResult result = [self compare:decimalNumber];
	
	return result == NSOrderedAscending;
}

/**
 *  判断是否大于等于某个数
 *
 *  @param decimalNumber <#decimalNumber description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isGreetThanOrEqualToDecimalNumber:(NSDecimalNumber *)decimalNumber {
	NSComparisonResult result = [self compare:decimalNumber];
	
	return result == NSOrderedDescending || result == NSOrderedSame;
}

/**
 *  判断是否小于等于某个数
 *
 *  @param decimalNumber <#decimalNumber description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isLessThanOrEqualToDecimalNumber:(NSDecimalNumber *)decimalNumber {
	NSComparisonResult result = [self compare:decimalNumber];
	
	return result == NSOrderedAscending || result == NSOrderedSame;
}

@end
