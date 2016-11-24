//
//  CustomTF.m
//  CustomTextField
//
//  Created by wwyun on 16/11/24.
//  Copyright © 2016年 wwy. All rights reserved.
//

#import "CustomTF.h"


@interface CustomTF ()
@property (nonatomic, assign)  CGFloat    selfWidth;
@property (nonatomic, assign)  CGFloat    selfHeight;
@property (nonatomic, assign)  CGFloat    margin;
@end

@implementation CustomTF

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.selfWidth = self.frame.size.width;
        self.selfHeight = self.frame.size.height;
        self.margin = self.selfWidth/21.0;
        
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    CAShapeLayer *displayLayer = [CAShapeLayer layer];
//    displayLayer.frame = self.bounds;
//    displayLayer.fillColor = [UIColor whiteColor].CGColor;
    
    displayLayer.lineWidth = 0.5;
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    UIColor *lineColor = [UIColor blackColor];
    
    [lineColor set];
    
    for (int i = 0; i  < 4; i++) {
        CGPoint leftTop_Point = CGPointMake(self.margin*5*i, 0);
        CGPoint rightTop_Point = CGPointMake(leftTop_Point.x+self.margin*4, 0);
        CGPoint rightBottom_point = CGPointMake(rightTop_Point.x, self.selfHeight);
        CGPoint leftBottom_Point = CGPointMake(leftTop_Point.x, self.selfHeight);
        
        [path moveToPoint:leftTop_Point];
        [path addLineToPoint:rightTop_Point];
        [path addLineToPoint:rightBottom_point];
        [path addLineToPoint:leftBottom_Point];
        [path addLineToPoint:leftTop_Point];
        
        // 画中间三条竖线
        for (int j = 0; j < 3; j++) {
            CGPoint point1_1 = CGPointMake(leftTop_Point.x+self.margin, 0);
            CGPoint point1_2 = CGPointMake(leftTop_Point.x+self.margin, self.selfHeight);
            
            CGPoint point2_1 = CGPointMake(leftTop_Point.x+self.margin*2, 0);
            CGPoint point2_2 = CGPointMake(leftTop_Point.x+self.margin*2, self.selfHeight);
            
            CGPoint point3_1 = CGPointMake(leftTop_Point.x+self.margin*3, 0);
            CGPoint point3_2 = CGPointMake(leftTop_Point.x+self.margin*3, self.selfHeight);
            
            [path moveToPoint:point1_1];
            [path addLineToPoint:point1_2];
            
            [path moveToPoint:point2_1];
            [path addLineToPoint:point2_2];
            
            [path moveToPoint:point3_1];
            [path addLineToPoint:point3_2];
        }
    }
    
    // 画最后一个框
    CGPoint lastPoin1 = CGPointMake(self.margin*20, 0);
    CGPoint lastPoin2 = CGPointMake(self.margin*21, 0);
    CGPoint lastPoin3 = CGPointMake(self.margin*21, self.selfHeight);
    CGPoint lastPoin4 = CGPointMake(self.margin*20, self.selfHeight);
    
    [path moveToPoint:lastPoin1];
    [path addLineToPoint:lastPoin2];
    [path addLineToPoint:lastPoin3];
    [path addLineToPoint:lastPoin4];
    [path closePath];
    
    [path stroke];
    
    displayLayer.path = path.CGPath;
//    [self.layer addSublayer:displayLayer];
}

//- (CGRect)textRectForBounds:(CGRect)bounds {
//    //return CGRectInset(bounds, 50, 0);
//    CGRect inset = CGRectMake(bounds.origin.x+190, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
//    
//    return inset;
//}

////控制编辑文本的位置
//-(CGRect)editingRectForBounds:(CGRect)bounds
//{
//    //return CGRectInset( bounds, 10 , 0 );
//    
//    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width -10, bounds.size.height);
//    return inset;
//}

@end
