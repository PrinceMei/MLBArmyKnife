//
//  MLBCircularLoaderView.m
//  MLBArmyKnife
//
//  Created by meilbn on 9/10/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "MLBCircularLoaderView.h"

static const CGFloat circleRadius = 20.0;

@implementation MLBCircularLoaderView {
	CAShapeLayer *circlePathLayer;
}

#pragma mark - View Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	if (self) {
		[self configure];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
	
	if (self) {
		[self configure];
	}
	
	return self;
}

#pragma mark - Parent

- (void)layoutSubviews {
	[super layoutSubviews];
	circlePathLayer.frame = self.bounds;
	circlePathLayer.path = [self circlePath].CGPath;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
	if (self.superview) {
		[circlePathLayer removeAllAnimations];
		self.superview.layer.mask = nil;
	}
}

#pragma mark - Public

- (void)reveal {
	self.backgroundColor = [UIColor clearColor];
	self.progress = 1;
	[circlePathLayer removeAnimationForKey:@"strokeEnd"];
	[circlePathLayer removeFromSuperlayer];
	
	if (self.superview) {
		self.superview.layer.mask = circlePathLayer;
	}
	
	// 1
	CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
	double finalRadius = sqrt((center.x * center.x) + (center.y * center.y));
	double radiusInset = finalRadius - circleRadius;
	CGRect outerRect = CGRectInset([self circleFrame], -radiusInset, -radiusInset);
	CGPathRef toPath = [UIBezierPath bezierPathWithOvalInRect:outerRect].CGPath;
	
	// 2
	CGPathRef fromPath = circlePathLayer.path;
	CGFloat fromLineWidth = circlePathLayer.lineWidth;
	
	// 3
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
	circlePathLayer.lineWidth = 2 * finalRadius;
	circlePathLayer.path = toPath;
	[CATransaction commit];
	
	// 4
	CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath:@"lineWidth"];
	lineWidthAnimation.fromValue = @(fromLineWidth);
	lineWidthAnimation.toValue = @(2 * finalRadius);
	CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
	pathAnimation.fromValue = (__bridge id)fromPath;
	pathAnimation.toValue = (__bridge id)(toPath);
	
	// 5
	CAAnimationGroup *groupAnimation = [[CAAnimationGroup alloc] init];
	groupAnimation.duration = 1;
	groupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	groupAnimation.animations = @[pathAnimation, lineWidthAnimation];
	groupAnimation.delegate = self;
	[groupAnimation setRemovedOnCompletion:NO];
	[groupAnimation setFillMode:kCAFillModeForwards];
	[circlePathLayer addAnimation:groupAnimation forKey:@"strokeWidth"];
}

#pragma mark - Private

- (void)configure {
	circlePathLayer = [[CAShapeLayer alloc] init];
	circlePathLayer.frame = self.bounds;
	circlePathLayer.lineWidth = 5;
	circlePathLayer.fillColor = [UIColor clearColor].CGColor;
	circlePathLayer.strokeColor = [UIColor colorWithRed:132 / 255.0 green:132 / 255.0 blue:132 / 255.0 alpha:1].CGColor;
	[self.layer addSublayer:circlePathLayer];
	self.backgroundColor = [UIColor whiteColor];
	self.progress = 0;
}

- (CGRect)circleFrame {
	CGRect circleFrame = CGRectMake(0, 0, 2 * circleRadius, 2 * circleRadius);
	circleFrame.origin.x = CGRectGetMidX(circlePathLayer.bounds) - CGRectGetMidX(circleFrame);
	circleFrame.origin.y = CGRectGetMidY(circlePathLayer.bounds) - CGRectGetMidY(circleFrame);
	
	return circleFrame;
}

- (UIBezierPath *)circlePath {
	return [UIBezierPath bezierPathWithOvalInRect:[self circleFrame]];
}

#pragma mark - Getter

- (CGFloat)progress {
	return circlePathLayer.strokeEnd;
}

#pragma mark - Setter

- (void)setProgress:(CGFloat)progress {
	if (progress > 1) {
		circlePathLayer.strokeEnd = 1;
	} else if (progress < 0) {
		circlePathLayer.strokeEnd = 0;
	} else {
		circlePathLayer.strokeEnd = progress;
	}
}

@end
