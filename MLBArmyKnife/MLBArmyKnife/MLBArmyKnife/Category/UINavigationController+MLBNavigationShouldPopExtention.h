//
//  UINavigationController+MLBNavigationShouldPopExtention.h
//  MLBArmyKnife
//
//  Created by meilbn on 9/10/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UINavigationControllerShouldPop <NSObject>

- (BOOL)navigationControllerShouldPop:(UINavigationController *)navigationController;

@optional

- (BOOL)navigationControllerShouldStartInteractivePopGestureRecognizer:(UINavigationController *)navigationController;

@end

@interface UINavigationController (MLBNavigationShouldPopExtention) <UIGestureRecognizerDelegate>

@end
