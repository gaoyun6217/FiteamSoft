//
//  FirstViewController.h
//  FitnessPattern
//
//  Created by 胡晓阳 on 14/12/25.
//  Copyright (c) 2014年 健身范. All rights reserved.
//

//附近战队
#import <UIKit/UIKit.h>
#import "LoginView.h"
#import "MYBlurIntroductionView.h"
#import "EGORefreshTableHeaderView.h"
#import "HSearchTeamsVC.h"
#import "SCNavigationController.h"
#import "HSuccessToRegistAlertView.h"

@interface FirstViewController : UIViewController<MYIntroductionDelegate,UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,SCNavigationControllerDelegate,SuccessToRegistDelegate,UITabBarControllerDelegate,UITabBarDelegate>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    
    NSMutableArray *_gymWithTeamsArr;//附近的健身会馆队列
    NSMutableArray *_gymWithMovementsArr;//动态
    
    UIView *_translucentBlackView;//黑色半透明图层
    
    HSearchTeamsVC *_mySearchTeamsVC;//筛选界面
    
    HSuccessToRegistAlertView *_registSuccessView;//注册成功弹出的对话框
    
}

@property (strong, nonatomic) IBOutlet UIView *view;
@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (nonatomic, retain) MYBlurIntroductionView *introductionView;
@property (nonatomic, retain) LoginView *loginView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *myNavRightButtonItem;
@property (strong, nonatomic) IBOutlet UISegmentedControl *mySenmentedControl;
@property (nonatomic, strong) UIImagePickerController *myImgPickerVC;

- (IBAction)myNavRightButtonItemAction:(UIBarButtonItem *)sender;
- (IBAction)changeSegmentedControlValue:(UISegmentedControl *)sender;
- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
@end

