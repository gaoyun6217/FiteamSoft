//
//  HSearchTeamsVC.m
//  FitnessPattern
//
//  Created by SharonHu on 15/3/5.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import "HSearchTeamsVC.h"

@interface HSearchTeamsVC ()
{
    NSArray *_mySelectionItems;
}
@end

@implementation HSearchTeamsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:Color_AppBackground];
    [self initSelectionItems];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)finishAction:(id)sender {
    //确定筛选信息
    [self dismissViewControllerAnimated:YES completion:^{
        //传递筛选信息，刷新首页附近战队
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshTeamsTable" object:nil];
    }];
}

- (void)initSelectionItems
{
    
    if (_mySelectionItems == nil) {
        _mySelectionItems = [NSArray arrayWithObjects:@"队长性别", @"战队类型", nil];
    }
}

#pragma mark - UITableViewDelegae & Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _mySelectionItems.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 10)];
    return footView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyCell"];
    [myCell.textLabel setText:[_mySelectionItems objectAtIndex:indexPath.row]];
    [myCell.textLabel setTextColor:RGBCOLOR(151.0, 151.0, 151.0)];
    return myCell;
    
}
@end
