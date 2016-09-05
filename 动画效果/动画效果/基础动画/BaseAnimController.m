//
//  BaseAnimController.m
//  动画效果
//
//  Created by wwyun on 16/9/2.
//  Copyright © 2016年 wwyun. All rights reserved.
//

#import "BaseAnimController.h"

@interface BaseAnimController ()

@property (weak, nonatomic) IBOutlet UIView *pinkView;

@property (weak, nonatomic) IBOutlet UIView *greenView;

@property (weak, nonatomic) IBOutlet UIView *orangeView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *contentsView;

@property (weak, nonatomic) IBOutlet UIView *rotationView;

@end

@implementation BaseAnimController

- (void)viewWillAppear:(BOOL)animated {
    [self pink];
    [self green];
    [self orange];
    [self blue];
    [self contents];
    [self rotation];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)pink {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"position"];
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(_pinkView.center.x, _pinkView.center.y)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(SYS_WIDTH-60, 60)];
    anim.duration = 2.0;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.repeatCount = HUGE_VALF;
    anim.autoreverses = YES;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [_pinkView.layer addAnimation:anim forKey:@"Pink"];
    
    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anim2.fromValue = (__bridge id _Nullable)([UIColor redColor].CGColor);
    anim2.toValue = (__bridge id _Nullable)([UIColor yellowColor].CGColor);
    anim2.duration = 1.0;
    anim2.removedOnCompletion = NO;
    anim2.fillMode = kCAFillModeBackwards;
    anim2.repeatCount = HUGE_VALF;
    anim2.autoreverses = YES;
    [_pinkView.layer addAnimation:anim2 forKey:@"green"];
}

- (void)green {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anim.fromValue = (__bridge id _Nullable)([UIColor redColor].CGColor);
    anim.toValue = (__bridge id _Nullable)([UIColor yellowColor].CGColor);
    anim.duration = 1.0;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeBackwards;
    anim.repeatCount = HUGE_VALF;
    anim.autoreverses = YES;
    [_greenView.layer addAnimation:anim forKey:@"green"];
}

- (void)orange {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    anim.fromValue = [NSNumber numberWithFloat:0];
    anim.toValue = [NSNumber numberWithFloat:M_PI*2];
    anim.duration = 2.0;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.repeatCount = HUGE_VALF;
    anim.autoreverses = YES;
    
    [_orangeView.layer addAnimation:anim forKey:@"orange"];
}

- (void)blue {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    anim.fromValue = [NSNumber numberWithFloat:5];
    anim.toValue = [NSNumber numberWithFloat:70];
    anim.duration = 2.0;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.repeatCount = HUGE_VALF;
    anim.autoreverses = YES;
    [_blueView.layer addAnimation:anim forKey:@"blue"];
}

- (void)contents {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"contents"];
    anim.fromValue = (__bridge id _Nullable)([UIImage imageNamed:@"1@2x"].CGImage);
    anim.toValue = (__bridge id _Nullable)([UIImage imageNamed:@"2@2x"].CGImage);
    anim.duration = 3.0;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.repeatCount = HUGE_VALF;
    anim.autoreverses = YES;
    [_contentsView.layer addAnimation:anim forKey:@"contents"];
}

- (void)rotation {
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2+M_PI_4, 1, 1, 0)];
    anim.duration = 2.0;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.repeatCount = HUGE_VALF;
    anim.autoreverses = YES;
    [_rotationView.layer addAnimation:anim forKey:@"rotation"];
}

@end
