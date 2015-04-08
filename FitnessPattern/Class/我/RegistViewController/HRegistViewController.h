//
//  HRegistViewController.h
//  FitnessPattern
//
//  Created by SharonHu on 15/3/18.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HRegistViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *phonenumberTextField;
@property (strong, nonatomic) IBOutlet UIButton *registBT;
- (IBAction)registAction:(id)sender;
@end
