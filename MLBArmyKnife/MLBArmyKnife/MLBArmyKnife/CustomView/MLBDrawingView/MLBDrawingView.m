//
//  MLBDrawingView.m
//  MLBArmyKnife
//
//  Created by meilbn on 8/4/16.
//  Copyright © 2016 meilbn. All rights reserved.
//

#import "MLBDrawingView.h"

@import QuartzCore;

@interface MLBDrawingView ()

@property (strong, nonatomic) UIBezierPath *path;

@end

@implementation MLBDrawingView

- (void)dealloc {
	NSLog(@"%@ - %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}

+ (Class)layerClass {
	// this make our view create a CAShapeLayer
	// instead of a CALayer for its backing layer
	return [CAShapeLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		// create a mutable path
		_path = [UIBezierPath bezierPath];

		// configure the layer
		CAShapeLayer *shapeLayer = (CAShapeLayer *)self.layer;
		shapeLayer.strokeColor = [UIColor redColor].CGColor;
		shapeLayer.fillColor = [UIColor clearColor].CGColor;
		shapeLayer.lineCap = kCALineCapRound;
		shapeLayer.lineJoin = kCALineJoinRound;
		shapeLayer.lineWidth = 3;
	}
	
	return self;
}

- (void)setLineColor:(UIColor *)lineColor {
	if (_lineColor != lineColor) {
		_lineColor = lineColor;
		
		((CAShapeLayer *)self.layer).strokeColor = _lineColor.CGColor;
	}
}

- (void)setLineWidth:(NSInteger)lineWidth {
	if (_lineWidth != lineWidth) {
		_lineWidth = lineWidth;
		
		((CAShapeLayer *)self.layer).lineWidth = _lineWidth;
	}
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	// get the starting point
	CGPoint point = [[touches anyObject] locationInView:self];
	
	// move the path drawing cursor to the starting point
	[self.path moveToPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	// get the current point
	CGPoint point = [[touches anyObject] locationInView:self];
	
	// add a new line segment to our path
	[self.path addLineToPoint:point];
	
	// update the layer with a copy of the path
	((CAShapeLayer *)self.layer).path = self.path.CGPath;
}

- (void)drawRect:(CGRect)rect {
	// draw path
	[[UIColor clearColor] setFill];
	[[UIColor redColor] setStroke];
	[self.path stroke];
}

@end
