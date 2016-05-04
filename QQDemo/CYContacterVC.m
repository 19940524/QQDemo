//
//  ContacterVC.m
//  QQDemo
//
//  Created by 薛国宾 on 16/4/27.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import "CYContacterVC.h"
#import "SmallTools.h"
#import "MenuButton.h"
#import "UIViewController+MMDrawerController.h"
#import "ContacterListModel.h"
#import "ContacterCell.h"
#import "DirectoryGroup.h"
#import "HeadView.h"
#import <MJRefresh/MJRefresh.h>
#import "Masonry.h"

@interface CYContacterVC () <HeadViewDelegate> {
    SmallTools *_contacterTools;
    
    NSArray *_friendsData;
}

@end

@implementation CYContacterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self initData];
    [self initControl];
}

- (void)initData {
    _friendsData = [DirectoryGroup getContLocalResource];
}

- (void)initControl {
    _contacterTools = [SmallTools sharedManager];
    _contacterTools.contacterButton = [SmallTools setupLeftMenuButton:self.navigationItem popMenu:^{
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }];
    [self.mm_drawerController.centerContainerView addObserver:_contacterTools.contacterButton forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 130)];
    bgView.backgroundColor = [UIColor colorWithRed:231 / 255.0f green:231 / 255.0f blue:231 / 255.0f alpha:1];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    searchBar.userInteractionEnabled = NO;
    searchBar.placeholder = @"搜索";
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    [bgView addSubview:searchBar];
    
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(bgView).with.offset(0);
        make.height.mas_equalTo(40);
    }];
    
    UIView *btnSuperView = [[UIView alloc] init];
    btnSuperView.backgroundColor = [UIColor whiteColor];
    [bgView addSubview:btnSuperView];
    
    [btnSuperView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(bgView).offset(0);
        make.top.equalTo(searchBar.mas_bottom).offset(0);
        make.bottom.equalTo(bgView).offset(-20);
    }];
    
    __block UIButton *tempBtn;
    __block UILabel *tempLabel;
    NSArray *titles = @[@"新朋友",@"特别关心",@"群组",@"公众号"];
    NSArray *imageNames = @[@"buddy_header_icon_newfriend",@"buddy_header_icon_specialcare",@"buddy_header_icon_group",@"buddy_header_icon_public"];
    
    for (int i = 0; i < 4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 30000 + i;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [btnSuperView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(btnSuperView).offset(0);
            make.bottom.equalTo(btnSuperView).offset(-25);
            if (i == 0) {
                make.left.equalTo(btnSuperView).offset(0);
            } else {
                make.left.equalTo(tempBtn.mas_right).offset(0);
                make.width.equalTo(tempBtn);
            }
            if (i == 3) {
                make.right.equalTo(btnSuperView).offset(0);
            }
        }];
        tempBtn = button;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = titles[i];
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [btnSuperView addSubview:titleLabel];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(btnSuperView).offset(-5);
            if (i == 0) {
                make.left.equalTo(btnSuperView).offset(0);
            } else {
                make.left.equalTo(tempLabel.mas_right).offset(0);
                make.width.equalTo(tempLabel);
            }
            if (i == 3) {
                make.right.equalTo(btnSuperView).offset(0);
            }
        }];
        tempLabel = titleLabel;
    }
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
        });
    }];
    
    self.tableView.tableHeaderView = bgView;
    
    self.tableView.rowHeight = 61;
    self.tableView.sectionHeaderHeight = 50;
}

- (void)buttonAction:(UIButton *)button {
    NSLog(@"tag = %ld",(long)button.tag);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    //返回列表的行数
    return _friendsData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    DirectoryGroup *group = _friendsData[section];
    return group.isOpened ? group.directorys.count : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{

    CGFloat height = 1;
    if (section == 1) {
        height = 20;
    }
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    HeadView *headView = [HeadView headViewWithTableView:tableView];
    headView.delegate = self;
    headView.directoryGroup = _friendsData[section];
    if (section == 0) {
        [headView setOnlineRatioText:@"1/2"];
    } else if (section == 1) {
        [headView setOnlineRatioText:@"未匹配"];
    } else {
        [headView setOnlineRatioText:@"3/3"];
    }
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ContacterCell";
    
    ContacterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    DirectoryGroup *group = _friendsData[indexPath.section];
    ContacterListModel *modelData = group.directorys[indexPath.row];
    [cell setCellData:modelData];
    return cell;
}

#pragma mark - HeadViewDelegate
- (void)clickHeadView {
    [self.tableView reloadData];
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
