//
//  HChatViewController.m
//  FitnessPattern
//
//  Created by SharonHu on 15/3/21.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import "HChatViewController.h"

@interface HChatViewController ()
{
    UIView *_operationView;//点击操作出现的视图
    UIView *_translucentBackView;//半透明背景
}
@end

@implementation HChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadTheSubviews];
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


- (void)loadTheSubviews
{
    
    [self.inputFieldView.layer setCornerRadius:4.f];
    [self initiateTheTranslucentBackView];
    [self initiateTheOperationView];
}


//半透明黑色背景
- (void)initiateTheTranslucentBackView
{
    _translucentBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [_translucentBackView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.f]];
    UITapGestureRecognizer *tapRG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelThePopView:)];
    [_translucentBackView addGestureRecognizer:tapRG];
}


//操作视图
- (void)initiateTheOperationView
{
    _operationView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 190.f)];
    [_operationView setBackgroundColor:[UIColor whiteColor]];
    UIButton *cleanButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, self.view.frame.size.width - 20, 40)];
    [cleanButton setBackgroundColor:Color_ThemeOrange];
    [cleanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cleanButton setTitle:@"清空对话" forState:UIControlStateNormal];
    [cleanButton addTarget:self action:@selector(cleanAllChatMessageAction:) forControlEvents:UIControlEventTouchUpInside];
    [_operationView addSubview:cleanButton];
    
    
    UIButton *reportButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 70, self.view.frame.size.width - 20, 40)];
    [reportButton setBackgroundColor:[UIColor whiteColor]];
    [reportButton setTitle:@"举报" forState:UIControlStateNormal];
    [reportButton addTarget:self action:@selector(reportAction:) forControlEvents:UIControlEventTouchUpInside];
    reportButton.layer.borderColor = RGBCOLOR(217.0, 217.0, 218.0).CGColor;
    reportButton.layer.borderWidth = 1.f;
    [reportButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_operationView addSubview:reportButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, 1)];
    [line setBackgroundColor:RGBCOLOR(217.0, 217.0, 218.0)];
    [_operationView addSubview:line];
    
    UIButton *cancelBT = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [cancelBT setCenter:CGPointMake(_operationView.center.x, _operationView.frame.size.height - 30)];
    [cancelBT setImage:[UIImage imageNamed:@"popover_btn_cancel02"] forState:UIControlStateNormal];
    [cancelBT addTarget:self action:@selector(cancelThePopView:) forControlEvents:UIControlEventTouchUpInside];
    [_operationView addSubview:cancelBT];
}

//操作
- (IBAction)operationAction:(id)sender {
    [self.view addSubview:_translucentBackView];
    [_translucentBackView addSubview:_operationView];
    [UIView animateWithDuration:0.3 animations:^{
        [_translucentBackView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
        [_operationView setFrame:CGRectMake(0, self.view.frame.size.height - 190.f, self.view.frame.size.width, 190.f)];
    } completion:nil];
}

//清空对话
- (void)cleanAllChatMessageAction:(id)sender
{
    
}

//举报
- (void)reportAction:(id)sender
{
    
}

//取消操作
- (void)cancelThePopView:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        [_translucentBackView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0]];
        [_operationView setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 150.f)];
    } completion:^(BOOL finished) {
        [_translucentBackView removeFromSuperview];
    }];
}
@end
