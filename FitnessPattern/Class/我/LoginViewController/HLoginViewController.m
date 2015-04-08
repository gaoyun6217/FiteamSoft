//
//  HLoginViewController.m
//  FitnessPattern
//
//  Created by SharonHu on 15/3/18.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import "HLoginViewController.h"

@interface HLoginViewController ()
{
    BOOL _loginSuccess;
}
@end

@implementation HLoginViewController

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
    
    
    _loginSuccess = NO;
    [self initiateTheSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doBack:(UIBarButtonItem *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    if (!_loginSuccess) {
        //发送取消登录的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CancelLoginRegist" object:nil];
    }

}

-(void)initiateTheSubviews
{
    [self.loginBT.layer setCornerRadius:4.f];
    [self.phoneNumberTextField.layer setCornerRadius:4.f];
    [self.phoneNumberTextField.layer setBorderWidth:1.f];
    [self.phoneNumberTextField.layer setBorderColor:RGBCOLOR(217.0, 217.0, 217.0).CGColor];
    [self.passwordTextField.layer setCornerRadius:4.f];
    [self.passwordTextField.layer setBorderWidth:1.f];
    [self.passwordTextField.layer setBorderColor:RGBCOLOR(217.0, 217.0, 217.0).CGColor];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)loginAction:(id)sender {
    
    NSString *phoneNum = self.phoneNumberTextField.text;
    NSString *password = self.passwordTextField.text;
    if ([phoneNum  isEqual: @"1"] && [password isEqual:@"1"]) {
        [self.navigationController popViewControllerAnimated:YES];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SuccessToLogin" object:nil];
        NSLog(@"登录成功");
        
        //记录登陆用户的信息
        NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithObjectsAndKeys:phoneNum,@"phoneNum",password, @"password", nil];
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        delegate.userInfoDic = [NSMutableDictionary dictionaryWithDictionary:userInfo];
    }else
    {
        NSLog(@"登录失败");
    }
    
}
@end
