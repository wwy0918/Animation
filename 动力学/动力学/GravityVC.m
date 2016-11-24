//
//  GravityVC.m
//  动力学
//
//  Created by wwyun on 16/11/21.
//  Copyright © 2016年 wwy. All rights reserved.
//

#import "GravityVC.h"

@interface GravityVC ()
@property (nonatomic,strong) UIDynamicAnimator *animator;
@property (weak, nonatomic) IBOutlet UIView *blueBall;
@end

@implementation GravityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * apple = [[UIView alloc] initWithFrame:CGRectMake(40,40, 40, 40)];
    apple.backgroundColor = [UIColor redColor];
    [self.view addSubview:apple];
    
   _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[apple]];
    [_animator addBehavior:gravity];
}








@end
