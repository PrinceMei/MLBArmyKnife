//
//  MLBScanCodeViewController.m
//  MLBArmyKnife
//
//  Created by meilbn on 8/24/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "MLBScanCodeViewController.h"

@import AudioToolbox;
@import AVFoundation;
@import MobileCoreServices;
@import Photos;

@interface MLBScanCodeViewController () <AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) AVCaptureDevice *device;
@property (strong, nonatomic) AVCaptureDeviceInput *input;
@property (strong, nonatomic) AVCaptureMetadataOutput *output;
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

@property (strong, nonatomic) UIView *whiteBorderView;
@property (strong, nonatomic) UIImageView *movingLineImageView;

@property (strong, nonatomic) UIButton *flashLightButton;

@property (strong, nonatomic) CIDetector *detector;

@end

NSInteger const kScanCodeGrantCameraAccessPermissionAlertViewTag = 1;
NSInteger const kScanCodeGrantPhotoLibraryAccessPermissionAlertViewTag = 2;

@implementation MLBScanCodeViewController {
	SystemSoundID scanedSound;
	BOOL isPush;
}

#pragma mark - Lifecycle

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	_session = nil;
	AudioServicesDisposeSystemSoundID(scanedSound);
	// 关闭屏幕常亮
	[UIApplication sharedApplication].idleTimerDisabled = NO;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (instancetype)init {
	if (self = [super init]) {
		_canDetectorFromPhotoLibrary = YES;
	}
	
	return self;
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view.
	self.title = @"扫描";
	
	[self initDatas];
	[self setupViews];
	[self setupRecordViews];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self resumeScan];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	// 设置移动线条的位置
	[self updateMovingLinePositionWithY:CGRectGetMinY(self.whiteBorderView.frame)];
	
	// 开始移动线条的动画
	[self movingLineAnimation];
	
	// 开启屏幕常亮
	[UIApplication sharedApplication].idleTimerDisabled = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	[self stopScan];
}

- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	if (_previewLayer) {
		_previewLayer.frame = self.view.bounds;
	}
}

#pragma mark - Private Method

- (void)initDatas {
	NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"qrcode_found" ofType:@"wav"];
	AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundPath], &scanedSound);
	
	isPush = YES;
}

