//
//  HApplicationViewController.m
//  FitnessPattern
//
//  Created by SharonHu on 15/3/21.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import "HApplicationViewController.h"

@interface HApplicationViewController ()

@end

@implementation HApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //改变title颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    [self initiateTheSubviews];
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

- (void)initiateTheSubviews
{
    [self.applyerHeadImageView.layer setMasksToBounds:YES];
    [self.applyerHeadImageView.layer setCornerRadius:40.f];
    
    [self.doNotAgreeBT.layer setCornerRadius:4.f];
    [self.agreeBT.layer setCornerRadius:4.f];
    
}

- (IBAction)doNotAgreeAction:(id)sender {
}

- (IBAction)agreeAction:(id)sender {
}
@end
