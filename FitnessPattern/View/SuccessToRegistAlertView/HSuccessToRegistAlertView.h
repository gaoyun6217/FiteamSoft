//
//  HSuccessToRegistAlertView.h
//  FitnessPattern
//
//  Created by 胡晓阳 on 15/3/19.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

@protocol SuccessToRegistDelegate <NSObject>

- (void)goToPerfectInformation;
- (void)cancelRegistSuccessView;

@end
#import <UIKit/UIKit.h>

@interface HSuccessToRegistAlertView : UIView

@property (nonatomic, assign) id<SuccessToRegistDelegate> myDelegate;
@property (nonatomic, copy) NSString *phonenumber;
@property (strong, nonatomic) IBOutlet UILabel *welcomeTitleLabel;
@property (strong, nonatomic) IBOutlet UIButton *cancelButton;
@property (strong, nonatomic) IBOutlet UIButton *goToPerfectButton;

- (id)initWithFrame:(CGRect)frame andPhonenumber:(NSString *)phonenumber;
@end
