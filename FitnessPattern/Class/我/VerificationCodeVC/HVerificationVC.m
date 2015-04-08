//
//  HVerificationVC.m
//  FitnessPattern
//
//  Created by 胡晓阳 on 15/3/19.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import "HVerificationVC.h"

@interface HVerificationVC ()

@end

@implementation HVerificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AppDelegate *dele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.phonenumberLabel setText:dele.registPhonenumber];
    _phonenumber = dele.registPhonenumber;
    //验证码
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)initiateSubviews
{
    [self.phonenumberLabel setText:_phonenumber];
    [self.verificationCadeTextField.layer setBorderColor:RGBCOLOR(217.0, 217.0, 217.0).CGColor];
    [self.verificationCadeTextField.layer setBorderWidth:1.f];
    [self.submitButton.layer setCornerRadius:4.f];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitAction:(id)sender {
    NSLog(@"注册成功");
    //返回主页
    [self.navigationController popToRootViewControllerAnimated:YES];
    //发送弹出对话框的消息
    NSDictionary *userinfo = [NSDictionary dictionaryWithObjectsAndKeys:_phonenumber, @"phonenumber",nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SuccessToRegist" object:self userInfo:userinfo];
}

- (IBAction)cannotReceiveVerificationCodeAction:(id)sender {
}
@end
