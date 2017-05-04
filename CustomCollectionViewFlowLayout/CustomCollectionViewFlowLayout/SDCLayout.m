//
//  SDCLayout.m
//  CustomCollectionViewFlowLayout
//
//  Created by wwyun on 17/5/3.
//  Copyright © 2017年 wwy. All rights reserved.
//

#import "SDCLayout.h"

@implementation SDCLayout

- (instancetype)init {
    if (self = [super init]) {
        self.minimumLineSpacing = 0;
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    CGFloat centetX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width/2;
    for (UICollectionViewLayoutAttributes * attrs in attributes) {
        //CGFloat scale = arc4random_uniform(100)/100.0;
        //attrs.indexPath.item 表示 这个attrs对应的cell的位置
        NSLog(@" 第%zdcell--距离：%.1f",attrs.indexPath.item ,attrs.center.x - centetX);
        //cell的中心点x 和CollectionView最中心点的x值
        CGFloat delta = ABS(attrs.center.x - centetX);
        //根据间距值  计算cell的缩放的比例
        //这里scale 必须要 小于1
        CGFloat scale = 1 - delta/self.collectionView.frame.size.width;
        //设置缩放比例
        attrs.transform=CGAffineTransformMakeScale(scale, scale);
    }
    return attributes;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocit
{
    //计算出 最终显示的矩形框
    CGRect rect;
    rect.origin.x =proposedContentOffset.x;
    rect.origin.y=0;
    rect.size=self.collectionView.frame.size;
    
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算CollectionView最中心点的x值 这里要求 最终的 要考虑惯性
    CGFloat centerX = self.collectionView.frame.size.width /2+ proposedContentOffset.x;
    //存放的最小间距
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes * attrs in array) {
        if (ABS(minDelta)>ABS(attrs.center.x-centerX)) {
            minDelta=attrs.center.x-centerX;
        }
    }
    // 修改原有的偏移量
    proposedContentOffset.x+=minDelta;
    //如果返回的时zero 那个滑动停止后 就会立刻回到原地
    return proposedContentOffset;
}

@end
