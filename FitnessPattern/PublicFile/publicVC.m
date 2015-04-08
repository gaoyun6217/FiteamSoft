//
//  publicVC.m
//  Ihuoban
//
//  Created by GAOQINGGE on 14/11/23.
//  Copyright (c) 2014年 gqg.com.luntan. All rights reserved.
//

#import "publicVC.h"


@interface publicVC ()
@end

@implementation publicVC
@synthesize AFmanager, urlPathStr, token, hud;

- (void)viewDidLoad {
    [super viewDidLoad];
    AFmanager = [AFHTTPRequestOperationManager manager];
    [AFmanager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/html", nil]];
    AFmanager.requestSerializer.HTTPShouldHandleCookies = YES;
    //AFmanager.requestSerializer = [AFJSONRequestSerializer serializer];
    [AFmanager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    token = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"TOKEN"]];
    
    //self.hostURL = @"http://115.28.244.249/ypr/wapi/json?";
    self.hostURL = @"http://www.wanmv.com/ypr/wapi/json?";
    [self initControl];
    
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = self;
    
}

- (void)initControl
{
    hud = [[MBProgressHUD alloc] initWithView:self.view];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.yOffset = -60;
    
}

- (void)startModal
{
    [self.view addSubview:hud];
    [hud show:YES];
}

- (void)stopModal
{
    [hud hide:YES];
    [hud removeFromSuperview];
}

-(void) initTabbar:(NSString *)imageName selectImage:(NSString *)SLimageName
{
    self.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage = [[UIImage imageNamed:SLimageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.tabBarItem setImageInsets:UIEdgeInsetsMake(6.0, 0.0, -6.0, 0.0)];
    self.tabBarController.tabBar.translucent = NO;
    
}

- (void) setNavigationBar
{
    //UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_WIDTH, 20)];
    //statusBarView.backgroundColor=[UIColor whiteColor];
    //[self.navigationController.navigationBar addSubview:statusBarView];
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(51, 51, 51);
    self.navigationController.navigationBar.translucent = NO;
}

- (void)setUserDefaultValue:(NSString *)value forkey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache]clearDisk];
    [[SDImageCache sharedImageCache]clearMemory];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

#pragma mark 代理方法-进入刷新状态就会调用
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
}

- (void)dealloc
{
    [_footer free];
}

@end
