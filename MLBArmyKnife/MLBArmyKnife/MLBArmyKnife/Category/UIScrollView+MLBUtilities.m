//
//  UIScrollView+MLBUtilities.m
//  ERPProject
//
//  Created by meilbn on 9/11/16.
//  Copyright © 2016 hugh. All rights reserved.
//

#import "UIScrollView+MLBUtilities.h"

@implementation UIScrollView (MLBUtilities)

// for MJRefresh
/**
 *  结束刷新
 *
 *  @param hasMoreDatas 是否有更多数据
 */
- (void)endRefreshingHasMoreDatas:(BOOL)hasMoreDatas {
	if (self.mj_header && self.mj_header.isRefreshing) {
		[self.mj_header endRefreshing];
		[self.mj_footer resetNoMoreData];
	}
	
	if (hasMoreDatas) {
		[self.mj_footer endRefreshing];
	} else {
		[self.mj_footer endRefreshingWithNoMoreData];
	}
}

@end
