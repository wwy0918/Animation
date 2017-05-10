//
//  ViewController.m
//  Wave
//
//  Created by wwyun on 17/5/8.
//  Copyright © 2017年 wwy. All rights reserved.
//

#import "WaveView.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WaveView *waveView = [[WaveView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    waveView.bgColor = [UIColor redColor];
    [self.view addSubview:waveView];
}


@end
