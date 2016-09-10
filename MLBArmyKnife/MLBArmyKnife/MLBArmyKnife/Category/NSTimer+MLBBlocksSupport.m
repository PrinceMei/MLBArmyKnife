//
//  NSTimer+MLBBlocksSupport.m
//  MLBArmyKnife
//
//  Created by meilbn on 9/10/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "NSTimer+MLBBlocksSupport.h"

@implementation NSTimer (MLBBlocksSupport)

+ (NSTimer *)mlb_scheduledTimerWithTimeInterval:(NSTimeInterval)ti block:(void (^)())block repeats:(BOOL)yesOrNo {
	return [self scheduledTimerWithTimeInterval:ti target:self selector:@selector(mlb_blockInvoke:) userInfo:block repeats:yesOrNo];
}

+ (void)mlb_blockInvoke:(NSTimer *)timer {
	void (^block)() = timer.userInfo;
	if (block) {
		block();
	}
}

@end
