//
//  TF.m
//  CustomTextField
//
//  Created by wwyun on 16/11/24.
//  Copyright © 2016年 wwy. All rights reserved.
//

#define TextField_Tag 999

#import "TF.h"

@interface TF ()<UITextFieldDelegate>
@property (nonatomic,assign) CGFloat margin;
@property (nonatomic,strong) NSMutableArray *textFields;
@end

@implementation TF

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.margin = self.frame.size.width/21.0;
        [self setUpTF];
    }
    return self;
}

- (void)setUpTF {
    
    self.textFields = [NSMutableArray arrayWithCapacity:17];
    for (int i = 0; i < 17; i++) {
        int row = i/4;
        CGRect f = CGRectMake(self.margin*(i + row), 0, self.margin, self.frame.size.height);
        UITextField *tf = [[UITextField alloc] initWithFrame:f];
        tf.tag = TextField_Tag + i;
        tf.delegate = self;
        tf.layer.borderWidth = 0.5;
        tf.textAlignment = NSTextAlignmentCenter;
        tf.layer.borderColor = [UIColor grayColor].CGColor;
        tf.keyboardType = UIKeyboardTypeEmailAddress;
        [tf unmarkText];
        [self addSubview:tf];
        [self.textFields addObject:tf];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
//    NSLog(@"string = %@",string);
    NSLog(@"text = %@",self.text);
    if (range.length == 0 && ![string isEqualToString:@""]) {
        textField.text = [string substringToIndex:1];
        NSInteger index = textField.tag - TextField_Tag + 1;
        // 判断是否是最后一个
        if (index >= 17)  return NO;
        // 跳转到下一个
        UITextField *nextTextField = self.textFields[index];
        [nextTextField becomeFirstResponder];
        return NO;
    }
    else {
        textField.text = @"";
        NSInteger index = textField.tag - TextField_Tag - 1;
        // 判断是否是第一个
        if (index < 0)  return NO;
        // 回到上一个
        UITextField *nextTextField = self.textFields[index];
        [nextTextField becomeFirstResponder];
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (void)setFont:(UIFont *)font {
    _font = font;
    for (UITextField *tf in self.textFields) {
        tf.font = font;
    }
}

- (NSString *)text {
    NSMutableString *text = [NSMutableString string];
    for (UITextField *tf in self.textFields) {
        [text appendString:tf.text];
    }
    return text;
}

@end
