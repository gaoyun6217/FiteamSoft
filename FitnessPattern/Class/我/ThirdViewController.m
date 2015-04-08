//
//  ThirdViewController.m
//  FitnessPattern
//
//  Created by 胡晓阳 on 15/1/6.
//  Copyright (c) 2015年 健身范. All rights reserved.
//

#import "ThirdViewController.h"

@interface ThirdViewController ()
{
    NSMutableDictionary *_myInfoDic;
    NSMutableArray *_myMovementsArr;
    
    NSMutableDictionary *_teamDetailDic;
    NSMutableArray *_teamMemberMovementsArr;
}
@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadTheSubviews];
    
    [self loadDataSourceOfTeamDetail];
    [self loadTheDataSourceOfMyMovement];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.tabBarController.tabBar setHidden:NO];
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

- (void)loadTheSubviews
{
    [self.userHeadImgView.layer setMasksToBounds:YES];
    [self.userHeadImgView.layer setCornerRadius:50.f];
    
    self.topHeadView1.layer.masksToBounds = YES;
    self.topHeadView1.layer.cornerRadius = 25.0;
    self.topHeadView2.layer.masksToBounds = YES;
    self.topHeadView2.layer.cornerRadius = 25.0;
    self.topHeadView3.layer.masksToBounds = YES;
    self.topHeadView3.layer.cornerRadius = 25.0;
    self.topHeadView4.layer.masksToBounds = YES;
    self.topHeadView4.layer.cornerRadius = 25.0;
    self.topHeadView5.layer.masksToBounds = YES;
    self.topHeadView5.layer.cornerRadius = 25.0;
}


#pragma mark - 获取我的动态数据
- (void)loadTheDataSourceOfMyMovement
{
    _myInfoDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"headPic.jpg", @"userPic", @"Sharon", @"userName", @"我要练就魔鬼身材！",@"userSlogan", @"1", @"sex", @"24",@"age", @"腹肌撕裂者",@"teamName",@"增肌",@"teamType",nil];
    
    [self.userNameLB  setText:[_myInfoDic objectForKey:@"userName"]];
    [self.userSloganLB setText:[_myInfoDic objectForKey:@"userSlogan"]];
    [self.userHeadImgView setImage:[UIImage imageNamed:[_myInfoDic objectForKey:@"userPic"]]];
    [self.userAgeSexArea setImage:[[_myInfoDic objectForKey:@"sex"] integerValue] == 1 ? [UIImage imageNamed:@"boy.png"] : [UIImage imageNamed:@"girl.png"] forState:UIControlStateNormal];
    [self.userAgeSexArea setTitle:[_myInfoDic objectForKey:@"age"] forState:UIControlStateNormal];
    
    [self.userTeamAreaLB setText:[NSString stringWithFormat:@"%@ / %@",[_myInfoDic objectForKey:@"teamName"],[_myInfoDic objectForKey:@"teamType"]]];
    
    
    _myMovementsArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSString *mHeadPic1Url1 = @"headPic.jpg";
    NSString *mName1 = @"SharonHu";
    NSString *mDate1 = @"2015-3-1";
    NSString *mMovementPicUrl1 = @"Toronto, ON.jpg";
    NSString *mMovementContent1 = @"肌肉酸痛的要死，500个俯卧撑，超越体力的极限。做了差不多二十分钟，后来实在是做不动了，……";
    NSDictionary *mMovementDic1 = [NSDictionary dictionaryWithObjectsAndKeys:mHeadPic1Url1,@"headPicUrl",mName1,@"name",mDate1,@"date",mMovementPicUrl1,@"contentPicUrl",mMovementContent1,@"content", nil];
    [_myMovementsArr addObject:mMovementDic1];
    
    NSString *mHeadPic1Url2 = @"headPic.jpg";
    NSString *mName2 = @"SharonHu";
    NSString *mDate2 = @"2015-3-2";
    NSString *mMovementPicUrl2 = @"Toronto, ON.jpg";
    NSString *mMovementContent2 = @"肌肉酸痛的要死，500个俯卧撑，超越体力的极限。做了差不多二十分钟，后来实在是做不动了，……";
    NSDictionary *mMovementDic2 = [NSDictionary dictionaryWithObjectsAndKeys:mHeadPic1Url2,@"headPicUrl",mName2,@"name",mDate2,@"date",mMovementPicUrl2,@"contentPicUrl",mMovementContent2,@"content", nil];
    [_myMovementsArr addObject:mMovementDic2];
}