- (void)setupViews {
	if ([[self.navigationController.viewControllers firstObject] isKindOfClass:[self class]]) {
		isPush = NO;
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_close"] style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
	}
	
	if (self.isCanDetectorFromPhotoLibrary) {
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style: UIBarButtonItemStylePlain target:self action:@selector(selectPhotoFromLibrary)];
	}
	
	self.whiteBorderView = [UIView new];
	self.whiteBorderView.layer.borderColor = [UIColor whiteColor].CGColor;
	self.whiteBorderView.layer.borderWidth = 1;
	[self.view addSubview:self.whiteBorderView];
	[self.whiteBorderView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.height.equalTo(self.whiteBorderView.mas_width).multipliedBy(1.0);
		make.center.equalTo(self.view);
		make.left.equalTo(self.view).offset(50);
		make.right.equalTo(self.view).offset(-50);
	}];
	
	UIView *topTranslucencyView = [UIView new];
	topTranslucencyView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
	[self.view addSubview:topTranslucencyView];
	[topTranslucencyView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.top.right.equalTo(self.view);
		make.bottom.equalTo(self.whiteBorderView.mas_top);
	}];
	
	UIView *leftTranslucencyView = [UIView new];
	leftTranslucencyView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
	[self.view addSubview:leftTranslucencyView];
	[leftTranslucencyView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(topTranslucencyView.mas_bottom);
		make.left.equalTo(self.view);
		make.right.equalTo(self.whiteBorderView.mas_left);
		make.bottom.equalTo(self.whiteBorderView);
	}];
	
	UIView *bottomTranslucencyView = [UIView new];
	bottomTranslucencyView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
	[self.view addSubview:bottomTranslucencyView];
	[bottomTranslucencyView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.whiteBorderView.mas_bottom);
		make.left.bottom.right.equalTo(self.view);
	}];
	
	UIView *rightTranslucencyView = [UIView new];
	rightTranslucencyView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
	[self.view addSubview:rightTranslucencyView];
	[rightTranslucencyView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(topTranslucencyView.mas_bottom);
		make.left.equalTo(self.whiteBorderView.mas_right);
		make.bottom.equalTo(bottomTranslucencyView.mas_top);
		make.right.equalTo(self.view);
	}];
	
	UIImageView *topLeftCornerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ScanQR1"]];
	[self.view addSubview:topLeftCornerImageView];
	[topLeftCornerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.height.equalTo(@16);
		make.left.top.equalTo(self.whiteBorderView);
	}];
	
	UIImageView *topRightCornerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ScanQR2"]];
	[self.view addSubview:topRightCornerImageView];
	[topRightCornerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.height.equalTo(@16);
		make.top.right.equalTo(self.whiteBorderView);
	}];
	
	UIImageView *bottomLeftCornerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ScanQR3"]];
	[self.view addSubview:bottomLeftCornerImageView];
	[bottomLeftCornerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.height.equalTo(@16);
		make.left.bottom.equalTo(self.whiteBorderView);
	}];
	
	UIImageView *bottomRightCornerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ScanQR4"]];
	[self.view addSubview:bottomRightCornerImageView];
	[bottomRightCornerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.height.equalTo(@16);
		make.bottom.right.equalTo(self.whiteBorderView);
	}];
	
	UILabel *hintLabel = [UILabel new];
	hintLabel.text = @"将二维码图像置于矩形方框内，离手机摄像头10cm左右，系统会自动识别。";
	hintLabel.numberOfLines = 0;
	hintLabel.textAlignment = NSTextAlignmentCenter;
	hintLabel.font = FontWithSize(12);
	hintLabel.textColor = [UIColor lightGrayColor];
	[self.view addSubview:hintLabel];
	[hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.whiteBorderView.mas_bottom).offset(20);
		make.left.right.equalTo(self.whiteBorderView);
	}];
	
	self.flashLightButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.flashLightButton setImage:[UIImage mlb_imageWithNamed:@"img_scan_code_light_off" cache:NO] forState:UIControlStateNormal];
	[self.flashLightButton setImage:[UIImage mlb_imageWithNamed:@"img_scan_code_light_on" cache:NO] forState:UIControlStateSelected];
	[self.flashLightButton addTarget:self action:@selector(flashLightButtonSelected) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.flashLightButton];
	[self.flashLightButton mas_makeConstraints:^(MASConstraintMaker *make) {
		make.width.height.equalTo(@80);
		make.centerX.equalTo(self.view);
		make.top.equalTo(hintLabel.mas_bottom).offset(30);
	}];
	
	self.movingLineImageView = [[UIImageView alloc] initWithImage:[UIImage mlb_imageWithNamed:@"QRCodeScanLine" cache:NO]];
	self.movingLineImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH - 100, 12);
	[self.view addSubview:self.movingLineImageView];
}

- (void)updateMovingLinePositionWithY:(NSInteger)y {
	CGRect frame = self.movingLineImageView.frame;
	frame.origin.y = y - 6;
	frame.size.width = SCREEN_WIDTH;
	self.movingLineImageView.frame = frame;
}

