//
//  AppDelegate.h
//  FitnessPattern
//
//  Created by 胡晓阳 on 14/12/25.
//  Copyright (c) 2014年 健身范. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYBlurIntroductionView.h"
#import "MYCustomPanel.h"
#import "MYIntroductionPanel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,MYIntroductionDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, copy) NSString *registPhonenumber;
@property (nonatomic, copy) NSMutableDictionary *userInfoDic;
@end

