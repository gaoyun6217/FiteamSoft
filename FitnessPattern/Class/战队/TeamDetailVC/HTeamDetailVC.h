//
//  HTeamDetailVC.h
//  FitnessPattern
//
//  Created by SharonHu on 15/3/6.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTeamDetailVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, copy) NSMutableDictionary *teamDetailDic;
@property (strong, nonatomic) IBOutlet UIImageView *topHeadView1;
@property (strong, nonatomic) IBOutlet UIImageView *topHeadView2;
@property (strong, nonatomic) IBOutlet UIImageView *topHeadView3;
@property (strong, nonatomic) IBOutlet UIImageView *topHeadView4;
@property (strong, nonatomic) IBOutlet UIImageView *topHeadView5;

@property (strong, nonatomic) IBOutlet UILabel *teamNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *teamSloganLB;
@property (strong, nonatomic) IBOutlet UITableView *teamMovementTable;
- (IBAction)operateAction:(id)sender;
- (IBAction)applyToJoinAction:(id)sender;
@end
