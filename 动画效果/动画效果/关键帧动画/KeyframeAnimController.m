//
//  KeyframeAnimController.m
//  动画效果
//
//  Created by wwyun on 16/9/2.
//  Copyright © 2016年 wwyun. All rights reserved.
//

#import "KeyframeAnimController.h"

@interface KeyframeAnimController ()
@property (weak, nonatomic) IBOutlet UIView *orangeView;
@property (weak, nonatomic) IBOutlet UIView *blueView;

@end

@implementation KeyframeAnimController

- (void)viewWillAppear:(BOOL)animated {
//    CAKeyframeAnimation
    [self orange];
    [self blue];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)orange {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(60, 60)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SYS_WIDTH-60, 60)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SYS_WIDTH-60, 360)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(60, 360)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(60, 60)];
    anim.values = @[value0,value1,value2,value3,value4];
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.duration = 5.0;
    // 设置每一帧的时间点。跟上面的values的每一帧一一对应。后面的值必须要大于前面的值(因为时间是一直累加的)
    // 每一个值的取值范围为(0,1)。相隔帧执行的时间 = 整个动画的执行时间 * (后一个时间点减去前一个时间点的值)
    anim.keyTimes = @[@0,@0.1,@0.4,@0.6,@1];
    anim.repeatCount = HUGE_VALF;
    anim.autoreverses = YES;
    /* The "calculation mode". Possible values are `discrete', `linear',
     * `paced', `cubic' and `cubicPaced'. Defaults to `linear'. When set to
     * `paced' or `cubicPaced' the `keyTimes' and `timingFunctions'
     * properties of the animation are ignored and calculated implicitly. */
//    anim.calculationMode = @"cubicPaced";
    [_orangeView.layer addAnimation:anim forKey:nil];
}

- (void)blue {
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, nil, CGRectMake(20, 100, 200, 200));
    anim.path = path;
    anim.duration = 2.0;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.repeatCount = HUGE_VALF;
    anim.autoreverses = YES;
    [_blueView.layer addAnimation:anim forKey:nil];
}

@end
