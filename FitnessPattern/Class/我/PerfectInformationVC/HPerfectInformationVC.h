//
//  HPerfectInformationVC.h
//  FitnessPattern
//
//  Created by 胡晓阳 on 15/3/20.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPerfectInformationVC : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *headImageView;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *phonenumberTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *locationButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;

- (IBAction)addHeadPicAction:(id)sender;
- (IBAction)locationAction:(id)sender;
- (IBAction)nextAction:(id)sender;
@end
