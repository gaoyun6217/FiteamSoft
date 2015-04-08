//
//  FirstViewController.m
//  FitnessPattern
//
//  Created by 胡晓阳 on 14/12/25.
//  Copyright (c) 2014年 健身范. All rights reserved.
//

//3.5
#import "FirstViewController.h"
#import "MYCustomPanel.h"

@interface FirstViewController ()
{
    AppDelegate *_appDelegate;
    BOOL showTeamsNearby;//显示附近战队页面
    UITableView *_movementTableView;//动态Table
    UIView *_tmpView;
    UIView *_alertViewOfCreateATeam;//创建战队的提示框
}
@end

@implementation FirstViewController

-(void)viewWillAppear:(BOOL)animated
{
    if (showTeamsNearby == YES || [[[NSUserDefaults standardUserDefaults] objectForKey:@"ShowTeamsNearby"] boolValue] == YES)
    {
        _myNavRightButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchTeamsAround)];

    }else
    {
        _myNavRightButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(openTheCamera)];
    }
    [self.navigationItem setRightBarButtonItem:_myNavRightButtonItem];
    [self.tabBarController.tabBar setHidden:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:showTeamsNearby] forKey:@"ShowTeamsNearby"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //添加观察者
    [self addSomeObservers];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"FirstVCAppear1st"]) {
        //如果没有登陆的用户，则进入登陆界面
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"] == nil) {
            [self buildLoginViewWithAnimation:NO];
        }
        
        //若第一次启动，则展示应用引导页
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
            [self buildIntro];
        }
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FirstVCAppear1st"];
    }
    
    self.tabBarController.delegate = self;
    
    //初始化子视图
    [self initiateSubviews];
    
    showTeamsNearby = YES;
    
//    self.tabBarController.tabBar.delegate = self;
    self.tabBarController.delegate = self;
    
    // Do any additional setup after loading the view, typically from a nib.
    
    //    //下拉刷新
    //    if (_refreshHeaderView == nil) {
    //
    //        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:self.myTableView.frame];
    //        view.delegate = self;
    //        [self.view insertSubview:view belowSubview:self.myTableView];
    //        _refreshHeaderView = view;
    //
    //    }
    //
    //    //  update the last update date
    //    [_refreshHeaderView refreshLastUpdatedDate];
    
    
    
    
    if (_gymWithTeamsArr == nil || [_gymWithTeamsArr count] == 0) {
        [self.myTableView setHidden:YES];
        [self getDataSource_TeamsNearby];
    }
    
    
}


#pragma mark - 添加观察者
- (void)addSomeObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTheTeamsTable:) name:@"RefreshTheTable" object:nil];
    
    //弹出注册完成后的欢迎对话框
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(successToRegist:) name:@"SuccessToRegist" object:nil];
    
    //登录成功的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(successToLogin:) name:@"SuccessToLogin" object:nil];
    
    //取消登录注册的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelLoginAndRegist) name:@"CancelLoginRegist" object:nil];

    //没有用户登录，显示登录注册
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentLoginView:) name:@"PresentLoginView" object:nil];
}

//注册成功
- (void)successToRegist:(NSNotification *)notification
{
    [_loginView removeFromSuperview];
    NSDictionary *userinfo = notification.userInfo;
    if (_registSuccessView == nil) {
        _registSuccessView = [[HSuccessToRegistAlertView alloc] initWithFrame:CGRectMake(0, 0, 300, 400) andPhonenumber:[userinfo objectForKey:@"phonenumber"]];
        _registSuccessView.myDelegate = self;
    }
    
    
    [UIView animateWithDuration:0.3 animations:^{
        [_translucentBlackView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
        [_registSuccessView setAlpha:1.f];
    } completion:^(BOOL finished) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:_translucentBlackView];
        [_registSuccessView setCenter:CGPointMake(_translucentBlackView.center.x, _translucentBlackView.center.y)];
        [_translucentBlackView addSubview:_registSuccessView];
    }];

}

