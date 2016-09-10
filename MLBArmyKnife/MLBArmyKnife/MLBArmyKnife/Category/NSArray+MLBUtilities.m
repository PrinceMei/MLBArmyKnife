//
//  NSArray+MLBUtilities.m
//  MLBArmyKnife
//
//  Created by meilbn on 9/10/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "NSArray+MLBUtilities.h"

@implementation NSArray (MLBUtilities)

/**
 *  防止对 NSArray 进行取 key 操作而使程序崩溃
 *
 *  @param key key
 *
 *  @return nil
 */
- (nullable id)objectForKeyedSubscript:(id)key {
	return nil;
}

@end
