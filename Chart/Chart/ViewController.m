//
//  ViewController.m
//  Chart
//
//  Created by wwyun on 16/9/13.
//  Copyright © 2016年 wwyun. All rights reserved.
//

#import "ViewController.h"
#import "DrawView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        while (self.view.subviews.count) {
            [self.view.subviews[0] removeFromSuperview];
        }
    } completion:^(BOOL finished) {
        DrawItem *item0 = [DrawItem itemWithPercent:0.3 color:RGB(0,227,126)];
        DrawItem *item1 = [DrawItem itemWithPercent:0.25 color:RGB(0,206,125)];
        DrawItem *item2 = [DrawItem itemWithPercent:0.45 color:RGB(0,185,124)];
        
        DrawView *aView = [DrawView dataWithFrame:CGRectMake(0, 0, 200, 200) items:@[item0,item1,item2]];
        aView.center = self.view.center;
        [self.view addSubview:aView];
    }];
}

@end
