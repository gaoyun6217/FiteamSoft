//
//  HUserDetailVC.h
//  FitnessPattern
//
//  Created by 胡晓阳 on 15/3/9.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUserDetailVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *userHeadImgView;
@property (strong, nonatomic) IBOutlet UILabel *userNameLB;
@property (strong, nonatomic) IBOutlet UIButton *userAgeSexArea;
@property (strong, nonatomic) IBOutlet UILabel *userSloganLB;
@property (strong, nonatomic) IBOutlet UILabel *userTeamAreaLB;

@end
