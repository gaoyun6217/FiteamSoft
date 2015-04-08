//
//  Common.h
//  HomeschoolHome
//
//  Created by song on 14-9-22.
//  Copyright (c) 2014年 song. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MBProgressHUD;

@interface Common : NSObject

+ (MBProgressHUD *)showHUDWithTitle:(NSString *)title andImage:(NSString *)image andTime:(int)time;

+ (BOOL)GetNetWorkStateShowHUDWithTitle;

+ (MBProgressHUD *)showHUDWithTitle:(NSString *)title;
+ (void)dismissGlobalHUD;
+ (UILabel *)doMyNavigation:(NSString *)title;

@end
