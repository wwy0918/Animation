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

#import "CollectionViewCell.h"

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
        
        FlowLayout *layout = [[FlowLayout alloc] init];
//        FlowLayout2 *layout = [[FlowLayout2 alloc] init];
//        CircleLayout *layout = [[CircleLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 160) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.backgroundColor = [UIColor redColor];
//        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"CollectionViewCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
    return cell;
}

@end
