//
//  DrawItem.m
//  Chart
//
//  Created by wwyun on 16/9/13.
//  Copyright © 2016年 wwyun. All rights reserved.
//

#import "DrawItem.h"

@implementation DrawItem

- (instancetype)initWithPercent:(CGFloat)percent color:(UIColor *)color{
    if (self = [super init]) {
        self.percent = percent;
          self.color = color;
    }
    return self;
}

+ (instancetype)itemWithPercent:(CGFloat)percent color:(UIColor *)color {
    return [[self alloc] initWithPercent:percent color:color];
}


@end
