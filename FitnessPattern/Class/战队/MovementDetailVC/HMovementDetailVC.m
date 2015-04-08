//
//  HMovementDetailVC.m
//  FitnessPattern
//
//  Created by 胡晓阳 on 15/3/11.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import "HMovementDetailVC.h"

@interface HMovementDetailVC ()
{
    NSMutableDictionary *_myDetailMovementDic;
    UIScrollView *_myScrollView;
}
@end

@implementation HMovementDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //改变title颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
    //修改返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    
    

    //获取数据
    [self loadTheDataSourceOfMovementDetail];
    [self loadTheSubviews];
}

- (void)doBack:(UIBarButtonItem *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 获取动态详情
- (void)loadTheDataSourceOfMovementDetail
{
    
    //动态详情
    _myDetailMovementDic = [[NSMutableDictionary alloc] init];
    NSString *userLogoUrl1 = @"headPic.png";//后期改为URL链接
    NSString *userName1 = @"腹肌撕裂者";
    NSString *publishDate1 = @"5分钟前";
    NSString *teamDetailImage1 = @"Toronto, ON.jpg";
    NSString *description1 = @"练习半年，维度大了一圈，非常辛苦，也非常难得。感谢鼓励我坚持下来的小伙伴们，希望有新伙伴能够加入我们，我们一起做健身达人！";
    NSString *upNum = @"3";
    NSMutableArray *upUsers = [[NSMutableArray alloc] initWithCapacity:0];
    NSDictionary *user1 = [NSDictionary dictionaryWithObjectsAndKeys:@"headPic.jpg",@"headPic", nil];
    NSDictionary *user2 = [NSDictionary dictionaryWithObjectsAndKeys:@"headPic.jpg",@"headPic", nil];
    NSDictionary *user3 = [NSDictionary dictionaryWithObjectsAndKeys:@"headPic.jpg",@"headPic", nil];

    NSDictionary *user4 = [NSDictionary dictionaryWithObjectsAndKeys:@"headPic.jpg",@"headPic", nil];

//    NSDictionary *user5 = [NSDictionary dictionaryWithObjectsAndKeys:@"headPic.jpg",@"headPic", nil];

    [upUsers addObject:user1];
    [upUsers addObject:user2];
    [upUsers addObject:user3];
    [upUsers addObject:user4];
//    [upUsers addObject:user5];
    
    [_myDetailMovementDic setObject:userLogoUrl1 forKey:@"userLogo"];
    [_myDetailMovementDic setObject:userName1 forKey:@"userName"];
    [_myDetailMovementDic setObject:teamDetailImage1 forKey:@"image"];
    [_myDetailMovementDic setObject:description1 forKey:@"description"];
    [_myDetailMovementDic setObject:publishDate1 forKey:@"publishDate"];
    [_myDetailMovementDic setObject:upNum forKey:@"upNum"];

    [_myDetailMovementDic setObject:upUsers forKey:@"upUsers"];
}

- (void)loadTheSubviews
{
    _myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+44)];
//    [_myScrollView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_myScrollView];
    [_myScrollView setScrollEnabled:YES];
    
    
    
    
    BOOL hasImage = NO;
    NSString *imgUrl = [NSString stringWithFormat:@"%@",[_myDetailMovementDic objectForKey:@"image"]];
    UIImageView *movementImgView = nil;
    if ([imgUrl length] != 0) {
        
        hasImage = YES;
        UIImage *img = [UIImage imageNamed:imgUrl];
        movementImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, self.view.frame.size.width - 20)];
        
        [movementImgView setImage:img];
        
        [_myScrollView addSubview:movementImgView];
    }
    
    //描述
    UITextView *descriptionTextView = [[UITextView alloc] init];
    descriptionTextView.editable = NO;
    
    NSString *teamDescription = [_myDetailMovementDic objectForKey:@"description"];
    UIFont *font_description = [UIFont systemFontOfSize:17.f];
    
    [descriptionTextView setText:teamDescription];
    [descriptionTextView setFont: font_description];
    
    CGSize constrainedSize = CGSizeMake(self.view.frame.size.width - 20, 1000);
    CGSize actualSize = [teamDescription sizeWithFont:descriptionTextView.font constrainedToSize:constrainedSize lineBreakMode:NSLineBreakByWordWrapping];
