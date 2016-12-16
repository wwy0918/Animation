//
//  CityView.m
//  城市选择
//
//  Created by wwyun on 16/12/16.
//  Copyright © 2016年 wwy. All rights reserved.
//

#import "CityView.h"

@interface CityView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign) BOOL showRight;
@property (nonatomic,strong) UIView *rightView;
@end

@implementation CityView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    self.leftTable = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    self.leftTable.delegate = self;
    self.leftTable.dataSource = self;
    [self addSubview:self.leftTable];
    
    
    CGFloat x = self.bounds.size.width;
    CGFloat y = 0;
    CGFloat w = self.bounds.size.width/2;
    CGFloat h = self.bounds.size.height;
    
    self.rightView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
    self.rightView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.rightView];
    
    UIButton *hiddenRightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    hiddenRightBtn.frame = CGRectMake(0, 0, w, 44);
    [hiddenRightBtn setTitle:@"返回" forState:UIControlStateNormal];
    [hiddenRightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [hiddenRightBtn addTarget:self action:@selector(hiddenRight) forControlEvents:UIControlEventTouchUpInside];
    [self.rightView addSubview:hiddenRightBtn];
    
    CGRect f = CGRectMake(0, 44, w, h);
    self.rightTable = [[UITableView alloc] initWithFrame:f style:UITableViewStylePlain];
    self.rightTable.delegate = self;
    self.rightTable.dataSource = self;
    [self.rightView addSubview:self.rightTable];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    BOOL responds = [self.dataSource respondsToSelector:@selector(cityView:numberOfSectionsInTableView:)];
    if (responds) {
        return [self.dataSource cityView:self numberOfSectionsInTableView:tableView];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    BOOL responds = [self.dataSource respondsToSelector:@selector(cityView:tableView:numberOfRowsInSection:)];
    if (responds) {
        return  [self.dataSource cityView:self tableView:tableView numberOfRowsInSection:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if ([self.dataSource respondsToSelector:@selector(cityView:tableView:cellForRowAtIndexPath:)]) {
       cell = [self.dataSource cityView:self tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([self.dataSource respondsToSelector:@selector(cityView:tableView:titleInSection:)]) {
        return  [self.dataSource cityView:self tableView:tableView titleInSection:section];
    } else {
        return nil;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(cityView:tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate cityView:self tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    
    if (tableView == self.leftTable) {
        [self showRight];
    } else {
        [self hiddenRight];
    }
}


- (void)showRight {
    if (_showRight) {
        return;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.rightView.frame = CGRectMake(self.frame.size.width/2, 0,self.frame.size.width/2,self.frame.size.height);
        self.leftTable.frame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height);
        _showRight = YES;
    }];
}

- (void)hiddenRight {
    if (!_showRight) {
        return;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.rightView.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        self.leftTable.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _showRight = NO;
    }];
}

@end
