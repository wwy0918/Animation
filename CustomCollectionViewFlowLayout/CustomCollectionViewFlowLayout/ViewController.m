//
//  ViewController.m
//  CustomCollectionViewFlowLayout
//
//  Created by wwyun on 16/11/23.
//  Copyright © 2016年 wwy. All rights reserved.
//

#import "FlowLayout.h"
#import "FlowLayout2.h"
#import "CircleLayout.h"
#import "ViewController.h"

@interface ViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView  *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        FlowLayout2 *layout = [[FlowLayout2 alloc] init];
//        CircleLayout *layout = [[CircleLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"1"];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"1" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    cell.backgroundView = [UIView new];
    return cell;
}

@end
