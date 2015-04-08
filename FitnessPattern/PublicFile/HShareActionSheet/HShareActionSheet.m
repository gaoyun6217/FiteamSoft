//
//  HShareActionSheet.m
//  Roboo_App_Store
//
//  Created by 胡晓阳 on 14-9-23.
//  Copyright (c) 2014年 TTgg. All rights reserved.
//

#import "HShareActionSheet.h"

@interface HShareActionSheet ()

@end

@implementation HShareActionSheet
@synthesize sdelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    if ([[NSUserDefaults standardUserDefaults]objectForKey:Ziduan_ShareUrl] == nil) {
        shareurl = Share_Url;
    }
    else
        shareurl = [[[NSUserDefaults standardUserDefaults]objectForKey:Ziduan_ShareUrl] copy];
    
    sorceArray = [[NSArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:Ziduan_Sharetype] copyItems:YES];
    titleArray = [[NSMutableArray alloc]init];

    if (sorceArray.count > 4) {
//        [self addButtonWithTitle:@""];
    }
    UIView *shareView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 304, 170)];
    shareView.backgroundColor = [UIColor clearColor];
    [shareView.layer setCornerRadius:6.0];
    [shareView.layer setMasksToBounds:YES];
//    [[[self.view subviews] objectAtIndex:0] setBounds:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    
    
    
    for (int i = 0; i < sorceArray.count ; i++) {
        CGRect rect = CGRectMake(28.8*((i%4)+1)+40*(i%4), 23+40*(i/4)+30*(i/4), 40, 40);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = rect;
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[sorceArray objectAtIndex:i]]] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_x",[sorceArray objectAtIndex:i]]] forState:UIControlStateNormal];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80*(i%4), btn.frame.origin.y+btn.frame.size.height+5, 75, 20)];
        label.text = [Type_Share_Title objectAtIndex:[Type_Share indexOfObject:[sorceArray objectAtIndex:i]]];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12.f];
        label.center = CGPointMake(btn.center.x, label.center.y);
        btn.tag = 600+[Type_Share indexOfObject:[sorceArray objectAtIndex:i]];
        [btn addTarget:self action:@selector(touchShare:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [shareView addSubview:btn];
        [shareView addSubview:label];
    }
//    [self.view.layer addSublayer:view.layer];
    [self.view addSubview:shareView];
    [self.view bringSubviewToFront:shareView];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchShare:(UIButton *)sender
{
    //    [self dismissWithClickedButtonIndex:0 animated:YES];
    switch (sender.tag) {
        case 600:
        {
            if ([WXApi isWXAppInstalled]) {
                [self ShareWeiXinType:0];
            }
            else
            {
                [self showTheErrorWithName:@"微信"];
            }
        }
            break;
        case 601:
        {
//            [self dismissWithClickedButtonIndex:0 animated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
            if (![TencentOAuth iphoneQZoneInstalled]) {
                [self showTheErrorWithName:@"QQ空间"];
            }
            else
            {
                [sdelegate touchQQorQZ:NO];
                //                NSArray *permissions =  [NSArray arrayWithObjects:kOPEN_PERMISSION_ADD_TOPIC,nil];
                //                if (![qqLogin isSessionValid]) {
                //                    [qqLogin localAppId];
                //                    [qqLogin authorize:permissions inSafari:NO];
                //                }
                //                else
                //                {
                //                    qqOrZone = NO;
                //                }
                
            }
            
        }
            break;
        case 602:
        {
//            [self dismissWithClickedButtonIndex:0 animated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
            
            if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"TencentWeibo://"]]) {
                AppDelegate *dele = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                if (dele.mywebapi == nil) {
                    dele.mywebapi = [[WeiboApi alloc]initWithAppKey:Share_qqwb_APPID andSecret:Share_qqwb_APPKEY andRedirectUri:Share_qqwb_Url andAuthModeFlag:1 andCachePolicy:0];
                }
                if (dele.mywebapi) {
                    [dele.mywebapi loginWithDelegate:_reader andRootController:_reader];
                }
            }
            else
                [self showTheErrorWithName:@"腾讯微博"];
            
        }
            break;
        case 603:
        {
            WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare]];
            request.userInfo = @{@"ShareMessageFrom": @"SendMessageToWeiboViewController",
                                 @"Other_Info_1": [NSNumber numberWithInt:123],
                                 @"Other_Info_2": @[@"obj1", @"obj2"],
                                 @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
            
            [WeiboSDK sendRequest:request];
        }
            break;
        case 604:
        {
            [RennClient loginWithDelegate:self];
        }
            break;
        case 605:
        {
            if ([WXApi isWXAppInstalled]) {
                [self ShareWeiXinType:1];
            }
            else
            {
                [self showTheErrorWithName:@"微信"];
            }
        }
            break;
        case 606:
        {
//            [self dismissWithClickedButtonIndex:0 animated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
            if (![QQApi isQQInstalled]) {
                [self showTheErrorWithName:@"QQ"];
            }
            else
            {
                [sdelegate touchQQorQZ:YES];
                //                NSArray *permissions =  [NSArray arrayWithObjects:kOPEN_PERMISSION_ADD_TOPIC,nil];
                //                if (![qqLogin isSessionValid]) {
                //                    [qqLogin localAppId];
                //                    [qqLogin authorize:permissions inSafari:NO];
                //                }
                //                else
                //                {
                //                    qqOrZone = YES;
                //                    [self tencentDidLogin];
                //                }
                
            }
        }
            break;
        default:
