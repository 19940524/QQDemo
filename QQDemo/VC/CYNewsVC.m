//
//  CYNewsVC.m
//  QQDemo
//
//  Created by 薛国宾 on 16/4/25.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import "CYNewsVC.h"
#import "SmallTools.h"
#import "UIView+SHCZExt.h"
#import "MMDrawerBarButtonItem.h"
#import "MenuButton.h"
#import "UIViewController+MMDrawerController.h"
#import <objc/runtime.h>
#import "LeftMenuViewController.h"
#import "NewsListModel.h"
#import "NewsCell.h"
#import <MJRefresh/MJRefresh.h>
#import "WHC_BadgeView.h"

@interface CYNewsVC () <WHC_BadgeViewDelegate> {
    SmallTools *_smallTools;
    NSArray    *_list;
}

@property (strong, nonatomic) IBOutlet UITableView *newsTabelView;
@end

@implementation CYNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initControl];
//    深圳人人  深圳佳兆业
    
    UIImageView *imagev = [UIImageView new];
    imagev.layer.masksToBounds = YES;
    imagev.layer.cornerRadius = 25;
    
    _list = [NewsListModel getLocalResource];
    

}

- (void)initControl {
    self.tableView.rowHeight = 55;
    
    _smallTools = [SmallTools sharedManager];
    
    _smallTools.newsButton = [SmallTools setupLeftMenuButton:self.navigationItem popMenu:^{
        [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }];
    [self.mm_drawerController.centerContainerView addObserver:_smallTools.newsButton forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    searchBar.userInteractionEnabled = NO;
    searchBar.placeholder = @"搜索";
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.tableView.tableHeaderView = searchBar;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView.mj_header endRefreshing];
        });
    }];
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *newsCellIdentifier = @"NewsCell";
    
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:newsCellIdentifier forIndexPath:indexPath];
    NewsListModel *dataModel = _list[indexPath.row];
    [cell setCellData:dataModel];
    
    WHC_BadgeView  *badgeView = nil;
    for (NSInteger i = 0; i < cell.subviews.count; i++) {
        UIView * view = cell.subviews[i];
        if([view isKindOfClass:[WHC_BadgeView class]]){
            [view removeFromSuperview];
            view = nil;
        }
    }
    if (dataModel.messageNumber.integerValue != 0) {
        badgeView = [[WHC_BadgeView alloc]initWithSuperView:cell position:CGPointMake(ScreenWidth - 27.0, 27.0) radius:10.0];
        badgeView.delegate = self;
        badgeView.index = indexPath.row;
        [badgeView setBadgeNumber:dataModel.messageNumber.integerValue];        
    }
    return cell;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - WHC_BadgeViewDelegate
- (void)whc_BadgeViewDidRemoveFromSuperViewWithIndex:(NSInteger)index center:(CGPoint)center {
    
    UIImageView *myImageView = [[UIImageView alloc] initWithFrame:CGRectMake(60, 60, 30, 30)];
    myImageView.center = CGPointMake(center.x, center.y - 64);
    
    NSMutableArray *tempImages = [NSMutableArray array];
    for (int i = 1; i <= 5; i++) {
        NSString *imageName = [NSString stringWithFormat:@"unreadBomb_%d",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [tempImages addObject:image];
    }
    myImageView.animationImages = tempImages;
    myImageView.animationDuration = 0.25f;
    myImageView.animationRepeatCount = 1;
    [myImageView startAnimating];
    [self.view addSubview:myImageView];
    
}
- (void)whc_BadgeViewWillStartDrag {
    
}

- (void)whc_BadgeViewDidEndDrag {
   
}

- (IBAction)rightMenuEvent:(UIBarButtonItem *)sender {

}

- (NSArray *) titles {
    return @[@"扫一扫",
             @"加好友",
             @"创建讨论组",
             @"发送到电脑",
             @"面对面快传",
             @"收钱"];
}

- (NSArray *) images {
    return @[@"right_menu_QR@3x",
             @"right_menu_addFri@3x",
             @"right_menu_multichat@3x",
             @"right_menu_sendFile@3x",
             @"right_menu_facetoface@3x",
             @"right_menu_payMoney@3x"];
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
