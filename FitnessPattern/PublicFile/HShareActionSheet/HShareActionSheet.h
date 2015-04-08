//
//  HShareActionSheet.h
//  Roboo_App_Store
//
//  Created by 胡晓阳 on 14-9-23.
//  Copyright (c) 2014年 TTgg. All rights reserved.
//

@protocol HShareDelegate <NSObject>
-(void)touchQQorQZ:(BOOL)qz;
@end
#import <UIKit/UIKit.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import "WXApi.h"

#import "WeiboSDK.h"

#import <RennSDK/RennSDK.h>

#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>


#import "WeiboApi.h"
#import "WeiboApiObject.h"
@interface HShareActionSheet : UIAlertController<MFMessageComposeViewControllerDelegate,WeiboSDKDelegate,RennLoginDelegate,WeiboAuthDelegate,WeiboRequestDelegate>
{
    NSArray *sorceArray;
    NSMutableArray *titleArray;
    TencentOAuth *qqLogin;
    BOOL qqOrZone;
    
    NSString *shareurl;
}
@property (strong, nonatomic) UIViewController *reader;
@property (copy, nonatomic) NSString *appName;
@property (copy, nonatomic) NSString *appImage;
@property (assign, nonatomic) id<HShareDelegate>sdelegate;
@end