//            [self dismissWithClickedButtonIndex:0 animated:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
            [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
            [self showSMSPicker];
            break;
    }
}

-(void)showSMSPicker
{
    Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
    if (messageClass != nil) {
        if ([messageClass canSendText]) {
            [self displaySMSComposerSheet];
        }
        else {
            UIAlertView *aa = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"您的设备不支持发送短信。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
            [aa show];
        }
    }
    else {
        UIAlertView *aa = [[UIAlertView alloc]initWithTitle:@"抱歉" message:@"您的设备版本太低，不支持程序内发送短信。" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [aa show];
    }
}

- (void)displaySMSComposerSheet
{
    MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
    picker.messageComposeDelegate = _reader;
    picker.body = [NSString stringWithFormat:@"%@%@",Share_Mes,shareurl];
    
    [_reader presentViewController:picker animated:YES completion:NULL];
}

-(void)ShareWeiXinType:(int)type
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.description = [NSString stringWithFormat:@"%@%@",Share_Mes,shareurl];
    if (type == 1) {
        message.title = [NSString stringWithFormat:@"%@%@",Share_Mes,shareurl];
    }
    [message setThumbImage:DefaultImage_DefaultIcon];
    
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = shareurl;
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = type;
    [WXApi sendReq:req];
}

- (WBMessageObject *)messageToShare
{
    WBMessageObject *message = [WBMessageObject message];
    message.text = Share_Mes;
    WBImageObject *image = [WBImageObject object];
    image.imageData = UIImagePNGRepresentation(DefaultImage_DefaultIcon);
    message.imageObject = image;
    return message;
}

-(void)rennLoginSuccess
{
    UploadPhotoParam *param = [[UploadPhotoParam alloc]init];
    //    param.albumId = @"";
    param.description = [NSString stringWithFormat:@"%@%@",Share_Mes,shareurl];
    NSData *data = UIImagePNGRepresentation(DefaultImage_DefaultIcon);
    param.file =  data;
    [RennClient sendAsynRequest:param delegate:self];
}
-(void)rennService:(RennService *)service requestFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
-(void)rennService:(RennService *)service requestSuccessWithResponse:(id)response
{
    //    NSLog(@"%@",service.type);
    
    //    NSArray *arr = response;
    //    NSLog(@"%@",arr);
    
//    [self dismissWithClickedButtonIndex:0 animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}







- (void)tencentDidLogin
{
    NSString *des = [NSString stringWithFormat:@"%@%@",Share_Mes,shareurl];
    NSString *url = shareurl;
    QQApiNewsObject *newsobject= [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:@" " description:des previewImageData:UIImagePNGRepresentation(DefaultImage_DefaultIcon) imageDataArray:nil];
    SendMessageToQQReq *req =[SendMessageToQQReq reqWithContent:newsobject];
    
    [self doshare:req];
    
    
}
- (void)tencentDidNotLogin:(BOOL)cancelled;
{
    
}
- (void)tencentDidNotNetWork;
{
    
}
-(void)doshare:(SendMessageToQQReq *)req
{
    if (qqOrZone == YES) {
        [QQApiInterface sendReq:req];
    }
    else
        [QQApiInterface SendReqToQZone:req];
}



-(void)showTheErrorWithName:(NSString *)ss
{
    if (self) {
//        [self dismissWithClickedButtonIndex:0 animated:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    NSString *error = [NSString stringWithFormat:@"%@-客户端未安装",ss];
    UIAlertView *a= [[UIAlertView alloc]initWithTitle:@"未安装客户端" message:error delegate:_reader cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
    [a show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
