//
//  Common.m
//  HomeschoolHome
//
//  Created by song on 14-9-22.
//  Copyright (c) 2014年 song. All rights reserved.
//

#import "Common.h"
#import "MBProgressHUD.h"

@implementation Common


+ (MBProgressHUD *)showHUDWithTitle:(NSString *)title andImage:(NSString *)image andTime:(int)time
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        [MBProgressHUD hideHUDForView:window animated:YES];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    if (image !=nil)
    {
        hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    }
    hud.labelText = title;
    hud.opacity = 0.7;
    hud.labelFont = [UIFont systemFontOfSize:16];
    hud.mode = MBProgressHUDModeCustomView;
    [hud hide:YES afterDelay:time];
    return hud;
}

+ (BOOL)GetNetWorkStateShowHUDWithTitle
{
    BOOL networkBool;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];//[[[UIApplication sharedApplication] windows] lastObject];
    //[MBProgressHUD hideHUDForView:window animated:YES];
    for (UIWindow *window in [[UIApplication sharedApplication] windows]) {
        [MBProgressHUD hideHUDForView:window animated:YES];
    }
    NSString *stateStr = [self GetNetWorkState];
    if ([stateStr isEqualToString:@"offline"]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        hud.labelText = @"网络不给力,请检查网络后再试试吧";
        hud.labelFont = [UIFont systemFontOfSize:15];
        //    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"error.png"]];
        hud.mode = MBProgressHUDModeCustomView;
        [hud hide:YES afterDelay:1];
        networkBool = NO;
    }
    else
    {
        networkBool = YES;
    }
    return networkBool;
}

+ (NSString *)GetNetWorkState
{
    NSString *networkState = @"unknown";
    NSNumber *dataNewtworkItemView = nil;
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    for (id subview in subviews)
    {
        if ([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]])
        {
            dataNewtworkItemView = subview;
            break;
        }
    }
    NSNumber *num = [dataNewtworkItemView valueForKey:@"dataNetworkType"];
    if (num == nil)
    {
        networkState = @"offline";
    }
    else
    {
        int n = [num intValue];
        if (n == 0)
        {
            networkState = @"offline";
        }
        else if (n == 1)
        {
            networkState = @"2g";
        }
        else if (n == 2)
        {
            networkState = @"3g";
        }
        else
        {
            networkState = @"wifi";
        }
    }
    
    return networkState;
}

+ (MBProgressHUD *)showHUDWithTitle:(NSString *)title
{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        [MBProgressHUD hideHUDForView:window animated:YES];
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.labelText = title;
    hud.labelFont = [UIFont systemFontOfSize:15];
    return hud;
}

+ (void)dismissGlobalHUD
{
    
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        [MBProgressHUD hideHUDForView:window animated:YES];
    }
}

+ (UILabel *)doMyNavigation:(NSString *)title
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];  //设置Label背景透明
    titleLabel.font = [UIFont boldSystemFontOfSize:18];  //设置文本字体与大小
//    titleLabel.textColor = [UIColor colorWithRed:(51.0/255.0) green:(51.0 / 255.0) blue:(51.0 / 255.0) alpha:1];  //设置文本颜色
    titleLabel.textColor = [UIColor whiteColor];  //设置文本颜色
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;  //设置标题
    return titleLabel;
}

+ (UIImage *)doGetBackgroundImg:(NSString *)imgStr
{
//    UIImage *image = [UIImage imageNamed:@"but_140x34"];
    UIImage *image = [UIImage imageNamed:imgStr];
    image = [image stretchableImageWithLeftCapWidth:floorf(image.size.width/2) topCapHeight:floorf(image.size.height/2)];
    image = [image stretchableImageWithLeftCapWidth:floorf(image.size.width/2) topCapHeight:floorf(image.size.height/2)];

    return image;
}