//注册成功对话框的代理方法
-(void)cancelRegistSuccessView
{
    NSLog(@"不再提醒完善资料");
    [UIView animateWithDuration:0.3 animations:^{
        [_translucentBlackView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
        [_registSuccessView setAlpha:0.f];
    } completion:^(BOOL finished) {
        [_registSuccessView removeFromSuperview];
        [_translucentBlackView removeFromSuperview];
    }];

}

-(void)goToPerfectInformation
{
    [UIView animateWithDuration:0.3 animations:^{
        [_translucentBlackView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
        [_registSuccessView setAlpha:0.f];
    } completion:^(BOOL finished) {
        [_registSuccessView removeFromSuperview];
        [_translucentBlackView removeFromSuperview];
    }];
    
    //进入完善界面
    [self.navigationController performSegueWithIdentifier:@"ShowPerfectVC" sender:nil];
}

//登录成功
- (void)successToLogin:(NSNotification *)notification
{
    [_loginView removeFromSuperview];
}

//取消登录注册
- (void)cancelLoginAndRegist
{
    [self buildLoginViewWithAnimation:NO];
}

//刷新附近战队
- (void)refreshTheTeamsTable:(NSNotification *)notiification
{
    //获取筛选后的附近战队信息
    NSLog(@"获取筛选后的附近战队信息");
    
    [_myTableView reloadData];
}

//没有登录的情况下，点击“消息”和“我”，展示登录注册
- (void)presentLoginView:(NSNotification *)notification
{
    [self buildLoginViewWithAnimation:YES];
}






#pragma mark - 初始化子视图
-(void)initiateSubviews
{
    //黑色半透明图层
    _translucentBlackView = [[UIView alloc] init];
    [_translucentBlackView setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [_translucentBlackView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.f]];
    UITapGestureRecognizer *tapBackViewGestureRe = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAlertViewOfCreateATeam:)];
    [_translucentBlackView addGestureRecognizer:tapBackViewGestureRe];
    
    //附近战队table
    //[self.myTableView setFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-44)];
    
    //动态的table
    _movementTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-44) style:UITableViewStylePlain];
    _movementTableView.delegate = self;
    _movementTableView.dataSource = self;
    [_movementTableView setBackgroundColor:[UIColor blackColor]];
    [_movementTableView setAlpha:0.f];
    
    [self.myTableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    [_movementTableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f)];
    
    [_movementTableView setContentOffset:CGPointMake(0, -64)];
    [self.view addSubview:_movementTableView];
    
    //创建战队的提示框
    _alertViewOfCreateATeam = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 400)];
    [_alertViewOfCreateATeam setBackgroundColor:[UIColor colorWithWhite:1 alpha:1]];
    _alertViewOfCreateATeam.layer.masksToBounds = YES;
    _alertViewOfCreateATeam.layer.cornerRadius = 6.0;
    
    
    UIButton *closeBT = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 30, 30)];
    [closeBT setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [closeBT addTarget:self action:@selector(closeAlertViewOfCreateATeam:) forControlEvents:UIControlEventTouchUpInside];
    [_alertViewOfCreateATeam addSubview:closeBT];
    
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(_alertViewOfCreateATeam.frame.size.width/2 - 50.f, 25, 100, 21)];
    [titleLB setTextAlignment:NSTextAlignmentCenter];
    [titleLB setTextColor:Color_ThemeOrange];
    [titleLB setText:@"创建战队"];
    [_alertViewOfCreateATeam addSubview:titleLB];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 60, _alertViewOfCreateATeam.frame.size.width, 1)];
    [lineView setBackgroundColor:RGBCOLOR(230.0, 239.0, 230.0)];
    [_alertViewOfCreateATeam addSubview:lineView];
    
    UIButton *cancelBT = [[UIButton alloc] initWithFrame:CGRectMake(20, 340, 115, 40)];
    [cancelBT setBackgroundColor:RGBCOLOR(38.0, 37.0, 45.0)];
    [cancelBT setTitle:@"返回" forState:UIControlStateNormal];
    [cancelBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBT addTarget:self action:@selector(closeAlertViewOfCreateATeam:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *agreeBT = [[UIButton alloc] initWithFrame:CGRectMake(165, 340, 115, 40)];
    [agreeBT setBackgroundColor:Color_ThemeOrange];
    [agreeBT setTitle:@"确认" forState:UIControlStateNormal];
    [agreeBT setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [agreeBT addTarget:self action:@selector(confirmToCreateATeam) forControlEvents:UIControlEventTouchUpInside];
    
    [_alertViewOfCreateATeam addSubview:cancelBT];
    [_alertViewOfCreateATeam addSubview:agreeBT];
    
    UILabel *lb0 = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 280, 60)];
    [lb0 setTextColor:RGBCOLOR(40.0, 38.0, 50.0)];
    [lb0 setFont:[UIFont systemFontOfSize:14.f]];
    [lb0 setTextAlignment:NSTextAlignmentCenter];
    [lb0 setText:@"在创建战队之前，请先阅读下面的话："];
    [_alertViewOfCreateATeam addSubview:lb0];
    
    UIImageView *questionView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 120, 260, 176)];
    [questionView setImage:[UIImage imageNamed:@"questions"]];
    [_alertViewOfCreateATeam addSubview:questionView];
    
}




#pragma mark - Build MYBlurIntroductionView

