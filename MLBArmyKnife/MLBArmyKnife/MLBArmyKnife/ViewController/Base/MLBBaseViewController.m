//
//  MLBBaseViewController.m
//  MLBArmyKnife
//
//  Created by meilbn on 8/11/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "MLBBaseViewController.h"
//#import <IQKeyboardManager/IQKeyboardManager.h>

@interface MLBBaseViewController () <UIGestureRecognizerDelegate>

@end

@implementation MLBBaseViewController

#pragma mark - UIViewControllerRotation


- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
	return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
	return UIInterfaceOrientationPortrait;
}

#pragma mark - Lifecycle

- (void)dealloc {
	NSLog(@"dealloc - %@", NSStringFromClass([self class]));
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - View Lifecycle

- (instancetype)init {
    self = [super init];
	
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
	
    return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	self.view.backgroundColor = [UIColor whiteColor];
	// 不显示返回按钮上的文字
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
    NSNumber *orientationUnknown = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    
    //强制转屏
    [[UIDevice currentDevice] setValue:orientationUnknown forKey:@"orientation"];
	
	
	if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
		self.navigationController.interactivePopGestureRecognizer.delegate = self;
		self.navigationController.interactivePopGestureRecognizer.enabled = YES;
	}
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	NSLog(@"viewDidDisappear - %@", NSStringFromClass([self class]));
	
	if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
		self.navigationController.interactivePopGestureRecognizer.delegate = self;
		self.navigationController.interactivePopGestureRecognizer.enabled = NO;
	}
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
	if (self.navigationController.viewControllers.count == 1) {// 关闭主界面的右滑返回
		return NO;
	} else {
		return YES;
	}
}

#pragma mark - Private Method



#pragma mark - Public Method

/**
 *  添加 UIScrollView，占满整个 self.view
 */
- (void)addScrollView {
	if (_scrollView) {
		return;
	}
	
	self.scrollView = ({
		UIScrollView *scrollView = [UIScrollView new];
		scrollView.backgroundColor = [UIColor whiteColor];
		scrollView.showsVerticalScrollIndicator = NO;
		scrollView.showsHorizontalScrollIndicator = NO;
		scrollView.alwaysBounceVertical = YES;
		scrollView.contentSize = CGSizeMake(0, 0);
		scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
		[self.view addSubview:scrollView];
		[scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.equalTo(self.view);
		}];
		
		scrollView;
	});
}

/**
 *  添加一个 ContainerView 到 scrollView 中，scrollView 的 contentSize 根据此 view 来自适应
 *  需要这个 view 中的所有子视图的约束正确
 *  如果还未添加过 scrollView，则会自动添加
 */
- (void)addContentView {
	if (!_scrollView) {
		[self addScrollView];
	}
	
	if (_contentView) {
		return;
	}
	
	self.contentView = ({
		UIView *contentView = [UIView new];
		contentView.backgroundColor = [UIColor whiteColor];
		[_scrollView addSubview:contentView];
		[contentView mas_makeConstraints:^(MASConstraintMaker *make) {
			make.edges.equalTo(_scrollView);
			make.width.equalTo(_scrollView);
		}];
		
		contentView;
	});
}

/**
 *  在当前 ViewController 中禁用键盘上的 Toolbar 和距离控制
 */
- (void)disableIQKeyboardManager {
//	[[IQKeyboardManager sharedManager] disableToolbarInViewControllerClass:[self class]];
//	[[IQKeyboardManager sharedManager] disableDistanceHandlingInViewControllerClass:[self class]];
}

#pragma mark - Action

/**
 *  pop 当前 VC
 */
- (void)popViewController {
	dispatch_async(dispatch_get_main_queue(), ^{
		[self.navigationController popViewControllerAnimated:YES];
	});
}

#pragma mark - Network Request




@end
