//
//  HApplicationViewController.h
//  FitnessPattern
//
//  Created by SharonHu on 15/3/21.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HApplicationViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIImageView *applyerHeadImageView;
@property (strong, nonatomic) IBOutlet UIButton *doNotAgreeBT;
@property (strong, nonatomic) IBOutlet UIButton *agreeBT;
- (IBAction)doNotAgreeAction:(id)sender;
- (IBAction)agreeAction:(id)sender;
@end
