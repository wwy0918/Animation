//
//  ViewController2.m
//  自定义转场动画
//
//  Created by wwyun on 17/5/4.
//  Copyright © 2017年 wwy. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"
#import "DismissAnimation.h"

@interface ViewController2 ()<UINavigationControllerDelegate>

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.delegate = self;
}

- (IBAction)handlePopGes:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(nonnull UIViewController *)fromVC
                                                 toViewController:(nonnull UIViewController *)toVC
{
    if ([toVC isKindOfClass:[ViewController class]]) {
        return [[DismissAnimation alloc] init];
    }else{
        return nil;
    }
}



@end