-(void)buildIntro{
    
    //Create Stock Panel with header
    UIView *headerView = [[NSBundle mainBundle] loadNibNamed:@"TestHeader" owner:nil options:nil][0];
    MYIntroductionPanel *panel1 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"Welcome to MYBlurIntroductionView" description:@"MYBlurIntroductionView is a powerful platform for building app introductions and tutorials. Built on the MYIntroductionView core, this revamped version has been reengineered for beauty and greater developer control." image:[UIImage imageNamed:@"HeaderImage.png"] header:headerView];
    
    //Create Stock Panel With Image
    MYIntroductionPanel *panel2 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) title:@"Automated Stock Panels" description:@"Need a quick-and-dirty solution for your app introduction? MYBlurIntroductionView comes with customizable stock panels that make writing an introduction a walk in the park. Stock panels come with optional blurring (iOS 7) and background image. A full panel is just one method away!" image:[UIImage imageNamed:@"ForkImage.png"]];
    
    //Create Panel From Nib
    MYIntroductionPanel *panel3 = [[MYIntroductionPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) nibNamed:@"TestPanel3"];
    
    //Create custom panel with events
    MYCustomPanel *panel4 = [[MYCustomPanel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) nibNamed:@"MYCustomPanel"];
    
    //Add panels to an array
    NSArray *panels = @[panel1, panel2, panel3, panel4];
    
    //Create the introduction view and set its delegate
    _introductionView = [[MYBlurIntroductionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _introductionView.delegate = self;
    _introductionView.BackgroundImageView.image = [UIImage imageNamed:@"Toronto, ON.jpg"];
    //introductionView.LanguageDirection = MYLanguageDirectionRightToLeft;
    
    //Build the introduction with desired panels
    [_introductionView buildIntroductionWithPanels:panels];
    
    //Add the introduction to your view
    //    [self.view addSubview:introductionView];
    [[[UIApplication sharedApplication] keyWindow] addSubview:_introductionView];
    
}

#pragma mark - MYIntroduction Delegate
-(void)introduction:(MYBlurIntroductionView *)introductionView didChangeToPanel:(MYIntroductionPanel *)panel withIndex:(NSInteger)panelIndex{
    NSLog(@"Introduction did change to panel %ld", (long)panelIndex);
    
    //You can edit introduction view properties right from the delegate method!
    //If it is the first panel, change the color to green!
    if (panelIndex == 0) {
        [introductionView setBackgroundColor:[UIColor colorWithRed:90.0f/255.0f green:175.0f/255.0f blue:113.0f/255.0f alpha:1]];
    }
    //If it is the second panel, change the color to blue!
    else if (panelIndex == 1){
        [introductionView setBackgroundColor:[UIColor colorWithRed:50.0f/255.0f green:79.0f/255.0f blue:133.0f/255.0f alpha:1]];
    }
    
}

-(void)introduction:(MYBlurIntroductionView *)introductionView didFinishWithType:(MYFinishType)finishType {
    NSLog(@"Introduction did finish");
}




#pragma mark - 登陆页面
- (void)buildLoginViewWithAnimation:(BOOL)animated
{
    //进入登陆界面
    if (_loginView == nil) {
        _loginView = [[LoginView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, self.view.frame.size.height)];
    }
    
    
    UIButton *registBT = (UIButton *)[_loginView viewWithTag:11];
    UIButton *loginBT = (UIButton *)[_loginView viewWithTag:12];
    UIButton *registLaterBT = [[UIButton alloc] initWithFrame:CGRectMake(_loginView.frame.size.width - 100, 20, 90, 30)];
    [registLaterBT setTitle:@"稍后注册》" forState:UIControlStateNormal];
    [registLaterBT setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_loginView addSubview:registLaterBT];
    [registLaterBT addTarget:self action:@selector(registLaberAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [loginBT addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [registBT addTarget:self action:@selector(registAction:) forControlEvents:UIControlEventTouchUpInside];
    [registLaterBT addTarget:self action:@selector(registLaberAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (animated) {
        [_loginView setAlpha:0.f];
        [[[UIApplication sharedApplication] keyWindow] addSubview:_loginView];
        [UIView animateWithDuration:0.3 animations:^{
            [_loginView setAlpha:1.f];
        } completion:nil];
    }else
    {
        [[[UIApplication sharedApplication] keyWindow] addSubview:_loginView];
    }
    
}

#pragma mark - LoginDelegate Methods
-(void)loginAction:(UIButton *)sender
{
    
    [_loginView removeFromSuperview];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController performSegueWithIdentifier:@"ShowLoginVC" sender:nil];
}

-(void)registAction:(UIButton *)sender
{
    [_loginView removeFromSuperview];
    [self.tabBarController.tabBar setHidden:YES];
    [self.navigationController performSegueWithIdentifier:@"ShowRegistVC" sender:nil];
}

-(void)registLaberAction:(UIButton *)sender
{

    [UIView animateWithDuration:0.3 animations:^{
        [_loginView setAlpha:0.f];
    } completion:^(BOOL finished) {
        [_loginView removeFromSuperview];
    }];

}


#pragma mark - 获取数据

//附近战队
-(void)getDataSource_TeamsNearby
{
    _gymWithTeamsArr = [[NSMutableArray alloc] initWithCapacity:0];
    /*第一个健身会馆*/
    NSMutableDictionary *gym1 = [[NSMutableDictionary alloc] init];
    NSString *gymName1 = @"健身会馆1";
    NSString *gymDistance1 = @"1KM";
    //该健身馆的所有战队
    NSMutableArray *teamArr1 = [[NSMutableArray alloc] initWithCapacity:0];
    //第一个战队
    NSMutableDictionary *team1 = [[NSMutableDictionary alloc] init];
    NSString *teamLogoUrl1 = @"headPic.png";//后期改为URL链接
    NSString *teamName1 = @"腹肌撕裂者";
    NSString *teamType1 = @"增肌";
    NSNumber *isFull1 = [NSNumber numberWithBool:NO];
    NSString *teamDetailImage1 = @"Toronto, ON.jpg";
    NSString *description1 = @"练习半年，维度大了一圈，非常辛苦，也非常难得。感谢鼓励我坚持下来的小伙伴们，希望有新伙伴能够加入我们，我们一起做健身达人！";
    
    [team1 setObject:teamLogoUrl1 forKey:@"teamLogo"];
    [team1 setObject:teamName1 forKey:@"teamName"];
    [team1 setObject:teamType1 forKey:@"teamType"];
    [team1 setObject:isFull1 forKey:@"isFull"];
    [team1 setObject:teamDetailImage1 forKey:@"teamDetailImage"];
    [team1 setObject:description1 forKey:@"description"];
    
    [teamArr1 addObject:team1];
    
    //第2个战队
    NSMutableDictionary *team2 = [[NSMutableDictionary alloc] init];
    NSString *teamLogoUrl2 = @"headPic.png";//后期改为URL链接
    NSString *teamName2 = @"腹肌撕裂者";
    NSString *teamType2 = @"增肌";
    NSNumber *isFull2 = [NSNumber numberWithBool:NO];
    NSString *teamDetailImage2 = @"Toronto, ON.jpg";
    NSString *description2 = @"练习半年，维度大了一圈，非常辛苦，也非常难得。感谢鼓励我坚持下来的小伙伴们，希望有新伙伴能够加入我们，我们一起做健身达人！";
    
    [team2 setObject:teamLogoUrl2 forKey:@"teamLogo"];
    [team2 setObject:teamName2 forKey:@"teamName"];
    [team2 setObject:teamType2 forKey:@"teamType"];
    [team2 setObject:isFull2 forKey:@"isFull"];
    [team2 setObject:teamDetailImage2 forKey:@"teamDetailImage"];
    [team2 setObject:description2 forKey:@"description"];
    
    [teamArr1 addObject:team2];
    
    [gym1 setObject:gymName1 forKey:@"gymName"];
    [gym1 setObject:gymDistance1 forKey:@"gymDistance"];
    [gym1 setObject:teamArr1 forKey:@"teams"];
    
    [_gymWithTeamsArr addObject:gym1];
    
    /*-------------------------------------------------------------------*/
    /*第二个健身会馆*/
    NSMutableDictionary *gym2 = [[NSMutableDictionary alloc] init];
    NSString *gymName2 = @"健身会馆2";
    NSString *gymDistance2 = @"0.5KM";
    //该健身馆的所有战队
    NSMutableArray *teamArr2 = [[NSMutableArray alloc] initWithCapacity:0];
    //第一个战队
    NSMutableDictionary *team3 = [[NSMutableDictionary alloc] init];
    NSString *teamLogoUrl3 = @"headPic.png";//后期改为URL链接
    NSString *teamName3 = @"战队A";
    NSString *teamType3 = @"增肌";
    NSNumber *isFull3 = [NSNumber numberWithBool:YES];
    NSString *teamDetailImage3 = @"Toronto, ON.jpg";
    NSString *description3 = @"练习半年，维度大了一圈，非常辛苦，也非常难得。感谢鼓励我坚持下来的小伙伴们，希望有新伙伴能够加入我们，我们一起做健身达人！";
    
    [team3 setObject:teamLogoUrl3 forKey:@"teamLogo"];
    [team3 setObject:teamName3 forKey:@"teamName"];
    [team3 setObject:teamType3 forKey:@"teamType"];
    [team3 setObject:isFull3 forKey:@"isFull"];
    [team3 setObject:teamDetailImage3 forKey:@"teamDetailImage"];
    [team3 setObject:description3 forKey:@"description"];
    
    [teamArr2 addObject:team3];
    
    //第2个战队
    NSMutableDictionary *team4 = [[NSMutableDictionary alloc] init];
    NSString *teamLogoUrl4 = @"headPic.png";//后期改为URL链接
    NSString *teamName4 = @"战队B";
    NSString *teamType4 = @"增肌";
    NSNumber *isFull4 = [NSNumber numberWithBool:NO];
    NSString *teamDetailImage4 = @"Toronto, ON.jpg";
    NSString *description4 = @"练习半年，维度大了一圈，非常辛苦，也非常难得。感谢鼓励我坚持下来的小伙伴们，希望有新伙伴能够加入我们，我们一起做健身达人！";
    
    [team4 setObject:teamLogoUrl4 forKey:@"teamLogo"];
    [team4 setObject:teamName4 forKey:@"teamName"];
    [team4 setObject:teamType4 forKey:@"teamType"];
    [team4 setObject:isFull4 forKey:@"isFull"];
    [team4 setObject:teamDetailImage4 forKey:@"teamDetailImage"];
    [team4 setObject:description4 forKey:@"description"];
    
    [teamArr2 addObject:team4];
    
    //第3个战队
    NSMutableDictionary *team5 = [[NSMutableDictionary alloc] init];
    NSString *teamLogoUrl5 = @"headPic.png";//后期改为URL链接
    NSString *teamName5 = @"战队C";
    NSString *teamType5 = @"增肌";
    NSNumber *isFull5 = [NSNumber numberWithBool:NO];
    NSString *teamDetailImage5 = @"Toronto, ON.jpg";
    NSString *description5 = @"练习半年，维度大了一圈，非常辛苦，也非常难得。感谢鼓励我坚持下来的小伙伴们，希望有新伙伴能够加入我们，我们一起做健身达人！";
    
    [team5 setObject:teamLogoUrl5 forKey:@"teamLogo"];
    [team5 setObject:teamName5 forKey:@"teamName"];
    [team5 setObject:teamType5 forKey:@"teamType"];
    [team5 setObject:isFull5 forKey:@"isFull"];
    [team5 setObject:teamDetailImage5 forKey:@"teamDetailImage"];
    [team5 setObject:description5 forKey:@"description"];
    
    [teamArr2 addObject:team5];
    
    //第4个战队
    NSMutableDictionary *team6 = [[NSMutableDictionary alloc] init];
    NSString *teamLogoUrl6 = @"headPic.png";//后期改为URL链接
    NSString *teamName6 = @"战队D";
    NSString *teamType6 = @"减肥";
    NSNumber *isFull6 = [NSNumber numberWithBool:NO];
    NSString *teamDetailImage6 = @"Toronto, ON.jpg";
    NSString *description6 = @"练习半年，维度大了一圈，非常辛苦，也非常难得。感谢鼓励我坚持下来的小伙伴们，希望有新伙伴能够加入我们，我们一起做健身达人！";
    
    [team6 setObject:teamLogoUrl6 forKey:@"teamLogo"];
    [team6 setObject:teamName6 forKey:@"teamName"];
    [team6 setObject:teamType6 forKey:@"teamType"];
    [team6 setObject:isFull6 forKey:@"isFull"];
    [team6 setObject:teamDetailImage6 forKey:@"teamDetailImage"];
    [team6 setObject:description6 forKey:@"description"];
    
    [teamArr2 addObject:team6];
    
    [gym2 setObject:gymName2 forKey:@"gymName"];
    [gym2 setObject:gymDistance2 forKey:@"gymDistance"];
    [gym2 setObject:teamArr2 forKey:@"teams"];
    
    [_gymWithTeamsArr addObject:gym2];
    
    if ([_gymWithTeamsArr count] > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.myTableView setHidden:NO];
            [self.myTableView reloadData];
        });
    }
    
}

//动态
- (void)getDataSource_Movements
{
    _gymWithMovementsArr= [[NSMutableArray alloc] initWithCapacity:0];
    
    /*第一个健身会馆*/
    NSMutableDictionary *gym1 = [[NSMutableDictionary alloc] init];
    NSString *gymName1 = @"健身会馆1";
    NSString *gymDistance1 = @"1KM";
    //该健身馆的所有战队
    NSMutableArray *movementsOfGym1 = [[NSMutableArray alloc] initWithCapacity:0];
    //第一个动态
    NSMutableDictionary *movement1 = [[NSMutableDictionary alloc] init];
    NSString *userLogoUrl1 = @"headPic.png";//后期改为URL链接
    NSString *userName1 = @"腹肌撕裂者";
    NSString *publishDate1 = @"5分钟前";
    NSString *teamDetailImage1 = @"Toronto, ON.jpg";
    NSString *description1 = @"练习半年，维度大了一圈，非常辛苦，也非常难得。感谢鼓励我坚持下来的小伙伴们，希望有新伙伴能够加入我们，我们一起做健身达人！";
    
    [movement1 setObject:userLogoUrl1 forKey:@"userLogo"];
    [movement1 setObject:userName1 forKey:@"userName"];
    [movement1 setObject:teamDetailImage1 forKey:@"image"];
    [movement1 setObject:description1 forKey:@"description"];
    [movement1 setObject:publishDate1 forKey:@"publishDate"];
    
    [movementsOfGym1 addObject:movement1];
    
    //第二个动态
    NSMutableDictionary *movement2 = [[NSMutableDictionary alloc] init];
    NSString *userLogoUrl2 = @"headPic.png";//后期改为URL链接
    NSString *userName2 = @"腹肌撕裂者";
    NSString *publishDate2 = @"5分钟前";
    NSString *teamDetailImage2 = @"Toronto, ON.jpg";
    NSString *description2 = @"练习半年，维度大了一圈，非常辛苦，也非常难得。感谢鼓励我坚持下来的小伙伴们，希望有新伙伴能够加入我们，我们一起做健身达人！";
    
    [movement2 setObject:userLogoUrl2 forKey:@"userLogo"];
    [movement2 setObject:userName2 forKey:@"userName"];
    [movement2 setObject:teamDetailImage2 forKey:@"image"];
    [movement2 setObject:description2 forKey:@"description"];
    [movement2 setObject:publishDate2 forKey:@"publishDate"];
    
    [movementsOfGym1 addObject:movement2];
    [gym1 setObject:gymName1 forKey:@"gymName"];
    [gym1 setObject:gymDistance1 forKey:@"gymDistance"];
    [gym1 setObject:movementsOfGym1 forKey:@"movements"];
    
    [_gymWithMovementsArr addObject:gym1];
    
    /*-------------------------------------------------------------------*/
    /*第二个健身会馆*/
    NSMutableDictionary *gym2 = [[NSMutableDictionary alloc] init];
    NSString *gymName2 = @"健身会馆2";
    NSString *gymDistance2 = @"1KM";
    //该健身馆的所有战队
    NSMutableArray *movementsOfGym2 = [[NSMutableArray alloc] initWithCapacity:0];
    
    //第一个动态
    NSMutableDictionary *movement3 = [[NSMutableDictionary alloc] init];
    NSString *userLogoUrl3 = @"headPic.png";//后期改为URL链接
    NSString *userName3 = @"腹肌撕裂者";
    NSString *publishDate3 = @"5分钟前";
    NSString *teamDetailImage3 = @"Toronto, ON.jpg";
    NSString *description3 = @"练习半年，维度大了一圈，非常辛苦，也非常难得。感谢鼓励我坚持下来的小伙伴们，希望有新伙伴能够加入我们，我们一起做健身达人！";
    
    [movement3 setObject:userLogoUrl3 forKey:@"userLogo"];
    [movement3 setObject:userName3 forKey:@"userName"];
    [movement3 setObject:teamDetailImage3 forKey:@"image"];
    [movement3 setObject:description3 forKey:@"description"];
    [movement3 setObject:publishDate3 forKey:@"publishDate"];
    
    [movementsOfGym2 addObject:movement3];
    
    //第二个动态
    NSMutableDictionary *movement4 = [[NSMutableDictionary alloc] init];
    NSString *userLogoUrl4 = @"headPic.png";//后期改为URL链接
    NSString *userName4 = @"腹肌撕裂者";
    NSString *publishDate4 = @"5分钟前";
    NSString *teamDetailImage4 = @"Toronto, ON.jpg";
    NSString *description4 = @"练习半年，维度大了一圈，非常辛苦，也非常难得。感谢鼓励我坚持下来的小伙伴们，希望有新伙伴能够加入我们，我们一起做健身达人！";
    
    [movement4 setObject:userLogoUrl4 forKey:@"userLogo"];
    [movement4 setObject:userName4 forKey:@"userName"];
    [movement4 setObject:teamDetailImage4 forKey:@"image"];
    [movement4 setObject:description4 forKey:@"description"];
    [movement4 setObject:publishDate4 forKey:@"publishDate"];
    [movementsOfGym2 addObject:movement4];
    
    [gym2 setObject:gymName2 forKey:@"gymName"];
    [gym2 setObject:gymDistance2 forKey:@"gymDistance"];
    [gym2 setObject:movementsOfGym2 forKey:@"movements"];
    
    [_gymWithMovementsArr addObject:gym2];
    
    if (_gymWithMovementsArr.count > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [_movementTableView setHidden:NO];
            [_movementTableView reloadData];
        });
    }
    
}

