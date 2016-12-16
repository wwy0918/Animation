//
//  CityView.h
//  城市选择
//
//  Created by wwyun on 16/12/16.
//  Copyright © 2016年 wwy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CityView;
@protocol CityViewDelegate <NSObject>

- (void)cityView:(CityView *)cityView tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexpath;

@end

@protocol CityViewDataSource <NSObject>

- (NSInteger)cityView:(CityView *)cityView numberOfSectionsInTableView:(UITableView *)tableView;

@required
- (NSInteger)cityView:(CityView *)cityView tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell *)cityView:(CityView *)cityView tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (NSString *)cityView:(CityView *)cityView tableView:(UITableView *)tableView titleInSection:(NSInteger)section;

@end


@interface CityView : UIView

@property (nonatomic,strong) UITableView *leftTable;
@property (nonatomic,strong) UITableView *rightTable;
@property (nonatomic,weak) id <CityViewDelegate> delegate;
@property (nonatomic,weak) id <CityViewDataSource> dataSource;
@property (nonatomic,assign,readonly,getter=isShowRight) BOOL showRight;

@end

