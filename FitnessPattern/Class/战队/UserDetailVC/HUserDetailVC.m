//
//  HUserDetailVC.m
//  FitnessPattern
//
//  Created by 胡晓阳 on 15/3/9.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import "HUserDetailVC.h"

@interface HUserDetailVC ()
{
    NSMutableDictionary *_myInfoDic;
    NSMutableArray *_myMovementsArr;
    
    UIView *_operationView;//点击操作出现的视图
    UIView *_translucentBackView;//半透明背景
}
@end

@implementation HUserDetailVC

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
    
    
    [self loadTheSubviews];
    //获取数据
    [self loadTheDataSourceOfMyMovement];

}

- (void)doBack:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadTheSubviews
{
    [self.userHeadImgView.layer setMasksToBounds:YES];
    [self.userHeadImgView.layer setCornerRadius:50.f];
    
    UIBarButtonItem *operationBI = [[UIBarButtonItem alloc] initWithTitle:@"操作" style:UIBarButtonItemStylePlain target:self action:@selector(operationAction:)];
    [self.navigationItem setRightBarButtonItem:operationBI];
    
    _operationView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 150.f)];
    [_operationView setBackgroundColor:[UIColor whiteColor]];
    
    
    UIButton *reportButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, self.view.frame.size.width - 20, 40)];
    [reportButton setBackgroundColor:[UIColor whiteColor]];
    [reportButton setTitle:@"举报" forState:UIControlStateNormal];
    [reportButton addTarget:self action:@selector(reportAction:) forControlEvents:UIControlEventTouchUpInside];
    reportButton.layer.borderColor = RGBCOLOR(217.0, 217.0, 218.0).CGColor;
    reportButton.layer.borderWidth = 1.f;
    [reportButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_operationView addSubview:reportButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 80, self.view.frame.size.width, 1)];
    [line setBackgroundColor:RGBCOLOR(217.0, 217.0, 218.0)];
    [_operationView addSubview:line];
    
    UIButton *cancelBT = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [cancelBT setCenter:CGPointMake(_operationView.center.x, _operationView.frame.size.height - 40)];
    [cancelBT setImage:[UIImage imageNamed:@"popover_btn_cancel02"] forState:UIControlStateNormal];
    [cancelBT addTarget:self action:@selector(cancelThePopView:) forControlEvents:UIControlEventTouchUpInside];
    [_operationView addSubview:cancelBT];
    
    
    //半透明黑色背景
    _translucentBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_translucentBackView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.f]];
    UITapGestureRecognizer *tapRG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelThePopView:)];
    [_translucentBackView addGestureRecognizer:tapRG];
}

//操作
- (void)operationAction:(id)sender
{
    [self.view addSubview:_translucentBackView];
    [_translucentBackView addSubview:_operationView];
    [UIView animateWithDuration:0.3 animations:^{
        [_translucentBackView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
        [_operationView setFrame:CGRectMake(0, self.view.frame.size.height - 150.f, self.view.frame.size.width, 150.f)];
    } completion:nil];
}

//举报
- (void)reportAction:(id)sender
{
    
}

//取消操作
- (void)cancelThePopView:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        [_translucentBackView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
        [_operationView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 150.f)];
    } completion:^(BOOL finished) {
        [_translucentBackView removeFromSuperview];
    }];
}

//获取我的动态数据
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

#pragma mark - UITableView Delegate & Methods 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _myMovementsArr.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *myCell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"MovementCell" forIndexPath:indexPath];
    
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

    
    
    return myCell;
}



@end
