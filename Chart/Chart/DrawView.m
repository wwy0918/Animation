//
//  DrawView.m
//  Chart
//
//  Created by wwyun on 16/9/13.
//  Copyright © 2016年 wwyun. All rights reserved.
//


#import "DrawView.h"

@interface DrawView ()

@property(nonatomic,assign) CGFloat lastPercent;
@property(nonatomic,assign) CGPoint lastPoint;
@property(nonatomic,assign) CGFloat radius;

@end

@implementation DrawView

#pragma mark -- initialize
+ (instancetype)dataWithFrame:(CGRect)frame items:(NSArray<DrawItem *> *)items {
    return [[self alloc] initWithFrame:frame items:items];
}

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<DrawItem *> *)items {
    if (self = [super initWithFrame:frame]) {
        self.items = items;
        [self prepare];
    }
    return self;
}

- (void)prepare {
    self.radius = MIN(SELF_H/2, SELF_W/2);
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.radius;
    self.lastPoint = CGPointMake(SELF_W/2+self.radius, SELF_H/2);
}

- (void)drawRect:(CGRect)rect {
    
    for (int i=0; i<self.items.count; i++) {
        [self layoutArcWithIndex:i];
    }
    [self maskLayer];
    [self drawWhite];
}

- (void)maskLayer {
    CAShapeLayer *mask = [CAShapeLayer layer];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:[self getCenter]
                                                        radius:_radius
                                                    startAngle:0
                                                      endAngle:M_PI*2
                                                     clockwise:YES];
    
    mask.fillColor = [UIColor clearColor].CGColor;
    mask.strokeColor = [UIColor blackColor].CGColor;
    mask.strokeStart = 0;
    mask.strokeEnd = 1;
    mask.lineWidth = MIN(SELF_W, SELF_H)*0.7;
    mask.path = path.CGPath;
    
    self.layer.mask = mask;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration  = 0.5;
    animation.fromValue = @0;
    animation.toValue   = @1;
    animation.delegate  = self;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.removedOnCompletion = YES;
    [mask addAnimation:animation forKey:@"circleAnimation"];
}

- (void)layoutArcWithIndex:(int)i {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:[self getCenter]];
    [path addLineToPoint:self.lastPoint];
    CGFloat lastPercent = [self.items[i] percent]+self.lastPercent;
    [path addArcWithCenter:[self getCenter]
                    radius:self.radius
                startAngle:[self radianWithPercent:_lastPercent]
                  endAngle:[self radianWithPercent:lastPercent]
                 clockwise:YES];
    [path addLineToPoint:CGPointMake(SELF_W/2, SELF_H/2)];
    UIColor *fillColor = [self.items[i] color];
    [fillColor set];
    [path fill];
    [path stroke];
    self.lastPercent = lastPercent;
    self.lastPoint = CGPointMake(SELF_W/2+_radius*cos([self radianWithPercent:_lastPercent]),
                                 SELF_H/2+_radius*sin([self radianWithPercent:_lastPercent]));
}

- (void)drawWhite {
    CGFloat size = MIN(SELF_W, SELF_H)*0.3;
    UIView *whiteV = [UIView new];
    whiteV.frame = CGRectMake(0, 0, size, size);
    whiteV.center = CGPointMake(SELF_W/2, SELF_H/2);
    whiteV.backgroundColor = [UIColor whiteColor];
    [self addSubview:whiteV];
    whiteV.layer.cornerRadius = size/2;
    whiteV.layer.masksToBounds = YES;
}

- (CGPoint)getCenter {
    return CGPointMake(SELF_W/2, SELF_H/2);
}
- (CGFloat)radianWithPercent:(CGFloat)percent {
    return percent*M_PI*2;
}

@end
