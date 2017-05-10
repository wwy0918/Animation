//
//  ViewController.m
//  贝塞尔曲线
//
//  Created by wwyun on 16/11/21.
//  Copyright © 2016年 wwy. All rights reserved.
//

#import "ICPoint.h"
#import "ViewController.h"

@interface ViewController () {
    CAShapeLayer *_slayer;
    CAShapeLayer *_slayer2;
    NSTimer *_timer;
    
    CAShapeLayer *_leavesLayer;
    CABasicAnimation *_rotation;
    BOOL    _pause;
}
@property (weak, nonatomic) IBOutlet UIView *greenView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self shapeLayer1];
    [self shapeLayer2];
    [self leaves];
    [self content];
}


- (void)shapeLayer1 {
    
    _slayer = [[CAShapeLayer alloc] init];
    _slayer.frame = CGRectMake(50, 100, 80, 80);
    _slayer.fillColor = [UIColor clearColor].CGColor;
    _slayer.strokeColor = [UIColor blueColor].CGColor;
    _slayer.lineWidth = 5;
    _slayer.strokeEnd = 0.0f;
    [self.view.layer addSublayer:_slayer];

    UIBezierPath *bezier = [UIBezierPath bezierPath];
    [bezier addArcWithCenter:CGPointMake(40, 40) radius:40 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    _slayer.path = bezier.CGPath;

    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(run) userInfo:nil repeats:YES];
}

- (void)run {
    static CGFloat count = 0.1f;
    
    if (_slayer.strokeEnd >= 1.0f) {
        if (_slayer.strokeStart >= 1.0f) {
            [_timer invalidate];  _timer = nil;
            [self shapeLayer1];
        }
        else {
            _slayer.strokeStart += count;
            _slayer.strokeEnd = 1.0f;
        }
    }
    
    else {
        _slayer.strokeEnd += count;
    }
}


- (void)shapeLayer2 {
    _slayer2 = [CAShapeLayer layer];
    _slayer2.frame = CGRectMake(200, 100, 80, 80);
    _slayer2.fillColor = [UIColor clearColor].CGColor;
    _slayer2.strokeColor = [UIColor redColor].CGColor;
    _slayer2.lineWidth = 5;
    [self.view.layer addSublayer:_slayer2];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(40, 40) radius:40 startAngle:0 endAngle:M_PI*3/8 clockwise:YES];
    _slayer2.path = path.CGPath;
    
    CABasicAnimation *rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotation.toValue = @(M_PI*2);
    rotation.duration = 1;
    rotation.repeatCount = HUGE_VALF;
    rotation.removedOnCompletion = NO;
    rotation.fillMode = kCAFillModeForwards;
    [_slayer2 addAnimation:rotation forKey:nil];
}

- (void)leaves {
    
    CGPoint center = CGPointMake(80, 80);
    
    CGPoint pointA = CGPointMake(80, 0);
    CGPoint pointB = CGPointMake(0, 80);
    CGPoint pointC = CGPointMake(80, 160);
    CGPoint pointD = CGPointMake(160, 80);
    
    // 控制点
    CGPoint controlA1 = CGPointMake(80+20, 40);
    CGPoint controlA2 = CGPointMake(80-20, 40);
    CGPoint controlB1 = CGPointMake(80-40, 80-20);
    CGPoint controlB2 = CGPointMake(80-40, 80+20);
    CGPoint controlC1 = CGPointMake(80-20, 80+40);
    CGPoint controlC2 = CGPointMake(80+20, 80+40);
    CGPoint controlD1 = CGPointMake(80+40, 80+20);
    CGPoint controlD2 = CGPointMake(80+40, 80-20);
    
    
    _leavesLayer = [CAShapeLayer layer];
    _leavesLayer.frame = CGRectMake(120, 280, 160, 160);
    //    _leavesLayer.backgroundColor = [UIColor redColor].CGColor;
    _leavesLayer.fillColor = [UIColor blueColor].CGColor;
    _leavesLayer.lineWidth = 4;
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:center];
    [path addQuadCurveToPoint:pointA controlPoint:controlA1];
    [path addQuadCurveToPoint:center controlPoint:controlA2];
    
    [path moveToPoint:center];
    [path addQuadCurveToPoint:pointB controlPoint:controlB1];
    [path addQuadCurveToPoint:center controlPoint:controlB2];
    
    [path moveToPoint:center];
    [path addQuadCurveToPoint:pointC controlPoint:controlC1];
    [path addQuadCurveToPoint:center controlPoint:controlC2];
    
    [path moveToPoint:center];
    [path addQuadCurveToPoint:pointD controlPoint:controlD1];
    [path addQuadCurveToPoint:center controlPoint:controlD2];
    
    _leavesLayer.path = path.CGPath;
    [self.view.layer addSublayer:_leavesLayer];
    
    _rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    _rotation.toValue = @(M_PI*2);
    _rotation.duration = 1.4;
    _rotation.repeatCount = HUGE_VALF;
    [_leavesLayer addAnimation:_rotation forKey:nil];
    
    CABasicAnimation *color = [CABasicAnimation animationWithKeyPath:@"fillColor"];
    color.toValue = (__bridge id _Nullable)([UIColor clearColor].CGColor);
    color.duration = 0.4;
    color.repeatCount = HUGE_VALF;
    color.autoreverses = YES;
    [_leavesLayer addAnimation:color forKey:nil];
    
    CABasicAnimation *scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scale.fromValue = @1;
    scale.toValue = @(0);
    scale.duration = 0.4f;
    scale.repeatCount = HUGE_VALF;
    scale.autoreverses = YES;
    [_leavesLayer addAnimation:scale forKey:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_pause) {
        [self resume];
    } else {
        [self pause];
    }
}

- (void)pause {
    _pause = YES;
    CFTimeInterval  pauseTime = [_leavesLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    _leavesLayer.speed = 0;
    _leavesLayer.timeOffset = pauseTime;
}

- (void)resume {
    _pause = NO;
    CFTimeInterval pauseTime = _leavesLayer.timeOffset;
    _leavesLayer.speed = 1;
    _leavesLayer.timeOffset = 0;
    _leavesLayer.beginTime = 0;
    CFTimeInterval timeSincePause = CACurrentMediaTime() - pauseTime;
    _leavesLayer.beginTime = timeSincePause;
}

- (void)content {
    
    NSArray *imgs = @[
                      (__bridge id _Nullable)([UIImage imageNamed:@"1@2x"].CGImage),
                      (__bridge id _Nullable)([UIImage imageNamed:@"2@2x"].CGImage),
                      (__bridge id _Nullable)([UIImage imageNamed:@"3@2x"].CGImage),
                      (__bridge id _Nullable)([UIImage imageNamed:@"4@2x"].CGImage),
                      (__bridge id _Nullable)([UIImage imageNamed:@"5@2x"].CGImage),
//                      (__bridge id _Nullable)([UIImage imageNamed:@"6@2x"].CGImage),
                      (__bridge id _Nullable)([UIImage imageNamed:@"1@2x"].CGImage)
                      ];
    
    
    CAKeyframeAnimation *ani = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    ani.values = imgs;
    ani.duration = 12;
    ani.keyTimes = @[@0,@0.2,@0.4,@0.6,@0.8,@1];
    ani.repeatCount = HUGE_VALF;
    [self.greenView.layer addAnimation:ani forKey:@"contents"];
}

@end
