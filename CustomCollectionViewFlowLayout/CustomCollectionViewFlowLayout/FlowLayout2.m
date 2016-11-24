//
//  FlowLayout2.m
//  CustomCollectionViewFlowLayout
//
//  Created by wwyun on 16/11/23.
//  Copyright © 2016年 wwy. All rights reserved.
//

#import "FlowLayout2.h"

@implementation FlowLayout2

- (instancetype)init {
    if (self = [super init]) {
        //设置每个item的大小  这个属性最好在控制器中设置
        self.itemSize = CGSizeMake(150, 150);
        //设置内边距
        self.sectionInset =UIEdgeInsetsMake(20, 10, 20, 10);
        //设置每行的最小间距
        self.minimumLineSpacing = 10.0;
    }
    return self;
}


-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{   //获得super已经计算好的布局属性 只有线性布局才能使用
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    //计算CollectionView最中心的x值
#warning 特别注意：
    CGFloat centetY = self.collectionView.contentOffset.y + self.collectionView.frame.size.height/2;
    for (UICollectionViewLayoutAttributes * attrs in array) {
        //CGFloat scale = arc4random_uniform(100)/100.0;
        //attrs.indexPath.item 表示 这个attrs对应的cell的位置
        NSLog(@" 第%zdcell--距离：%.1f",attrs.indexPath.item ,attrs.center.y - centetY);
        //cell的中心点x 和CollectionView最中心点的x值
        CGFloat delta = ABS(attrs.center.y - centetY);
        //根据间距值  计算cell的缩放的比例
        //这里scale 必须要 小于1
        CGFloat scale = delta/self.collectionView.frame.size.height - 1;
        //设置缩放比例
        attrs.transform=CGAffineTransformMakeScale(scale, scale);
    }
    return array;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
