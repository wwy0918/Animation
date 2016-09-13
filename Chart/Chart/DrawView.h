//
//  DrawView.h
//  Chart
//
//  Created by wwyun on 16/9/13.
//  Copyright © 2016年 wwyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawItem.h"

#define SELF_W (self.frame.size.width)
#define SELF_H (self.frame.size.height)
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@interface DrawView : UIView

@property (nonatomic,strong) NSArray *items;

+ (instancetype)dataWithFrame:(CGRect)frame items:(NSArray<DrawItem *> *)items;

@end
