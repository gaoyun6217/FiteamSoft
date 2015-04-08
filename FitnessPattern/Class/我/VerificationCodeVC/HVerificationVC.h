//
//  HVerificationVC.h
//  FitnessPattern
//
//  Created by 胡晓阳 on 15/3/19.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HVerificationVC : UIViewController
{
    NSString *_phonenumber;
}

@property (strong, nonatomic) IBOutlet UILabel *phonenumberLabel;
@property (strong, nonatomic) IBOutlet UITextField *verificationCadeTextField;
@property (strong, nonatomic) IBOutlet UIButton *submitButton;
- (IBAction)submitAction:(id)sender;
- (IBAction)cannotReceiveVerificationCodeAction:(id)sender;
@end