#pragma mark - UITableView Delegate Datasource & Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sectionCount = 0;
    if (tableView == self.myTableView) {
        sectionCount = _gymWithTeamsArr.count;
    }else if(tableView == _movementTableView)
        sectionCount = _gymWithMovementsArr.count;
    return sectionCount;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableDictionary *datasource = (tableView == self.myTableView) ? [_gymWithTeamsArr objectAtIndex:section] :[_gymWithMovementsArr objectAtIndex:section];
    NSMutableArray *items = (tableView == self.myTableView) ? [datasource objectForKey:@"teams"] : [datasource objectForKey:@"movements"];
    NSInteger num = items.count;
    
    if (tableView == self.myTableView) {
        datasource = [_gymWithTeamsArr objectAtIndex:section];
        items = [datasource objectForKey:@"teams"];
    }else if(tableView == _movementTableView)
    {
        datasource = [_gymWithMovementsArr objectAtIndex:section];
        items = [datasource objectForKey:@"movements"];
    }
    num = items.count;
    return num;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat headerViewHeight = 0.f;
    if (tableView == self.myTableView) {
        headerViewHeight = 30.f + 55.f;
    }else
        headerViewHeight = 30.f;
    return headerViewHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *hView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 30.f + (showTeamsNearby?55.f:0.f))];
    [hView setBackgroundColor:[UIColor whiteColor]];
    UIColor *darkGray = [UIColor colorWithRed:29.0/255.0 green:30.0/255.0 blue:34.0/255.0 alpha:1];
    UIView *gymInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, hView.frame.size.width, 30)];
    [gymInfoView setBackgroundColor:darkGray];
    
    NSMutableDictionary *gymDic = [_gymWithTeamsArr objectAtIndex:section];
    NSString *gymName = [gymDic objectForKey:@"gymName"];
    NSString *gymDistance = [gymDic objectForKey:@"gymDistance"];
    
    UILabel *nameLB = [[UILabel alloc] initWithFrame:CGRectMake(10, 4.5, tableView.frame.size.width * 3.0/5.0 - 10, 21)];
    [nameLB setText:gymName];
    [nameLB setTextAlignment:NSTextAlignmentLeft];
    [nameLB setTextColor:[UIColor whiteColor]];
    [gymInfoView addSubview:nameLB];
    
    UILabel *distanceLB = [[UILabel alloc] initWithFrame:CGRectMake(10+nameLB.frame.size.width + 10, 4.5, tableView.frame.size.width * 2.0/5.0-10-10, 21)];
    [distanceLB setText:gymDistance];
    [distanceLB setTextAlignment:NSTextAlignmentRight];
    [distanceLB setTextColor:[UIColor whiteColor]];
    [gymInfoView addSubview:distanceLB];
    
    [hView addSubview:gymInfoView];
    
    if (showTeamsNearby) {
        UIButton *createTeamBT = [UIButton buttonWithType:UIButtonTypeCustom];
        [createTeamBT setFrame:CGRectMake(0, 30, hView.frame.size.width, 55)];
        [createTeamBT setTitle:@"+ 创建战队" forState:UIControlStateNormal];
        [createTeamBT setTitleColor:Color_ThemeOrange forState:UIControlStateNormal];
        [createTeamBT addTarget:self action:@selector(startToCreateATeam:) forControlEvents:UIControlEventTouchUpInside];
        
        [hView addSubview:createTeamBT];
    }
    
    
    //加一条分割线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, hView.frame.size.height-1, hView.frame.size.width, 1)];
    [line setBackgroundColor:[UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1]];
    [hView addSubview:line];
    
    return hView;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    NSMutableDictionary *gymDic = [_gymWithTeamsArr objectAtIndex:section];
    NSString *gymName = [gymDic objectForKey:@"gymName"];
    NSString *gymDistance = [gymDic objectForKey:@"gymDistance"];
    NSString *title  = [NSString stringWithFormat:@"%@ %@",gymName,gymDistance];
    return title;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHeight = 0.f;
    
    UITableViewCell *teamCell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    UITextView *descriptionTextView = (UITextView *)[teamCell.contentView viewWithTag:104];
    UIImageView *imageView = (UIImageView *)[teamCell.contentView viewWithTag:103];
    if (showTeamsNearby)
    {
        rowHeight = 55 + 5 + descriptionTextView.frame.size.height + 10;
    }
    else
    {
        rowHeight = 55 + imageView.frame.size.height + descriptionTextView.frame.size.height + 15 + 30 + 15 + 30;
    }
    
    return rowHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"TeamCell"];

    if (tableView == _movementTableView) {
        myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MovementCell"];
    }
    NSMutableArray *datasource = showTeamsNearby ? [[_gymWithTeamsArr objectAtIndex:indexPath.section] objectForKey:@"teams"] : [[_gymWithMovementsArr objectAtIndex:indexPath.section] objectForKey:@"movements"];
    
    if (indexPath.row < datasource.count) {
        NSMutableDictionary *dataDic = [datasource objectAtIndex:indexPath.row];
        
        //头像
        [[myCell.contentView viewWithTag:100] removeFromSuperview];
        UIButton *userLogoImageButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 6, 45, 45)];
        userLogoImageButton.layer.masksToBounds = YES;
        [userLogoImageButton.layer setCornerRadius:22.5];
        [userLogoImageButton setImage:[UIImage imageNamed:@"headPic.jpg"] forState:UIControlStateNormal];
        [myCell.contentView addSubview:userLogoImageButton];
        [userLogoImageButton setTag:100 + indexPath.section*10 + indexPath.row];
        [userLogoImageButton addTarget:self action:@selector(tapTheHeadLogo:) forControlEvents:UIControlEventTouchUpInside];
        [myCell.contentView addSubview:userLogoImageButton];
        
        //名称
        UILabel *nameLB  = [[UILabel alloc] initWithFrame:CGRectMake(55, 18, myCell.frame.size.width - 56 - 55, 21)];
        NSString *nameString = showTeamsNearby ? [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"teamName"]] : [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"userName"]];
        if (showTeamsNearby) {
            NSString *teamType = [dataDic objectForKey:@"teamType"];
            NSString *text = [NSString stringWithFormat:@"%@/%@",nameString,teamType];
            NSMutableAttributedString *textLabelStr = [[NSMutableAttributedString alloc] initWithString:text];
            [textLabelStr setAttributes:@{NSForegroundColorAttributeName :
                                              Color_ThemeOrange} range:NSMakeRange(nameString.length,teamType.length+1)];
            nameLB.attributedText = textLabelStr;
        }else
        {
            [nameLB setText:nameString];
        }
        [nameLB removeFromSuperview];
        [myCell.contentView addSubview:nameLB];
        
        
        if (showTeamsNearby) {
            //加入按钮
            UIButton *joinBT = [[UIButton alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 10 - 46, 13, 46, 30)];
            [myCell.contentView addSubview:joinBT];
            joinBT.tag = indexPath.section*10 + indexPath.row;
            BOOL isFull = [[dataDic objectForKey:@"isFull"] boolValue];
            if (isFull) {
                //满员
                [joinBT setTitle:@"满员" forState:UIControlStateNormal];
                [joinBT setBackgroundColor:[UIColor grayColor]];
            }else
            {
                //未满员
                [joinBT setTitle:@"加入" forState:UIControlStateNormal];
                [joinBT setBackgroundColor:Color_ThemeOrange];
                [joinBT addTarget:self action:@selector(joinTheTeam:) forControlEvents:UIControlEventTouchUpInside];
            }
            
        }else
        {
            
            //动态发布时间
            UILabel *publishDateLB = [[UILabel alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 10 - 92, 14, 92, 30)];
            [publishDateLB setTextAlignment:NSTextAlignmentRight];
            
            [publishDateLB setText:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"publishDate"]]];
            [publishDateLB setTextColor:[UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:162.0/255.0 alpha:1]];
            [myCell.contentView addSubview:publishDateLB];
        }
        
        
        BOOL hasImage = NO;
        
        if (!showTeamsNearby) {
            NSString *imgUrl = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"image"]];
            if ([imgUrl length] != 0) {
                
                hasImage = YES;
                UIImage *img = [UIImage imageNamed:imgUrl];
                
                UIImageView *movementImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 55, tableView.frame.size.width - 20, tableView.frame.size.width - 20)];
                [movementImgView setTag:103];
                [movementImgView setImage:img];
                
                [myCell.contentView addSubview:movementImgView];
            }
            
        }
        
        //描述
        UITextView *descriptionTextView = [[UITextView alloc] init];
        descriptionTextView.editable = NO;
        descriptionTextView.tag = 104;
        
        NSString *teamDescription = [dataDic objectForKey:@"description"];
        UIFont *font_description = [UIFont systemFontOfSize:17.f];
        
        
        [descriptionTextView setText:teamDescription];
        [descriptionTextView setFont: font_description];
        
        CGSize constrainedSize = CGSizeMake(tableView.frame.size.width - 20, 1000);
        CGSize actualSize = [teamDescription sizeWithFont:descriptionTextView.font constrainedToSize:constrainedSize lineBreakMode:NSLineBreakByWordWrapping];
        
        [descriptionTextView setFrame:CGRectMake(10, 55 + (hasImage?tableView.frame.size.width:0) + (hasImage ? 5:0), actualSize.width, actualSize.height + 20)];
        
        [descriptionTextView setBackgroundColor:[UIColor whiteColor]];
        [descriptionTextView setTextColor:FontColor_ContentTextView];
        //        [descriptionTextView setBackgroundColor:[UIColor redColor]];
        [descriptionTextView setScrollEnabled:NO];
        [descriptionTextView setEditable:NO];
        [myCell.contentView addSubview:descriptionTextView];
        
        
        if (!showTeamsNearby) {
            //点赞区域
            UIView *upView = [[UIView alloc] initWithFrame:CGRectMake(tableView.frame.size.width - 70 - 10, descriptionTextView.frame.origin.y + descriptionTextView.frame.size.height + 15, 70, 30)];
            [upView setBackgroundColor:RGBCOLOR(239.0, 239.0, 239.0)];
            [upView.layer setMasksToBounds:YES];
            upView.layer.cornerRadius = 8.0;
            
            //点赞按钮
            UIButton *upButton = [[UIButton alloc] initWithFrame:CGRectMake(2.5, 2.5, 25, 25)];
            [upButton setImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateNormal];
            [upView addSubview:upButton];
            
            //点赞个数
            NSString *upNum = @"22";
            UILabel *upNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(upButton.frame.origin.x + 25 + 2.5, 4.5, 37.5, 21)];
            [upNumLabel setTextColor:RGBCOLOR(139.0, 139.0, 139.0)];
            [upNumLabel setText:[NSString stringWithFormat:@"%@赞",upNum]];
            
            [upView addSubview:upNumLabel];
            
            [myCell.contentView addSubview:upView];
            
        }
        
    }
    
    return myCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (showTeamsNearby) {
        //跳转到战队详情页面
        UIButton *sender = [[UIButton alloc] init];
        sender.tag = indexPath.section * 10 + indexPath.row;
        [self joinTheTeam:sender];
    }else
    {
        //跳转到动态详情页面
        [self.navigationController performSegueWithIdentifier:@"ShowMovementDetailVC" sender:nil];
        [self.tabBarController.tabBar setHidden:YES];
    }
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark － Data Source Loading / Reloading Methods