//    CGSize actualSize = [teamDescription boundingRectWithSize:<#(CGSize)#> options:<#(NSStringDrawingOptions)#> attributes:<#(NSDictionary *)#> context:<#(NSStringDrawingContext *)#>]
    
    [descriptionTextView setFrame:CGRectMake(10, 10 + (hasImage?movementImgView.frame.size.height:0) + (hasImage ? 5:0), actualSize.width, actualSize.height + 20)];
    
    [descriptionTextView setBackgroundColor:[UIColor whiteColor]];
    [descriptionTextView setTextColor:FontColor_ContentTextView];
    [descriptionTextView setScrollEnabled:NO];
    [descriptionTextView setEditable:NO];
    [_myScrollView addSubview:descriptionTextView];
    
    
    
    //点赞按钮
    UIButton *upButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 10 - 25, descriptionTextView.frame.origin.y + descriptionTextView.frame.size.height + 10, 25, 25)];
    [upButton setImage:[UIImage imageNamed:@"up.png"] forState:UIControlStateNormal];
    [_myScrollView addSubview:upButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, upButton.frame.origin.y + upButton.frame.size.height + 10, _myScrollView.frame.size.width, 1)];
    [line setBackgroundColor:[UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1]];
    [_myScrollView addSubview:line];
    
    //点赞个数
    NSString *upNum = @"4";
    UILabel *upNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, line.frame.origin.y + 1 + 10, 100, 21)];
    [upNumLabel setTextColor:RGBCOLOR(139.0, 139.0, 139.0)];
    [upNumLabel setText:[NSString stringWithFormat:@"%@人赞过",upNum]];
    [_myScrollView addSubview:upNumLabel];
    
    
    //展示点赞的用户的头像
    //API
    
#pragma mark 2015/4/7 高云修改仅显示4个图标多的就用用省略号隐藏
    NSMutableArray *upUsers = [_myDetailMovementDic objectForKey:@"upUsers"];
    UIButton *moreBT = nil;
    for (int i = 0; i < upUsers.count; i++) {
        
        if (i <5) {
            UIImageView *userImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * (i+1) + 30*i , upNumLabel.frame.origin.y + upNumLabel.frame.size.height + 10, 30, 30)];
            [userImgView setImage:[UIImage imageNamed:[[upUsers objectAtIndex:i] objectForKey:@"headPic"]]];
            [userImgView.layer setMasksToBounds:YES];
            userImgView.layer.cornerRadius = 15.f;
            [_myScrollView addSubview:userImgView];
            
//            if (i == upUsers.count - 1) {
//                moreBT = [[UIButton alloc] initWithFrame:CGRectMake(userImgView.frame.origin.x + userImgView.frame.size.width + 10, userImgView.frame.origin.y, 30, 30)];
//                [moreBT setImage:[UIImage imageNamed:@"moreUp"] forState:UIControlStateNormal];
//                [_myScrollView addSubview:moreBT];
//            }

        }
        else
        {
            UIImageView *userImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10 * (i+1) + 30*i , upNumLabel.frame.origin.y + upNumLabel.frame.size.height + 10, 30, 30)];
            [userImgView setImage:[UIImage imageNamed:[[upUsers objectAtIndex:i] objectForKey:@"headPic"]]];
            [userImgView.layer setMasksToBounds:YES];
            userImgView.layer.cornerRadius = 15.f;
            [_myScrollView addSubview:userImgView];
            
            if (i == upUsers.count - 1) {
                moreBT = [[UIButton alloc] initWithFrame:CGRectMake(userImgView.frame.origin.x + userImgView.frame.size.width + 10, userImgView.frame.origin.y, 30, 30)];
                [moreBT setImage:[UIImage imageNamed:@"moreUp"] forState:UIControlStateNormal];
                [_myScrollView addSubview:moreBT];
            }

        }
    }
    
    [_myScrollView setContentSize:CGSizeMake(_myScrollView.frame.size.width, moreBT.frame.origin.y + 30 + 20)];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)showShareViewAction:(id)sender {
    
}
@end
