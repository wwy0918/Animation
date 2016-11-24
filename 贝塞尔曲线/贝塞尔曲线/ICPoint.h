//
//  Point.h
//  贝塞尔曲线
//
//  Created by wwyun on 16/11/22.
//  Copyright © 2016年 wwy. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ICPoint : NSObject
@property (nonatomic,assign) CGPoint point;
@property (nonatomic,assign) CGPoint controlM;
@property (nonatomic,assign) CGPoint controlN;
- (instancetype)initWithPoint:(CGPoint)point controlM:(CGPoint)controlM controlN:(CGPoint)controlN;
@end