+ (void)clearAllData
{
    [NSUSERDEFAULTSINIT removeObjectForKey:@"aCreateTime"];
    [NSUSERDEFAULTSINIT removeObjectForKey:@"aId"];
    [NSUSERDEFAULTSINIT removeObjectForKey:@"aNickname"];
    [NSUSERDEFAULTSINIT removeObjectForKey:@"aToken"];
    [NSUSERDEFAULTSINIT removeObjectForKey:@"aUsername"];
    
    [NSUSERDEFAULTSINIT removeObjectForKey:@"ahImgLarge"];
    [NSUSERDEFAULTSINIT removeObjectForKey:@"ahImgNormal"];
    [NSUSERDEFAULTSINIT removeObjectForKey:@"ahImgSmall"];
    
    [NSUSERDEFAULTSINIT removeObjectForKey:@"apMobile"];
    
    [NSUSERDEFAULTSINIT synchronize];//执行存储
}

+ (void)saveUserData:(NSMutableDictionary *)requestDic
{
    [NSUSERDEFAULTSINIT setObject:[[requestDic objectForKey:@"returnResult"] objectForKey:@"aCreateTime"] forKey:@"aCreateTime"];
    [NSUSERDEFAULTSINIT setObject:[[requestDic objectForKey:@"returnResult"] objectForKey:@"aId"] forKey:@"aId"];
    [NSUSERDEFAULTSINIT setObject:[[requestDic objectForKey:@"returnResult"] objectForKey:@"aNickname"] forKey:@"aNickname"];
    [NSUSERDEFAULTSINIT setObject:[[requestDic objectForKey:@"returnResult"] objectForKey:@"aToken"] forKey:@"aToken"];
    [NSUSERDEFAULTSINIT setObject:[[requestDic objectForKey:@"returnResult"] objectForKey:@"aUsername"] forKey:@"aUsername"];
//    NSLog(@"%@",[[requestDic objectForKey:@"returnResult"] objectForKey:@"ahImgLarge"] );
    if ([[requestDic objectForKey:@"returnResult"] objectForKey:@"ahImgLarge"] != [NSNull null]) {
        [NSUSERDEFAULTSINIT setObject:[[requestDic objectForKey:@"returnResult"] objectForKey:@"ahImgLarge"] forKey:@"ahImgLarge"];
    }
    if ([[requestDic objectForKey:@"returnResult"] objectForKey:@"ahImgNormal"] != [NSNull null]) {
        [NSUSERDEFAULTSINIT setObject:[[requestDic objectForKey:@"returnResult"] objectForKey:@"ahImgNormal"] forKey:@"ahImgNormal"];
    }
    if ([[requestDic objectForKey:@"returnResult"] objectForKey:@"ahImgSmall"] != [NSNull null]) {
        [NSUSERDEFAULTSINIT setObject:[[requestDic objectForKey:@"returnResult"] objectForKey:@"ahImgSmall"] forKey:@"ahImgSmall"];
    }
    if ([[requestDic objectForKey:@"returnResult"] objectForKey:@"apMobile"] != [NSNull null]) {
        [NSUSERDEFAULTSINIT setObject:[[requestDic objectForKey:@"returnResult"] objectForKey:@"apMobile"] forKey:@"apMobile"];
    }
    
    [NSUSERDEFAULTSINIT synchronize];//执行存储
}

+ (NSString *)changePhoneStr:(NSString *)hideStr
{
    NSString *hidePhoneStr = @"";
    
    for (int i=0; i<hideStr.length; i++) {
        if (i==3||i==4||i==5||i==6) {
            hidePhoneStr = [NSString stringWithFormat:@"%@*",hidePhoneStr];
        }
        else
        {
            hidePhoneStr = [NSString stringWithFormat:@"%@%c",hidePhoneStr,[hideStr characterAtIndex:i]];
        }
    }
    
    return hidePhoneStr;
}

+ (NSString *)doGetMessageDate:(NSString *)timestr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
//    NSLog(@"dateString     %@",dateString);

    NSString *createTimeStr = @"";

    NSArray *array = [timestr componentsSeparatedByString:@" "];
    if (array.count!=0 && array.count==2) {
        if ([dateString isEqualToString:[array objectAtIndex:0]]) {
            createTimeStr = [array objectAtIndex:1];
        }
        else
        {
            createTimeStr = [array objectAtIndex:0];
        }
        
    }

//    NSLog(@"dateString     %@",dateString);
    return createTimeStr;
}

@end
