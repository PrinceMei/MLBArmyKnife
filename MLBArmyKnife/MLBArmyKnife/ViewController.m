//
//  ViewController.m
//  MLBArmyKnife
//
//  Created by meilbn on 4/18/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "ViewController.h"
#import "MLBArmyKnife.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
	
	UIButton *button = [MLBUIFactory buttonWithTitle:@"Button" target:self action:@selector(buttonClicked:)];
	button.frame = CGRectMake(0, 0, 100, 100);
	button.backgroundColor = [UIColor redColor];
	button.center = self.view.center;
	button.key = @"button";
	[self.view addSubview:button];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)buttonClicked:(UIButton *)sender {
	NSLog(@"sender.key = %@", sender.key);
}

@end
