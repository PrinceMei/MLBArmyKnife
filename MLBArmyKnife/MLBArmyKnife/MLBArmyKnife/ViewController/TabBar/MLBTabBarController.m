//
//  MLBTabBarController.m
//  MLBArmyKnife
//
//  Created by meilbn on 8/13/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "MLBTabBarController.h"

@implementation MLBTabBarController

#pragma mark - Rotation

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
	if (self.selectedViewController) {
		return [self.selectedViewController supportedInterfaceOrientations];
	}
	
	return [super supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotate {
	if (self.selectedViewController) {
		return [self.selectedViewController shouldAutorotate];
	}
	
	return [super shouldAutorotate];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
	if (self.selectedViewController) {
		return [self.selectedViewController preferredInterfaceOrientationForPresentation];
	}
	
	return [super preferredInterfaceOrientationForPresentation];
}

#pragma mark - Lifecycle

- (instancetype)init {
	if (self = [super init]) {
		[self configure];
	}
	
	return self;
}

#pragma mark - Private Method

- (void)configure {
//	self.viewControllers = @[];
	
	[self setupTabBar];
}

- (void)setupTabBar {
//	[UITabBar appearance].tintColor = ERP_NAVIGATION_BAR_COLOR;
//	
//	NSArray *tabBarItemImageNames = @[@"icon_tab_bar_erp", @"icon_tab_bar_pipeline", @"icon_tab_bar_me"];
//	NSInteger index = 0;
//	
//	for (UIViewController *vc in self.viewControllers) {
//		NSString *normalImageName =  [NSString stringWithFormat:@"%@_normal", [tabBarItemImageNames objectAtIndex:index]];
//		NSString *selectedImageName = [NSString stringWithFormat:@"%@_selected", [tabBarItemImageNames objectAtIndex:index]];
//		UIImage *normalImage = [UIImage imageNamed:normalImageName];
//		UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
//		
//		vc.tabBarItem.image = normalImage;
//		vc.tabBarItem.selectedImage = selectedImage;
//		
//		index++;
//	}
}

@end
