//
//  HLoginViewController.h
//  FitnessPattern
//
//  Created by SharonHu on 15/3/18.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *phoneNumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginBT;
- (IBAction)loginAction:(id)sender;
@end
