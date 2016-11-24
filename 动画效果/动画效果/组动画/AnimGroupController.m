//
//  AnimGroupController.m
//  动画效果
//
//  Created by wwyun on 16/9/2.
//  Copyright © 2016年 wwyun. All rights reserved.
//

#import "AnimGroupController.h"

@interface AnimGroupController ()
@property (weak, nonatomic) IBOutlet UIView *greenView;

@end

@implementation AnimGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    CAAnimationGroup
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}
- (void)viewWillAppear:(BOOL)animated {
    [self animations];
}

- (void)animations {
    CABasicAnimation *transform = [CABasicAnimation animationWithKeyPath:@"transform"];
    transform.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_4*3, 1, 0, 0)];
    transform.duration = 0.3;
    transform.removedOnCompletion = NO;
    transform.fillMode = kCAFillModeForwards;
    transform.repeatCount = HUGE_VALF;
    transform.autoreverses = YES;
    
    
    CABasicAnimation *position = [CABasicAnimation animationWithKeyPath:@"position"];
    position.toValue = [NSValue valueWithCGPoint:CGPointMake(SYS_WIDTH-60, 100)];
    
    
    CABasicAnimation *color = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    color.fromValue = (__bridge id _Nullable)([UIColor greenColor].CGColor);
    color.toValue = (__bridge id _Nullable)([UIColor redColor].CGColor);

    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[position,color,transform];
    group.repeatCount = HUGE_VALF;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.autoreverses = YES;
    group.duration = 2.0;
    
    [_greenView.layer addAnimation:group forKey:@"s"];
}

@end