#pragma mark - 点击头像
- (void)tapTheHeadLogo:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    NSInteger section = tag/10;
    NSInteger row = tag - section*10;
    
    //点击头像，进入对应用户的主页
    [self.navigationController performSegueWithIdentifier:@"ShowUserDetailVC" sender:nil];
    [self.tabBarController.tabBar setHidden:YES];
}

#pragma mark - 战队相关操作
//打开创建战队的提示框
- (void)startToCreateATeam:(UIButton *)sender
{
    
    [UIView animateWithDuration:0.3 animations:^{
        [_translucentBlackView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
        [_alertViewOfCreateATeam setAlpha:1.f];
    } completion:^(BOOL finished) {
        [[[UIApplication sharedApplication] keyWindow] addSubview:_translucentBlackView];
        [_alertViewOfCreateATeam setCenter:CGPointMake(_translucentBlackView.center.x, _translucentBlackView.center.y)];
        [_translucentBlackView addSubview:_alertViewOfCreateATeam];
    }];
    
}

//关闭创建战队的提示框
- (void)closeAlertViewOfCreateATeam:(id *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        [_translucentBlackView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
        [_alertViewOfCreateATeam setAlpha:0.f];
    } completion:^(BOOL finished) {
        [_alertViewOfCreateATeam removeFromSuperview];
        [_translucentBlackView removeFromSuperview];
    }];
}

