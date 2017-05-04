//
//  PresentAnimation.m
//  自定义转场动画
//
//  Created by wwyun on 17/5/4.
//  Copyright © 2017年 wwy. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"
#import "PresentAnimation.h"

@implementation PresentAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ViewController2 *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    // 1.创建imageView的截图,并把imgaView隐藏
    UIView *snapShotView = [fromVC.fromImgV snapshotViewAfterScreenUpdates:NO];
    // 创建一个imgV
    UIImageView *imgV = [[UIImageView alloc] initWithFrame:snapShotView.bounds];
    // 设置imgV大小随父视图变化而变化
    imgV.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    imgV.image = fromVC.fromImgV.image;
    [snapShotView addSubview:imgV];
    snapShotView.frame = [containerView convertRect:fromVC.fromImgV.frame fromView:fromVC.fromImgV.superview];
    fromVC.fromImgV.hidden = YES;
    
    // 2.设置目标控制器的位置,并把透明度变为0,在后面的动画中慢慢显示出来
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.toImgV.hidden = YES;
    
    // 3.添加到containerView中,注意顺序不能出错
    [containerView addSubview:toVC.view];
    [containerView addSubview:snapShotView];
    
    // 4.执行动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        toVC.view.alpha = 1.0;
        snapShotView.frame = [containerView convertRect:toVC.toImgV.frame toView:toVC.toImgV.superview];
    } completion:^(BOOL finished) {
        fromVC.fromImgV.hidden = NO;
        toVC.toImgV.hidden = NO;
        [snapShotView removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

@end
