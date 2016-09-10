//
//  MLBScanCodeViewController.h
//  MLBArmyKnife
//
//  Created by meilbn on 8/24/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "MLBBaseViewController.h"
#import "MLBNavigationController.h"

@interface MLBScanCodeViewController : MLBBaseViewController

@property (nonatomic, assign, getter=isCanDetectorFromPhotoLibrary) BOOL canDetectorFromPhotoLibrary; // default is YES

@property (nonatomic, copy) void (^scannedWithCode)(NSString *code);

@end
