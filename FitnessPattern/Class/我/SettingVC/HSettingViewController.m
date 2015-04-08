//
//  HSettingViewController.m
//  FitnessPattern
//
//  Created by SharonHu on 15/3/21.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import "HSettingViewController.h"

@interface HSettingViewController ()

@end

@implementation HSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //改变title颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    //修改返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    [self.settingTableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    [self.settingTableView setContentOffset:CGPointMake(0, -128)];
}

- (void)doBack:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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

#pragma mark - Table
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = 1;
    if (section == 0) {
        num = 5;
    }else if(section == 1)
        num = 4;
    return num;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 164)];
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.frame.size.width/2.0 - 15.0, 25, 30, 45)];
    [logo setImage:[UIImage imageNamed:@"logo02"]];
    [footerView addSubview:logo];
    
    
    UILabel *versionLB = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width/2.f - 50.0, logo.frame.origin.y+45+10, 100, 21)];
    [versionLB setTextAlignment:NSTextAlignmentCenter];
    [versionLB setText:@"Version 1.0"];
    [versionLB setTextColor:[UIColor lightGrayColor]];
    [footerView addSubview:versionLB];
    return footerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = nil;
    if (section == 0) {
        headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0, tableView.frame.size.width, 140)];
        [headerView setBackgroundColor:[UIColor whiteColor]];
        
        UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 100, 100)];
        [headImageView.layer setMasksToBounds:YES];
        [headImageView.layer setCornerRadius:50.f];
        [headImageView setImage:[UIImage imageNamed:@"headPic.jpg"]];
        [headImageView setCenter:CGPointMake(headerView.center.x, headerView.center.y - 50)];
        [headerView addSubview:headImageView];
        
        UIView *vLine = [[UIView alloc] initWithFrame:CGRectMake(headerView.frame.size.width/2.0 - 0.5, 125, 1, 10)];
        [vLine setBackgroundColor:[UIColor lightGrayColor]];
        [headerView addSubview:vLine];
        
        UIButton *headImageSetBT = [[UIButton alloc] initWithFrame:CGRectMake(0, 120, headerView.frame.size.width/2.0, 20)];
        [headImageSetBT setTitle:@"设置头像" forState:UIControlStateNormal];
        [headImageSetBT setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        UIButton *backImageSetBT = [[UIButton alloc] initWithFrame:CGRectMake(headerView.frame.size.width, 120, headerView.frame.size.width, 20)];
        [backImageSetBT setTitle:@"设置背景图" forState:UIControlStateNormal];
        [backImageSetBT setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [headerView addSubview:headImageSetBT];
        [headerView addSubview:backImageSetBT];
        
        
        UIView *hLine = [[UIView alloc] initWithFrame:CGRectMake(0, 139, headerView.frame.size.width, 1)];
        [hLine setBackgroundColor:[UIColor lightGrayColor]];
        [headerView addSubview:hLine];
        
    }
     return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0.f;
    if (section == 0) {
        height = 140.f;
    }
    return height;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SettingCell"];
    switch (indexPath.section) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                    [myCell.textLabel setText:@"ID"];
                    break;
                case 1:
                    [myCell.textLabel setText:@"简介"];
                    break;
                case 2:
                    [myCell.textLabel setText:@"年龄"];
                    break;
                case 3:
                    [myCell.textLabel setText:@"性别"];
                    break;
                case 4:
                    [myCell.textLabel setText:@"战队类型"];
                    break;
                    
                    
                default:
                    break;
            }

        }
            break;
        case 1:
        {
            switch (indexPath.row) {
                case 0:
                    [myCell.textLabel setText:@"接受推送通知"];
                    break;
                case 1:
                {
                    myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"myCell"];
                    [myCell.textLabel setText:@"省流量模式"];
                    [myCell.detailTextLabel setText:@"已开启，在移动网络下只加载缩略图"];
                }
                    break;
                case 2:
                {
                    [myCell.textLabel setText:@"意见与反馈"];
                }
                    break;
                case 3:
                {
                    [myCell.textLabel setText:@"退出当前账户"];
                }
                    break;
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
        return myCell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *titleOfHeader = @"";
    if (section == 1) {
        titleOfHeader = @"其他";
    }
    return titleOfHeader;
}
@end
