//
//  DrawItem.h
//  Chart
//
//  Created by wwyun on 16/9/13.
//  Copyright © 2016年 wwyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DrawItem : NSObject

// 百分比
@property(nonatomic,assign) CGFloat percent;
// 颜色
@property(nonatomic,strong) UIColor *color;

/**
   初始化方法, 参数:percent(百分比 0~1)
 */
+ (instancetype)itemWithPercent:(CGFloat)percent color:(UIColor *)color;

@end