//确认创建战队
- (void)confirmToCreateATeam
{
    [self performSelectorOnMainThread:@selector(closeAlertViewOfCreateATeam:) withObject:nil waitUntilDone:YES];
    [self.navigationController performSegueWithIdentifier:@"BuildATeam" sender:self];
    
    [self.tabBarController.tabBar setHidden:YES];
    
}

//加入战队
- (void)joinTheTeam:(id)sender
{
    //获取要加入的那个战队的信息
    
    //title
    
    //跳转页面
    [self.navigationController performSegueWithIdentifier:@"ShowTeamDetailVC" sender:nil];
    [self.tabBarController.tabBar setHidden:YES];
}

#pragma mark - 打开相机
- (void)openTheCamera
{

    SCNavigationController *nav = [[SCNavigationController alloc] init];
    nav.scNaigationDelegate = self;
    [nav showCameraWithParentController:self];
    [self takePhoto];
    
}

#pragma mark - 打开相机
-(void)takePhoto
{
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        _myImgPickerVC = [[UIImagePickerController alloc] init];
        _myImgPickerVC.delegate = self;
        //设置拍照后的图片可被编辑
        _myImgPickerVC.allowsEditing = YES;
        _myImgPickerVC.sourceType = sourceType;
        [self presentViewController:_myImgPickerVC animated:YES completion:nil];
    }else
    {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

#pragma mark - 打开图库
-(void)openLocalPhoto
{
    
}

- (IBAction)myNavRightButtonItemAction:(UIBarButtonItem *)sender {
    
}


#pragma mark - 两个切换
- (IBAction)changeSegmentedControlValue:(UISegmentedControl *)sender {
    
    _myNavRightButtonItem = nil;
    if (sender.selectedSegmentIndex == 0) {
        //切换“附近战队页面”
        showTeamsNearby = YES;
        
        if ([_gymWithTeamsArr count] != 0) {
            [self.myTableView reloadData];
        }
        
        if (_myNavRightButtonItem == nil) {
            _myNavRightButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchTeamsAround)];
            [self.navigationItem setRightBarButtonItem:_myNavRightButtonItem];
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.myTableView setAlpha:1.f];
            [_movementTableView setAlpha:0.f];
        } completion:nil];
    }else
    {
        //切换“动态页面”
        showTeamsNearby = NO;
        if (_myNavRightButtonItem == nil) {
            _myNavRightButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(openTheCamera)];
            [self.navigationItem setRightBarButtonItem:_myNavRightButtonItem];
        }
        
        if (_gymWithMovementsArr == nil || [_gymWithMovementsArr count] == 0) {
            [self getDataSource_Movements];
            if ([_gymWithMovementsArr count] != 0) {
                [_movementTableView reloadData];
            }
        }
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             [self.myTableView setAlpha:0.f];
                             [_movementTableView setAlpha:1.f];
                             
                         } completion:nil];
        
    }
    
    
}

