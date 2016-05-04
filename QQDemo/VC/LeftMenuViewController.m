//
//  LeftMenuViewController.m
//  QQDemo
//
//  Created by 薛国宾 on 16/4/26.
//  Copyright © 2016年 千里之行始于足下. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "CircularLayer.h"
#import "CYMainController.h"
#import "MenuButton.h"
#import "SmallTools.h"

@interface LeftMenuViewController () {
    NSArray *_imageNames;
    NSArray *_titles;
    CALayer *_bgLayer;
    NSArray *_vcStoryboardNames;
}
@property (weak, nonatomic) IBOutlet UIImageView *quotationMarksImage;
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIImageView *headPortraitView;
@property (weak, nonatomic) IBOutlet UIButton *qrCodeButton;
@property (weak, nonatomic) IBOutlet UILabel *signatureLabel;
@property (weak, nonatomic) IBOutlet UIView *headView;
@end

static NSString *const cellIdentifier = @"tableViewCell";

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initControl];
    [self initData];
}

- (void)initControl {
    
    [self.qrCodeButton setImage:[UIImage imageNamed:@"sidebar_ QRcode_normal"] forState:UIControlStateNormal];
    [self.qrCodeButton setImage:[UIImage imageNamed:@"sidebar_ QRcode_press"] forState:UIControlStateHighlighted];
    
    UIImage *headPortraitImage = [UIImage imageNamed:@"head_portrait"];
    CGFloat wh = self.headPortraitView.frame.size.height;
    
    CircularLayer *circularLayer = [[CircularLayer alloc] initWithView:wh image:headPortraitImage];
    
    [self.headPortraitView.layer addSublayer:[CircularLayer setShadow:wh
                                                          shadowColor:[UIColor whiteColor]
                                                         shadowOffset:CGSizeZero]];
 
    [self.headPortraitView.layer addSublayer:circularLayer];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(signatureLabelTapEvent)];
    [self.signatureLabel addGestureRecognizer:tap];
}

- (void)initData {
    _imageNames = @[@"sidebar_business",@"sidebar_purse",@"sidebar_decoration",@"sidebar_favorit",@"sidebar_album",@"sidebar_file"];
    _titles = @[@"我的商城",@"QQ钱包",@"个性装扮",@"我的收藏",@"我的相册",@"我的文件"];
    
    _vcStoryboardNames = @[@"",@"",@"",@"",@"",@"",@"SetUp",@"MyQrCode",@"MySignature",@"PersonalData"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    
    cell.textLabel.text = _titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:_imageNames[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self dismissViewController:indexPath.row];
}

- (void)dismissViewController:(NSInteger)row {
    
    NSLog(@"%@ ---> row = %ld",CodeHere,(long)row);
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
//        if (row > 5) {
//            UINavigationController *nav = [self getCurrentNav];
//            
//            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//            UIViewController *pushVC = [storyboard instantiateViewControllerWithIdentifier:_vcStoryboardNames[row]];
//            [nav pushViewController:pushVC animated:YES];
//        }
    }];
}

- (UINavigationController *)getCurrentNav {
    UITabBarController *tabBar = (UITabBarController *)self.mm_drawerController.centerViewController;
    UINavigationController *nav = tabBar.selectedViewController;
    return nav;
}

- (IBAction)setUpEvent {
    [self dismissViewController:6];
}

- (IBAction)qrCodeEvent {
    [self dismissViewController:7];
}

- (void)signatureLabelTapEvent {
    [self dismissViewController:8];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self.headView];
    if (point.x < self.view.frame.size.width * 0.75f && point.y < 110 && point.y > 20) {
        [self dismissViewController:9];
    }
}

- (IBAction)moonEvent {
}

- (void)addObserver {
    UINavigationController *nav = [self getCurrentNav];
    UIViewController *vc = nav.topViewController;
    MenuButton *menuBtn;
    if ([NSStringFromClass(vc.class) isEqualToString:@"CYNewsVC"]) {
        menuBtn = [[SmallTools sharedManager] newsButton];
    } else if ([NSStringFromClass(vc.class) isEqualToString:@"CYContacterVC"]) {
        menuBtn = [[SmallTools sharedManager] contacterButton];
    } else {
        menuBtn = [[SmallTools sharedManager] dynamicButton];
    }
    
    [self addObserver:menuBtn forKeyPath:@"view.transform.tx" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
