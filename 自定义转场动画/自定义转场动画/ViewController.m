//
//  ViewController.m
//  自定义转场动画
//
//  Created by wwyun on 17/5/4.
//  Copyright © 2017年 wwy. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"
#import "PresentAnimation.h"
#import "DismissAnimation.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate,UINavigationControllerDelegate>

@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)push:(id)sender {
    ViewController2 *vc = [[ViewController2 alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                     animationControllerForOperation:(UINavigationControllerOperation)operation
                                                  fromViewController:(nonnull UIViewController *)fromVC
                                                    toViewController:(nonnull UIViewController *)toVC
{
    if ([toVC isKindOfClass:[ViewController2 class]]) {
        return [[PresentAnimation alloc] init];
    }else{
        return nil;
    }
}


@end