#pragma mark - 搜索附近战队
- (void)searchTeamsAround
{
    if (_mySearchTeamsVC == nil) {
        _mySearchTeamsVC = [[HSearchTeamsVC alloc] initWithNibName:@"HSearchTeamsVC" bundle:nil];
    }
    [self presentViewController:_mySearchTeamsVC animated:YES completion:nil];
}

#pragma mark -

- (void)reloadTableViewDataSource{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    _reloading = YES;
    
}

- (void)doneLoadingTableViewData{
    
    //  model should call this when its done loading
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.myTableView];
    
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [_refreshHeaderView egoRefreshScrollViewWillBeginScroll:scrollView];
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
//    
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//    
//    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
//    
//}

//#pragma mark - EGORefresh Delegate Methods
//-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
//{
//    return _reloading; // should return if data source model is reloading
//}
//
//-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
//{
//    
//}
//
//
//-(NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
//{
//    return [NSDate date]; // should return date data source was last changed
//}
//

#pragma mark - Tabba
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if([item.title isEqualToString:@"消息"] || [item.title isEqualToString:@"我"])
    {
        NSLog(@"个人");
    }
}

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    //为登录，进入登录注册界面
    UINavigationController *navigationControllerOfFirstVC = self.navigationController;
    if (tabBarController.selectedIndex == 0 && _appDelegate.userInfoDic == nil && viewController != navigationControllerOfFirstVC) {
        [self buildLoginViewWithAnimation:YES];
        return NO;
    }
    return YES;
}

@end
