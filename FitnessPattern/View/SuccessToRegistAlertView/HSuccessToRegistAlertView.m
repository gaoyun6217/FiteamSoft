//
//  HSuccessToRegistAlertView.m
//  FitnessPattern
//
//  Created by 胡晓阳 on 15/3/19.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import "HSuccessToRegistAlertView.h"

@implementation HSuccessToRegistAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (id)initWithFrame:(CGRect)frame andPhonenumber:(NSString *)phonenumber
{
    
    if (self) {
        // Initialization code
        self = [[NSBundle mainBundle] loadNibNamed:@"HSuccessToRegistAlertView" owner:nil options:nil][0];
        self.frame = frame;
        [self.layer setCornerRadius:4.f];

        [self.cancelButton.layer setMasksToBounds:YES];
        [self.cancelButton.layer setCornerRadius:4.0];
        [self.goToPerfectButton.layer setMasksToBounds:YES];
        [self.goToPerfectButton.layer setCornerRadius:4.0];
        
        [self.welcomeTitleLabel setText:[NSString stringWithFormat:@"欢迎加入！%@",phonenumber]];
        
        [self.cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.goToPerfectButton addTarget:self action:@selector(goToPerfectAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
    
}

- (void)cancelAction:(id)sender {
    [self.myDelegate cancelRegistSuccessView];
}
- (void)goToPerfectAction:(id)sender {
    [self.myDelegate goToPerfectInformation];
}
@end
