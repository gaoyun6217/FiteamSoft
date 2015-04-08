//
//  HSettingViewController.h
//  FitnessPattern
//
//  Created by SharonHu on 15/3/21.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HSettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *settingTableView;
@end