- (void)setupRecordViews {
	if (![self didAuthorizationCamera]) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"您的摄像头未打开，是否前去打开" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
		alertView.tag = kScanCodeGrantCameraAccessPermissionAlertViewTag;
		[alertView show];
		return;
	}
	
	//获取摄像头设备
	_device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	
	//创建会话
	_session = [[AVCaptureSession alloc] init];
	_session.sessionPreset = AVCaptureSessionPresetHigh;
	
	//创建输入流
	_input = [[AVCaptureDeviceInput alloc] initWithDevice:_device error:nil];
	
	if ([_session canAddInput:_input]) {
		[_session addInput:_input];
	}
	
	//创建输出流
	_output = [[AVCaptureMetadataOutput alloc] init];
	
	CGFloat screenWidth = SCREEN_WIDTH;
	CGFloat whiteBorderViewWidth = screenWidth - 100;
	CGRect rectOfInterest = CGRectMake(50 / screenWidth, ceil((screenWidth - whiteBorderViewWidth) / 2) / screenWidth, whiteBorderViewWidth / screenWidth, whiteBorderViewWidth / screenWidth);
	// 设置扫描区域
	_output.rectOfInterest = rectOfInterest;
	
	//设置代理，在主线程刷新
	[_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
	
	if ([_session canAddOutput:_output]) {
		[_session addOutput:_output];
	}
	
    NSMutableArray *list = [[NSMutableArray alloc] init];
    NSArray *array = @[AVMetadataObjectTypeQRCode,
                       AVMetadataObjectTypeEAN13Code,
                       AVMetadataObjectTypeEAN8Code,
                       AVMetadataObjectTypeCode128Code,
                       AVMetadataObjectTypeUPCECode,
                       AVMetadataObjectTypeCode39Code,
                       AVMetadataObjectTypeCode39Mod43Code,
                       AVMetadataObjectTypePDF417Code,
                       AVMetadataObjectTypeCode93Code,
                       AVMetadataObjectTypeAztecCode,
                       AVMetadataObjectTypeInterleaved2of5Code,
                       AVMetadataObjectTypeITF14Code,
                       AVMetadataObjectTypeDataMatrixCode];
    for (NSString *const string1 in array) {
        BOOL find = NO;
        for (NSString *const string in _output.availableMetadataObjectTypes) {
            if (string1 == string) {
                find = YES;
                break;
            }
        }
        if (find) {
            [list addObject:string1];
        }
    }
    
	//设置扫码类型
	_output.metadataObjectTypes = list;
	
	//创建摄像头取景区域
	self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
	self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
	self.previewLayer.frame = self.view.bounds;
	[self.view.layer insertSublayer:self.previewLayer atIndex:0];
	
	if ([self.previewLayer connection].isVideoOrientationSupported) {
		[self.previewLayer connection].videoOrientation = AVCaptureVideoOrientationPortrait;
	}
	
	[_session startRunning];
	
	NSError *zoomError;
	[_device lockForConfiguration:&zoomError];
	_device.videoZoomFactor = 2;
	[_device unlockForConfiguration];
}

- (BOOL)didAuthorizationCamera {
	NSString *mediaType = AVMediaTypeVideo;
	AVAuthorizationStatus authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
	
	if (authorizationStatus == AVAuthorizationStatusRestricted || authorizationStatus == AVAuthorizationStatusDenied) {
		return NO;
	} else {
		return YES;
	}
}

#pragma mark - Action

- (void)dismiss {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)selectPhotoFromLibrary {
	PHAuthorizationStatus authorizationStatus = [PHPhotoLibrary authorizationStatus];
	if (authorizationStatus == PHAuthorizationStatusNotDetermined) {
		[PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
			[self requestPhotoLibraryAuthorization:status];
		}];
	} else {
		[self requestPhotoLibraryAuthorization:authorizationStatus];
	}
}

- (void)requestPhotoLibraryAuthorization:(PHAuthorizationStatus)status {
	switch (status) {
		case PHAuthorizationStatusNotDetermined: {
			break;
		}
		case PHAuthorizationStatusRestricted: {
			break;
		}
		case PHAuthorizationStatusDenied: {
			if (IS_IOS8_OR_LATER) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"未开启访问相册权限，现在去开启？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
				alert.tag = kScanCodeGrantPhotoLibraryAccessPermissionAlertViewTag;
				[alert show];
			} else {
				UIAlertView * alert = [[UIAlertView alloc] initWithTitle:nil message:@"设备不支持访问相册，请在设置->隐私->照片中进行设置！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
				[alert show];
			}
			
			break;
		}
		case PHAuthorizationStatusAuthorized: {
			// 跳转到相册页面
			UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
			imagePickerController.mediaTypes = @[(__bridge NSString *)kUTTypeImage];
			imagePickerController.delegate = self;
			imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
			[self presentViewController:imagePickerController animated:YES completion:NULL];
			
			break;
		}
	}
}

- (void)stopScan {
	if (_session.isRunning) {
		// 停止会话
		[_session stopRunning];
		// 删除预览图层
		[_previewLayer removeFromSuperlayer];
	}
}

