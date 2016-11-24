//
//  ViewController.m
//  CustomTextField
//
//  Created by wwyun on 16/11/24.
//  Copyright © 2016年 wwy. All rights reserved.
//

#import "TF.h"
#import "CustomTF.h"
#import "MyTextField.h"
#import "ViewController.h"

@interface ViewController () {
    TF *_tf;
    TF *_tf1;
}
@property (nonatomic, strong) CustomTF  *myTf;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myTf = [[CustomTF alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width-40, 20)];
    [self.view addSubview:self.myTf];
    
    
    MyTextField *tf = [[MyTextField alloc] initWithFrame:CGRectMake(20, 200, self.view.frame.size.width-40, 20)];
     [self.view addSubview:tf];
    
    _tf = [[TF alloc] initWithFrame:CGRectMake(20, 300, self.view.frame.size.width-40, 20)];
    [self.view addSubview:_tf];
    
    _tf1 = [[TF alloc] initWithFrame:CGRectMake(20, 350, 1000, 60)];
    _tf1.font = [UIFont systemFontOfSize:30];
    [self.view addSubview:_tf1];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@" text = %@ ",_tf.text);
}



@end
