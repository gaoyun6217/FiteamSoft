//
//  HBuildATeamVC.h
//  FitnessPattern
//
//  Created by 胡晓阳 on 15/3/6.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBuildATeamVC : UIViewController<UITextFieldDelegate,UITextViewDelegate>;

@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UITextField *teamNameTextField;
@property (strong, nonatomic) IBOutlet UITextView *teamIntroductionTextView;
@property (strong, nonatomic) IBOutlet UIView *secondView;
- (IBAction)nextAction:(id)sender;
- (IBAction)finishAction:(id)sender;
@end
