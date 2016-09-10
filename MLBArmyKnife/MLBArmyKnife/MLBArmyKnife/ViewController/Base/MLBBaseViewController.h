//
//  MLBBaseViewController.h
//  MLBArmyKnife
//
//  Created by meilbn on 8/11/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLBBaseViewController : UIViewController

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;

/**
 *  添加 UIScrollView，占满整个 self.view
 */
- (void)addScrollView;

/**
 *  添加一个 ContainerView 到 scrollView 中，scrollView 的 contentSize 根据此 view 来自适应
 *  需要这个 view 中的所有子视图的约束正确
 *  如果还未添加过 scrollView，则会自动添加
 */
- (void)addContentView;

/**
 *  在当前 ViewController 中禁用键盘上的 Toolbar 和距离控制
 */
- (void)disableIQKeyboardManager;

/**
 *  pop 当前 VC
 */
- (void)popViewController;

@end
