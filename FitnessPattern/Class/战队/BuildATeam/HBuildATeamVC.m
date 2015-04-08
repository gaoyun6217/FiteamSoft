//
//  HBuildATeamVC.m
//  FitnessPattern
//
//  Created by 胡晓阳 on 15/3/6.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import "HBuildATeamVC.h"

@interface HBuildATeamVC ()
{
    PopupView *myPopView;
}
@end

@implementation HBuildATeamVC

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
    
    
    
    //背景色
    [self.view setBackgroundColor:Color_AppBackground];
    
    [_teamNameTextField.layer setMasksToBounds:YES];
    [_teamNameTextField.layer setCornerRadius:6.0];
    [_teamNameTextField setBackgroundColor:[UIColor whiteColor]];
    
    [_teamIntroductionTextView.layer setMasksToBounds:YES];
    [_teamIntroductionTextView.layer setCornerRadius:6.0];
    [_teamIntroductionTextView setBackgroundColor:[UIColor whiteColor]];
    [_teamIntroductionTextView setText:@""];
    
    [_nextButton.layer setMasksToBounds:YES];
    [_nextButton.layer setCornerRadius:6.0];
    
    //toast提示
    myPopView = [[PopupView alloc] initWithFrame:CGRectMake(100, 300, 0, 0)];
    myPopView.ParentView = self.view;
    
    [_secondView setBackgroundColor:Color_AppBackground];
    [_secondView setAlpha:0.f];
    
    
    

}

- (void)doBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)nextAction:(id)sender {
    if (_teamNameTextField.text.length == 0 || _teamIntroductionTextView.text.length == 0) {
        [myPopView setText:@"内容不完整"];
        [self.view addSubview:myPopView];
    }else
    {
        [self.view bringSubviewToFront:_secondView];
        [UIView animateWithDuration:0.3 animations:^{
            [_secondView setAlpha:1.0];
        } completion:^(BOOL finished) {
            [_teamNameTextField resignFirstResponder];
            [_teamIntroductionTextView resignFirstResponder];
        }];
    }
}

- (IBAction)finishAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextField Delegate Methods
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    if ([textField isEqual:_teamNameTextField]) {
        [_teamIntroductionTextView becomeFirstResponder];
        return NO;
    }
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
//    if ([textField isEqual:_teamNameTextField]) {
//        [_teamNameTextField resignFirstResponder];
//        [_teamIntroductionTextView becomeFirstResponder];
//    }
}
@end
