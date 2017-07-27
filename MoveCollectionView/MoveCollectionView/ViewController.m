//
//  ViewController.m
//  MoveCollectionView
//
//  Created by wwyun on 17/7/27.
//  Copyright © 2017年 wwy. All rights reserved.
//

#import "Cell.h"
#import "ViewController.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(50, 50);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    
    UICollectionView *colView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    colView.delegate = self;
    colView.dataSource = self;
    colView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:colView];
    [colView registerNib:[UINib nibWithNibName:@"Cell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [colView addGestureRecognizer:longPress];
    self.collectionView = colView;
    
    self.array = [NSMutableArray array];
    for (int i = 0; i < 100; i++) {
        [self.array addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.lbl.text = self.array[indexPath.item];
    return cell;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
}

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)longGes
{
    switch (longGes.state) {
        case UIGestureRecognizerStateBegan: {
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longGes locationInView:self.collectionView]];
            if (indexPath) {
                [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self.collectionView updateInteractiveMovementTargetPosition:[longGes locationInView:self.collectionView]];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            [self.collectionView endInteractiveMovement];
            break;
        }
            
        default:
            [self.collectionView cancelInteractiveMovement];
            break;
    }
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CABasicAnimation *a = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
//    a.fromValue = @0;
    a.toValue = @(M_PI_4);
//    a.duration = 0.3;
//    a.fillMode = kCAFillModeForwards;
//    a.removedOnCompletion = NO;
//    [self.view.layer addAnimation:a forKey:nil];
    
    CABasicAnimation *b = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//    b.fromValue = @0;
    b.toValue = @0.5;
//    [self.view.layer addAnimation:a forKey:nil];
    
    CAAnimationGroup *g = [CAAnimationGroup animation];
    g.animations = @[b];
    g.duration = 0.3;
    g.fillMode = kCAFillModeForwards;
    g.removedOnCompletion = NO;
    [self.view.layer addAnimation:g forKey:nil];
    
//    self.view.transform = CGAffineTransformMakeRotation(40);
}




@end
