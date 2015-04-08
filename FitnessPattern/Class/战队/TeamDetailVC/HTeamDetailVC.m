//
//  HTeamDetailVC.m
//  FitnessPattern
//
//  Created by SharonHu on 15/3/6.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import "HTeamDetailVC.h"

@interface HTeamDetailVC ()
{
    NSMutableDictionary *_teamDetailDic;
    NSMutableArray *_teamMemberMovementsArr;
    
    UIView *_operationView;//点击操作出现的视图
    UIView *_translucentBackView;//半透明背景
}
@end

@implementation HTeamDetailVC

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
    
    
    
    [self initiateTheSubviews];
    
    [self loadDataSourceOfTeamDetail];
    
}



- (void)initiateTheSubviews
{
    //背景色
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.teamMovementTable setBackgroundColor:[UIColor whiteColor]];
    
    
    //半透明黑色背景
    _translucentBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_translucentBackView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.f]];
    UITapGestureRecognizer *tapRG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelThePopView:)];
    [_translucentBackView addGestureRecognizer:tapRG];

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
    
    _operationView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 190.f)];
    [_operationView setBackgroundColor:[UIColor whiteColor]];
    UIButton *applyButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, self.view.frame.size.width - 20, 40)];
    [applyButton setBackgroundColor:Color_ThemeOrange];
    [applyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [applyButton setTitle:@"申请加入" forState:UIControlStateNormal];
    [applyButton addTarget:self action:@selector(applyToJoinAction:) forControlEvents:UIControlEventTouchUpInside];
    [_operationView addSubview:applyButton];
    
    
    UIButton *reportButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 70, self.view.frame.size.width - 20, 40)];
    [reportButton setBackgroundColor:[UIColor whiteColor]];
    [reportButton setTitle:@"举报" forState:UIControlStateNormal];
    [reportButton addTarget:self action:@selector(reportAction:) forControlEvents:UIControlEventTouchUpInside];
    reportButton.layer.borderColor = RGBCOLOR(217.0, 217.0, 218.0).CGColor;
    reportButton.layer.borderWidth = 1.f;
    [reportButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_operationView addSubview:reportButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, 1)];
    [line setBackgroundColor:RGBCOLOR(217.0, 217.0, 218.0)];
    [_operationView addSubview:line];
    
    UIButton *cancelBT = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [cancelBT setCenter:CGPointMake(_operationView.center.x, _operationView.frame.size.height - 30)];
    [cancelBT setImage:[UIImage imageNamed:@"popover_btn_cancel02"] forState:UIControlStateNormal];
    [cancelBT addTarget:self action:@selector(cancelThePopView:) forControlEvents:UIControlEventTouchUpInside];
    [_operationView addSubview:cancelBT];
    
}

- (void)doBack:(UIButton *)sender
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



#pragma mark - 点击操作按钮的相关事件
- (void)cancelThePopView:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        [_translucentBackView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
        [_operationView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 190.f)];
    } completion:^(BOOL finished) {
        [_translucentBackView removeFromSuperview];
    }];
}

- (void)reportAction:(id)sender
{
    
}

- (IBAction)operateAction:(id)sender {
    [self.view addSubview:_translucentBackView];
    [_translucentBackView addSubview:_operationView];
    [UIView animateWithDuration:0.3 animations:^{
        [_translucentBackView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
        [_operationView setFrame:CGRectMake(0, self.view.frame.size.height - 190.f, self.view.frame.size.width, 190.f)];
    } completion:nil];
}

- (IBAction)applyToJoinAction:(id)sender {
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

#pragma mark - UITableViewDelegate & Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _teamMemberMovementsArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *movementDic = [_teamMemberMovementsArr objectAtIndex:indexPath.row];
    UITableViewCell *myCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TeamDetailCell" forIndexPath:indexPath];
    
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
    
    return myCell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 125)];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 1)];
    [line1 setBackgroundColor:RGBCOLOR(236.0, 236.0, 236.0)];
    [headView addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 124, tableView.frame.size.width, 1)];
    [line1 setBackgroundColor:RGBCOLOR(236.0, 236.0, 236.0)];
    [headView addSubview:line2];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 41, tableView.frame.size.width, 1)];
    [line3 setBackgroundColor:RGBCOLOR(236.0, 236.0, 236.0)];
    [headView addSubview:line3];
    
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, 82, tableView.frame.size.width, 1)];
    [line4 setBackgroundColor:RGBCOLOR(236.0, 236.0, 236.0)];
    [headView addSubview:line4];
    
    UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 1, 60, 40)];
    [lb1 setText:@"地点"];
    [lb1 setFont:[UIFont systemFontOfSize:14.f]];
    [headView addSubview:lb1];
    
    UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 42, 60, 40)];
    [lb2 setText:@"创建时间"];
    [lb2 setFont:[UIFont systemFontOfSize:14.f]];
    [headView addSubview:lb2];
    
    UILabel *lb3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 83, 60, 40)];
    [lb3 setText:@"战队介绍"];
    [lb3 setFont:[UIFont systemFontOfSize:14.f]];
    [headView addSubview:lb3];
    
    
    
    UILabel *addressLB = [[UILabel alloc] initWithFrame:CGRectMake(80, 1, tableView.frame.size.width - 80 - 10, 40)];
    [addressLB setText:[_teamDetailDic objectForKey:@"address"]];
    
    UILabel *buildDateLB = [[UILabel alloc] initWithFrame:CGRectMake(80, 42, tableView.frame.size.width - 90, 40)];
    [buildDateLB setText:[_teamDetailDic objectForKey:@"buildDate"]];
    
    UILabel *indroductionLB = [[UILabel alloc] initWithFrame:CGRectMake(80, 83, tableView.frame.size.width - 90, 40)];
    [indroductionLB setText:[_teamDetailDic objectForKey:@"indroduction"]];
    
    [headView addSubview:addressLB];
    [headView addSubview:buildDateLB];
    [headView addSubview:indroductionLB];
    
    [headView setBackgroundColor:[UIColor whiteColor]];
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 125.f;
}

@end
