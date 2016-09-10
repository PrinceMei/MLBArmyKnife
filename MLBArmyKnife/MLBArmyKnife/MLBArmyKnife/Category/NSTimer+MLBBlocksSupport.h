//
//  NSTimer+MLBBlocksSupport.h
//  MLBArmyKnife
//
//  Created by meilbn on 9/10/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (MLBBlocksSupport)

+ (NSTimer *)mlb_scheduledTimerWithTimeInterval:(NSTimeInterval)ti block:(void (^)())block repeats:(BOOL)yesOrNo;

@end
