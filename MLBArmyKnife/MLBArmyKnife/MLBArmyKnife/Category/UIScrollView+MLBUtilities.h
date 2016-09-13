//
//  UIScrollView+MLBUtilities.h
//  ERPProject
//
//  Created by meilbn on 9/11/16.
//  Copyright © 2016 hugh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (MLBUtilities)

// for MJRefresh
/**
 *  结束刷新
 *
 *  @param hasMoreDatas 是否有更多数据
 */
- (void)endRefreshingHasMoreDatas:(BOOL)hasMoreDatas;

@end
