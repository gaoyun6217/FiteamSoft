//
//  HPerfectInformationVC.m
//  FitnessPattern
//
//  Created by 胡晓阳 on 15/3/20.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import "HPerfectInformationVC.h"
#import "HSearchGymsVC.h"

@interface HPerfectInformationVC ()
{
    HSearchGymsVC *_mySearchGymsVC;
}
@end

@implementation HPerfectInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
}

- (void)initiateTheSubviews
{
    [self.nextButton.layer setCornerRadius:4.f];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addHeadPicAction:(id)sender {
}

- (IBAction)locationAction:(id)sender {
    [self searchTeamsAround];
}

- (IBAction)nextAction:(id)sender {
}

#pragma mark - 搜索附近战队
- (void)searchTeamsAround
{
    if (_mySearchGymsVC == nil) {
        _mySearchGymsVC = [[HSearchGymsVC alloc] initWithNibName:@"HSearchTeamsVC" bundle:nil];
    }
    [self presentViewController:_mySearchGymsVC animated:YES completion:nil];
}
@end