#pragma mark - 获取战队详情数据
- (void)loadDataSourceOfTeamDetail
{
    
    
    _teamDetailDic = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"腹肌撕裂者", @"teamName", @"一起来用汗水雕刻自己的身体吧", @"teamSlogan", @"金鹰国际中心金仕堡健身中心",@"address", @"2014/12/23", @"buildDate", @"一起用汗水雕刻自己的身体吧！",@"indroduction",nil];
    
    [self.teamNameLabel setText:[_teamDetailDic objectForKey:@"teamName"]];
    [self.teamSloganLB setText:[_teamDetailDic objectForKey:@"teamSlogan"]];
    
    
    _teamMemberMovementsArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    NSString *mHeadPic1Url1 = @"headPic.jpg";
    NSString *mName1 = @"SharonHu";
    NSString *mDate1 = @"2015-3-1";
    NSString *mMovementPicUrl1 = @"Toronto, ON.jpg";
    NSString *mMovementContent1 = @"肌肉酸痛的要死，500个俯卧撑，超越体力的极限。做了差不多二十分钟，后来实在是做不动了，……";
    NSDictionary *mMovementDic1 = [NSDictionary dictionaryWithObjectsAndKeys:mHeadPic1Url1,@"headPicUrl",mName1,@"name",mDate1,@"date",mMovementPicUrl1,@"contentPicUrl",mMovementContent1,@"content", nil];
    [_teamMemberMovementsArr addObject:mMovementDic1];
    
    NSString *mHeadPic1Url2 = @"headPic.jpg";
    NSString *mName2 = @"SharonHu";
    NSString *mDate2 = @"2015-3-2";
    NSString *mMovementPicUrl2 = @"Toronto, ON.jpg";
    NSString *mMovementContent2 = @"肌肉酸痛的要死，500个俯卧撑，超越体力的极限。做了差不多二十分钟，后来实在是做不动了，……";
    NSDictionary *mMovementDic2 = [NSDictionary dictionaryWithObjectsAndKeys:mHeadPic1Url2,@"headPicUrl",mName2,@"name",mDate2,@"date",mMovementPicUrl2,@"contentPicUrl",mMovementContent2,@"content", nil];
    [_teamMemberMovementsArr addObject:mMovementDic2];
    
    
    
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - UITableView Delegate & Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = 0;
    if ([tableView isEqual:self.myMovementTable]) {
        num = _myMovementsArr.count;
    }
    else
    {
        num = _teamMemberMovementsArr.count;
    }
    return num;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *myCell = nil;
    if (myCell == nil) {
        if ([tableView isEqual:self.myMovementTable])
        {
            myCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MovementCell" forIndexPath:indexPath];
            
            NSDictionary *movementDic = [_myMovementsArr objectAtIndex:indexPath.row];
            NSString *headPicUrl = [movementDic objectForKey:@"headPicUrl"];
            NSString *name = [movementDic objectForKey:@"name"];
            NSString *date = [movementDic objectForKey:@"date"];
            NSString *content = [movementDic objectForKey:@"content"];
            NSString *contentPicUrl = [movementDic objectForKey:@"contentPicUrl"];
            
            //头像
            UIImageView *headPicView = (UIImageView *)[myCell.contentView viewWithTag:101];
            [headPicView setImage:[UIImage imageNamed:headPicUrl]];
            headPicView.layer.masksToBounds = YES;
            headPicView.layer.cornerRadius = 15.0;
            
            //姓名
            UILabel *nameLB = (UILabel *)[myCell.contentView viewWithTag:102];
            [nameLB setTextColor:RGBCOLOR(43.0, 43.0, 51.0)];
            [nameLB setText:name];
            
            //发布日期
            UILabel *dateLB = (UILabel *)[myCell.contentView viewWithTag:103];
            [dateLB setTextColor:RGBCOLOR(176.0, 176.0, 180.0)];
            [dateLB setText:date];
            
            UIImageView *contentPicImgView = (UIImageView *)[myCell.contentView viewWithTag:104];
            [contentPicImgView setImage:[UIImage imageNamed:contentPicUrl]];
            
            UILabel *contentLB = (UILabel *)[myCell.contentView viewWithTag:105];
            [contentLB setTextColor:RGBCOLOR(75.0, 74.0, 82.0)];
            [contentLB setText:content];
            
            [contentLB setLineBreakMode:NSLineBreakByWordWrapping];
            [contentLB setNumberOfLines:4];
            
        }
        else
        {
            NSDictionary *movementDic = [_teamMemberMovementsArr objectAtIndex:indexPath.row];
            myCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TeamDetailCell" forIndexPath:indexPath];
            
            NSString *headPicUrl = [movementDic objectForKey:@"headPicUrl"];
            NSString *name = [movementDic objectForKey:@"name"];
            NSString *date = [movementDic objectForKey:@"date"];
            NSString *content = [movementDic objectForKey:@"content"];
            NSString *contentPicUrl = [movementDic objectForKey:@"contentPicUrl"];
            
            //头像
            UIImageView *headPicView = (UIImageView *)[myCell.contentView viewWithTag:101];
            [headPicView setImage:[UIImage imageNamed:headPicUrl]];
            headPicView.layer.masksToBounds = YES;
            headPicView.layer.cornerRadius = 15.0;
            
            //姓名
            UILabel *nameLB = (UILabel *)[myCell.contentView viewWithTag:102];
            [nameLB setTextColor:RGBCOLOR(43.0, 43.0, 51.0)];
            [nameLB setText:name];
            
            //发布日期
            UILabel *dateLB = (UILabel *)[myCell.contentView viewWithTag:103];
            [dateLB setTextColor:RGBCOLOR(176.0, 176.0, 180.0)];
            [dateLB setText:date];
            
            UIImageView *contentPicImgView = (UIImageView *)[myCell.contentView viewWithTag:104];
            [contentPicImgView setImage:[UIImage imageNamed:contentPicUrl]];
            
            UILabel *contentLB = (UILabel *)[myCell.contentView viewWithTag:105];
            [contentLB setTextColor:RGBCOLOR(75.0, 74.0, 82.0)];
            [contentLB setText:content];
            
            [contentLB setLineBreakMode:NSLineBreakByWordWrapping];
            [contentLB setNumberOfLines:4];

        }

    }
        
    
    
    return myCell;
}



- (IBAction)selectTeamOrMineView:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
        {
            //我的战队
            [UIView animateWithDuration:0.3 animations:^{
                [self.myTeamView setAlpha:1.0];
            } completion:nil];
        }
            break;
        case 1:
        {
            //我的资料
            [UIView animateWithDuration:0.3 animations:^{
                [self.myTeamView setAlpha:0.0];
            } completion:nil];
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)showSettingVCAction:(id)sender {
    [self.navigationController performSegueWithIdentifier:@"ShowSettingVC" sender:nil];
    [self.tabBarController.tabBar setHidden:YES];
}

@end
