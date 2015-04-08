//
//  HRegistViewController.m
//  FitnessPattern
//
//  Created by SharonHu on 15/3/18.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import "HRegistViewController.h"

@interface HRegistViewController ()
{
    PopupView *myPopView;
    
}
@end

@implementation HRegistViewController

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)doBack:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    //发送取消登录的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CancelLoginRegist" object:nil];
}

-(void)initiateTheSubviews
{
    [self.registBT.layer setCornerRadius:4.f];
    [self.phonenumberTextField.layer setCornerRadius:4.f];
    [self.phonenumberTextField.layer setBorderWidth:1.f];
    [self.phonenumberTextField.layer setBorderColor:RGBCOLOR(217.0, 217.0, 217.0).CGColor];
    
    //toast提示
    myPopView = [[PopupView alloc] initWithFrame:CGRectMake(100, 300, 0, 0)];
    myPopView.ParentView = self.view;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)registAction:(id)sender {
    
    
    if (![self checkTel:self.phonenumberTextField.text])
    {
        [myPopView setText:@"请输入正确的手机号"];
        [self.view addSubview:myPopView];
    }
    else
    {
        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        delegate.registPhonenumber = self.phonenumberTextField.text;
        [self.navigationController performSegueWithIdentifier:@"ShowVerificationCodeView" sender:nil];
        
        //向手机发送验证码
    }
    
}

//判断是否是手机号码
- (BOOL)checkTel:(NSString *)str
{
    if ([str length] == 0) {
        return NO;
    }
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch)
    {
        return NO;
    }
    
    return YES;
}
@end
