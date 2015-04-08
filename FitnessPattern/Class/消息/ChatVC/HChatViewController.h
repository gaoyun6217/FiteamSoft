//
//  HChatViewController.h
//  FitnessPattern
//
//  Created by SharonHu on 15/3/21.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HChatViewController : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *inputFieldView;
@property (strong, nonatomic) IBOutlet UITextField *inputTextField;

- (IBAction)operationAction:(id)sender;
@end