- (void)resumeScan {
	if (!_session.isRunning) {
		[_session startRunning];
	}
	
	if (!_previewLayer.superlayer) {
		// 7 添加预览图层
		[self.view.layer insertSublayer:self.previewLayer atIndex:0];
	}
}

- (void)flashLightButtonSelected {
	if ([UIImagePickerController isFlashAvailableForCameraDevice:UIImagePickerControllerCameraDeviceRear]) {
		self.flashLightButton.selected = !self.flashLightButton.isSelected;
		
		Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
		if (captureDeviceClass != nil) {
			AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
			
			if ([device hasTorch] && [device hasFlash]){
				[device lockForConfiguration:nil];
				
				[device setTorchMode:self.flashLightButton.isSelected ? AVCaptureTorchModeOn : AVCaptureTorchModeOff];
				[device setFlashMode:self.flashLightButton.isSelected ? AVCaptureFlashModeOn : AVCaptureFlashModeOff];
				
				[device unlockForConfiguration];
			}
		}
	} else {
		[self.view showHUDOnlyText:@"此手机不支持闪光灯"];
	}
}

- (void)movingLineAnimation {
	if (!self.movingLineImageView || !_session.isRunning) {
		//		NSLog(@"self.movingLineImageView is nil or _session.is not running");
		return;
	}
	
	[UIView animateWithDuration:3 animations:^{
		[self updateMovingLinePositionWithY:CGRectGetMaxY(self.whiteBorderView.frame)];
	} completion:^(BOOL finished) {
		[self updateMovingLinePositionWithY:CGRectGetMinY(self.whiteBorderView.frame)];
		[self movingLineAnimation];
	}];
}

- (void)finishedPickingImage:(UIImage *)image {
	if (!image) {
		[self.view showHUDOnlyText:@"图片为空"];
		return;
	}
	
	[self.view showHUDWaitWithText:@"检测中"];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		if (!self.detector) {
			self.detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
		}
		
		NSArray *detectingResults = [self.detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
		
		dispatch_async(dispatch_get_main_queue(), ^{
			if (detectingResults.count > 0) {
				[self.view hideHUD];
				CIQRCodeFeature *feature = [detectingResults firstObject];
				NSLog(@"detectingResults = %@, feature.messageString = %@", detectingResults, feature.messageString);
				[self performSelector:@selector(callbackWithCode:) withObject:feature.messageString afterDelay:0.5];
			} else {
				[self.view showHUDOnlyText:@"该图片没有包含二维码"];
			}
		});
	});
}

- (void)callbackWithCode:(NSString *)code {
	if (_scannedWithCode) {
		_scannedWithCode(code);
	}
	
	if (isPush) {
		[self.navigationController popViewControllerAnimated:YES];
	} else {
		[self dismiss];
	}
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	if (buttonIndex != alertView.cancelButtonIndex) {
		if (alertView.tag == kScanCodeGrantCameraAccessPermissionAlertViewTag) {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy&path=CAMERA"]];
		} else if (alertView.tag == kScanCodeGrantPhotoLibraryAccessPermissionAlertViewTag) {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=Privacy&path=PHOTOS"]];
		}
	}
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    for (UIViewController *ctrl in picker.viewControllers) {
        if ([ctrl isKindOfClass:[UIViewController class]]) {
            for (UIView *subView in ctrl.view.subviews) {
                [subView removeFromSuperview];
            }
        }
    }
    
	[picker dismissViewControllerAnimated:YES completion:^{
		[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
		
		UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
		[self finishedPickingImage:image];
	}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[picker dismissViewControllerAnimated:YES completion:^{
		[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
	}];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
	if (metadataObjects.count > 0) {
		AudioServicesPlaySystemSound(scanedSound);
		[_session stopRunning];
		
		AVMetadataMachineReadableCodeObject *metadata = [metadataObjects firstObject];
		NSLog(@"metadata.stringValue = %@", metadata.stringValue);
		[self performSelector:@selector(callbackWithCode:) withObject:metadata.stringValue afterDelay:0.5];
	}
}

@end
