//
//  NSArray+MLBUtilities.h
//  MLBArmyKnife
//
//  Created by meilbn on 9/10/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (MLBUtilities)

/**
 *  防止对 NSArray 进行取 key 操作而使程序崩溃
 *
 *  @param key key
 *
 *  @return nil
 */
- (nullable id)objectForKeyedSubscript:(id _Null_unspecified)key;

@end
