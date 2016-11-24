//
//  Point.m
//  贝塞尔曲线
//
//  Created by wwyun on 16/11/22.
//  Copyright © 2016年 wwy. All rights reserved.
//

#import "ICPoint.h"

@implementation ICPoint
- (instancetype)initWithPoint:(CGPoint)point controlM:(CGPoint)controlM controlN:(CGPoint)controlN
{
    if (self = [super init]) {
        self.point = point;
        self.controlM = controlM;
        self.controlN = controlN;
    }
    return self;
}
@end
