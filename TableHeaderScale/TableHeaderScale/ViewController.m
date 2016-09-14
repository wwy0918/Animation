//
//  ViewController.m
//  a
//
//  Created by wwyun on 16/9/14.
//  Copyright © 2016年 wwyun. All rights reserved.
//

#import "ViewController.h"

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define Screenheight [[UIScreen mainScreen] bounds].size.height
#define kImageOriginHight 220

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView      *navBar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.automaticallyAdjustsScrollViewInsets = 0;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kImageOriginHight)];
    [view addSubview:self.imageView];
    self.tableView.tableHeaderView = view;
    
    [self.view addSubview:self.navBar];
}

- (UIView *)navBar {
    if (!_navBar) {
        _navBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
        _navBar.backgroundColor = [UIColor orangeColor];
        _navBar.alpha = 0;
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 20, ScreenWidth-20, 44)];
        searchBar.showsScopeBar = 1;
        searchBar.searchBarStyle = UISearchBarStyleMinimal;
        [_navBar addSubview:searchBar];
    }
    return _navBar;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, kImageOriginHight)];
        _imageView.image = [UIImage imageNamed:@"back"];
    }
    return _imageView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//        _tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back"]];
        UIVisualEffectView *effect = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        effect.frame = _tableView.frame;
        [_tableView.backgroundView addSubview:effect];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = @"什么是什么";
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offSetY = scrollView.contentOffset.y;
    _navBar.alpha = offSetY/(kImageOriginHight-64);
    if (offSetY>0) {
        if (offSetY/(kImageOriginHight-64) >= 1) {
            [_tableView setContentInset:UIEdgeInsetsMake(-(kImageOriginHight-64), 0, 0, 0)];
        }
    } else if (offSetY<0) {
        CGRect f = _imageView.frame;
        f.origin.y = offSetY;
        f.size.height =  -offSetY + kImageOriginHight;
        f.origin.x = -(f.size.height*ScreenWidth/kImageOriginHight -  ScreenWidth)/2;
        f.size.width = f.size.height*ScreenWidth/kImageOriginHight;
        _imageView.frame = f;
        [_tableView setContentInset:UIEdgeInsetsZero];
    }
}


@end
