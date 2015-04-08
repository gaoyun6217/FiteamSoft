//
//  publicVC.h
//  Ihuoban
//
//  Created by GAOQINGGE on 14/11/23.
//  Copyright (c) 2014年 gqg.com.luntan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "JSONKit.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "Common.h"
#import "MJRefreshFooterView.h"

@interface publicVC : UIViewController<MJRefreshBaseViewDelegate>
{
    MJRefreshFooterView *_footer;
}
@property (strong, nonatomic) AFHTTPRequestOperationManager *AFmanager;
@property (strong, nonatomic) NSString *urlPathStr;
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *hostURL;
@property (nonatomic, strong) MBProgressHUD *hud;


-(void) initTabbar:(NSString *)imageName selectImage:(NSString *)SLimageName;
- (void) setNavigationBar;
- (void)setUserDefaultValue:(NSString *)value forkey:(NSString *)key;
- (void)startModal;
- (void)stopModal;
@end
