//
//  LoginView.m
//  FitnessPattern
//
//  Created by 胡晓阳 on 15/1/8.
//  Copyright (c) 2015年 健身范. All rights reserved.
//

#import "LoginView.h"
#import <QuartzCore/QuartzCore.h>

@implementation LoginView

- (id)initWithFrame:(CGRect)frame
{
    
    if (self) {
        // Initialization code
        self = [[NSBundle mainBundle] loadNibNamed:@"LoginView" owner:nil options:nil][0];
        self.frame = frame;
        
        UIButton *registBT = (UIButton *)[self viewWithTag:11];
        UIButton *loginBT = (UIButton *)[self viewWithTag:12];
        [registBT.layer setMasksToBounds:YES];
        [registBT.layer setCornerRadius:4.0];
        [loginBT.layer setMasksToBounds:YES];
        [loginBT.layer setCornerRadius:4.0];
        
    }
    return self;

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
