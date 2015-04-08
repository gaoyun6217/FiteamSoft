//
//  ThirdViewController.h
//  FitnessPattern
//
//  Created by 胡晓阳 on 15/1/6.
//  Copyright (c) 2015年 健身范. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThirdViewController : UIViewController


//我的资料
@property (strong, nonatomic) IBOutlet UIImageView *userHeadImgView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLB;
@property (strong, nonatomic) IBOutlet UIButton *userAgeSexArea;
@property (strong, nonatomic) IBOutlet UILabel *userSloganLB;
@property (strong, nonatomic) IBOutlet UILabel *userTeamAreaLB;
@property (strong, nonatomic) IBOutlet UITableView *myMovementTable;


//我的战队
@property (strong, nonatomic) IBOutlet UIView *myTeamView;
@property (nonatomic, copy) NSMutableDictionary *teamDetailDic;
@property (strong, nonatomic) IBOutlet UIImageView *topHeadView1;
@property (strong, nonatomic) IBOutlet UIImageView *topHeadView2;
@property (strong, nonatomic) IBOutlet UIImageView *topHeadView3;
@property (strong, nonatomic) IBOutlet UIImageView *topHeadView4;
@property (strong, nonatomic) IBOutlet UIImageView *topHeadView5;

@property (strong, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *teamSloganLB;
@property (strong, nonatomic) IBOutlet UITableView *teamMovementTable;
- (IBAction)selectTeamOrMineView:(UISegmentedControl *)sender;
- (IBAction)showSettingVCAction:(id)sender;


@end
