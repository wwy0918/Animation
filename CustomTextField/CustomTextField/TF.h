//
//  TF.h
//  CustomTextField
//
//  Created by wwyun on 16/11/24.
//  Copyright © 2016年 wwy. All rights reserved.
//  较好,虽然是重量级控件,但是能较好解决问题

#import <UIKit/UIKit.h>

@interface TF : UIView
@property (nonatomic,copy,readonly) NSString *text;
@property (nonatomic,strong) UIFont *font;
@end
