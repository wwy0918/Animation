//
//  MyTextField.m
//  CustomTextField
//
//  Created by wwyun on 16/11/24.
//  Copyright © 2016年 wwy. All rights reserved.
//

#import "MyTextField.h"

@interface MyTextField ()<UITextFieldDelegate>
@property (nonatomic,assign) CGFloat margin;
@property (nonatomic,strong) NSMutableArray *labels;
@end
@implementation MyTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self configuration];
        [self setUpSubViews];
    }
    return self;
}

- (void)configuration {
    self.delegate = self;
    [self unmarkText];
    self.margin = self.frame.size.width/21;
    self.backgroundColor = [UIColor whiteColor];
    self.textColor = [UIColor clearColor];
//    self.tintColor = [UIColor clearColor];
    self.keyboardType = UIKeyboardTypeNamePhonePad;
}

- (void)setUpSubViews {
    
    self.labels = [NSMutableArray arrayWithCapacity:17];
    for (int i = 0; i < 21; i++) {
        CGRect f = CGRectMake(self.margin*i, 0, self.margin, self.frame.size.height);
        
        if (i == 4 || i ==9 || i == 14 || i ==19) {
            
        }
        else {
            UILabel *label = [[UILabel alloc] initWithFrame:f];
            label.textAlignment = NSTextAlignmentCenter;
            label.backgroundColor = [UIColor whiteColor];
            label.layer.borderColor = [UIColor grayColor].CGColor;
            label.layer.borderWidth = 0.5;
            [self addSubview:label];
            [self.labels addObject:label];
        }
    }
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (range.length == 0) {
        if (self.text.length >= 17) return NO;
        UILabel *currentLabel = self.labels[range.location];
        currentLabel.text = string;
    } else {
        UILabel *currentLabel = self.labels[range.location];
        currentLabel.text = nil;
    }
    
    
    
    return YES;
}


@end
