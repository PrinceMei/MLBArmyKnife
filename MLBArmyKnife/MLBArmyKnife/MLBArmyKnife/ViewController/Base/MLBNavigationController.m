//
//  MLBNavigationController.m
//  MLBArmyKnife
//
//  Created by meilbn on 8/16/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "MLBNavigationController.h"

@implementation MLBNavigationController

#pragma mark - Rotation

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
	if (self.visibleViewController) {
		return [self.visibleViewController supportedInterfaceOrientations];
	}
	
	return [super supportedInterfaceOrientations];
}

- (BOOL)shouldAutorotate {
	if (self.visibleViewController) {
		return [self.visibleViewController shouldAutorotate];
	}
	
	return [super shouldAutorotate];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
	if (self.visibleViewController) {
		return [self.visibleViewController preferredInterfaceOrientationForPresentation];
	}
	
	return [super preferredInterfaceOrientationForPresentation];
}

#pragma mark - UINavigationControllerDelegate

- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController {
	return [self supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController {
	return [self preferredInterfaceOrientationForPresentation];
}

@end
