//
//  NSDecimalNumber+MLBUtilities.h
//  MLBArmyKnife
//
//  Created by meilbn on 9/10/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (MLBUtilities)

/**
 *  判断是否为 NaN
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isEqualToNaN;

/**
 *  判断是否为0
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isEqualToZero;

/**
 *  判断是否为1
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isEqualToOne;

/**
 *  判断是否大于等于0
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isGreetThanOrEqualToZero;

/**
 *  判断是否小于等于0
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isLessThanOrEqualToZero;

/**
 *  判断是否大于等于1
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isGreetThanOrEqualToOne;

/**
 *  判断是否小于等于1
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isLessThanOrEqualToOne;

/**
 *  判断是否大于0
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isGreetThanZero;

/**
 *  判断是否小于0
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isLessThanZero;

/**
 *  判断是否大于1
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isGreetThanOne;

/**
 *  判断是否小于1
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isLessThanOne;

/**
 *  判断是否等于某个数
 *
 *  @param decimalNumber <#decimalNumber description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isEqualToDecimalNumber:(NSDecimalNumber *)decimalNumber;

/**
 *  判断是否大于某个数
 *
 *  @param decimalNumber <#decimalNumber description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isGreetThanDecimalNumber:(NSDecimalNumber *)decimalNumber;

/**
 *  判断是否小于某个数
 *
 *  @param decimalNumber <#decimalNumber description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isLessThanDecimalNumber:(NSDecimalNumber *)decimalNumber;

/**
 *  判断是否大于等于某个数
 *
 *  @param decimalNumber <#decimalNumber description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isGreetThanOrEqualToDecimalNumber:(NSDecimalNumber *)decimalNumber;

/**
 *  判断是否小于等于某个数
 *
 *  @param decimalNumber <#decimalNumber description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)mlb_isLessThanOrEqualToDecimalNumber:(NSDecimalNumber *)decimalNumber;

@end
