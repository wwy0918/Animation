//
//  CityViewController.m
//  城市选择
//
//  Created by wwyun on 16/12/16.
//  Copyright © 2016年 wwy. All rights reserved.
//

#import "CityView.h"
#import "CityViewController.h"

@interface CityViewController () <CityViewDelegate,CityViewDataSource>
@property (nonatomic,strong) CityView *cityView;
@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.cityView = [[CityView alloc] initWithFrame:
                     CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    self.cityView.delegate = self;
    self.cityView.dataSource = self;
    [self.view addSubview:self.cityView];
}

- (NSInteger)cityView:(CityView *)cityView numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == cityView.leftTable) {
        return 5;
    } else {
        return 1;
    }
}

- (NSInteger)cityView:(CityView *)cityView tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == cityView.leftTable) {
        return 5;
    } else {
        return 20;
    }
}

- (UITableViewCell *)cityView:(CityView *)cityView tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifer = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifer];
    }
    if (tableView == cityView.leftTable) {
        cell.textLabel.text = [NSString stringWithFormat:@"左 %ld-%ld",indexPath.section,indexPath.row];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"右 %ld-%ld",indexPath.section,indexPath.row];
    }
    return cell;
}

- (NSString *)cityView:(CityView *)cityView tableView:(UITableView *)tableView titleInSection:(NSInteger)section {
    if (tableView == cityView.leftTable) {
        return @"A";
    }
    return nil;
}

- (void)cityView:(CityView *)cityView tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexpath {
    
}

@end
