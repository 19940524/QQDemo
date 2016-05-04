//
//  DynamicVC.m
//  QQDemo
//
//  Created by 薛国宾 on 16/4/27.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import "CYDynamicVC.h"
#import "SmallTools.h"
#import "MenuButton.h"
#import "UIViewController+MMDrawerController.h"
#import "Masonry.h"

@interface CYDynamicVC () {
    SmallTools *_smallTools;
}

@end

@implementation CYDynamicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _smallTools = [SmallTools sharedManager];
    
    [self initControl];
}

- (void)initControl {
    
    _smallTools.dynamicButton = [SmallTools setupLeftMenuButton:self.navigationItem popMenu:^{
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }];
    [self.mm_drawerController.centerContainerView addObserver:_smallTools.dynamicButton forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 110)];
    bgView.backgroundColor = [UIColor colorWithRed:234 / 255.0f green:234 / 255.0f blue:234 / 255.0f alpha:1];
    
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
        make.bottom.equalTo(bgView).offset(0);
    }];
    
    __block UIButton *tempBtn;
    __block UILabel *tempLabel;
    NSArray *titles = @[@"好友动态",@"附近",@"兴趣部落"];
    NSArray *imageNames = @[@"found_icons_qzone",@"found_icons_location",@"found_icons_group_buluo"];
    
    for (int i = 0; i < 3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 40000 + i;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(dynamicAction:) forControlEvents:UIControlEventTouchUpInside];
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
            if (i == 2) {
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
            if (i == 2) {
                make.right.equalTo(btnSuperView).offset(0);
            }
        }];
        tempLabel = titleLabel;
    }
    
    self.tableView.tableHeaderView = bgView;
}

- (void)dynamicAction:(UIButton *)button {
    NSLog(@"tag = %ld",(long)button.tag);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
