//
//  HMessageTableViewController.m
//  FitnessPattern
//
//  Created by SharonHu on 15/3/21.
//  Copyright (c) 2015年 HuntingTime. All rights reserved.
//

#import "HMessageTableViewController.h"
#import "HChatViewController.h"

@interface HMessageTableViewController ()
{
    AppDelegate *_appDelegate;
}
@end

@implementation HMessageTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (_appDelegate.userInfoDic == nil) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"PresentLoginView" object:nil];
    }
    [self.tabBarController.tabBar setHidden:NO];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //改变title颜色
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageCell" forIndexPath:indexPath];
    
    // Configure the cell...
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:10];
    UILabel *titleLB = (UILabel *)[cell.contentView viewWithTag:11];
    UILabel *detailLB = (UILabel *)[cell.contentView viewWithTag:12];
    
    //红色标记
    UIView *badgeView = (UIView *)[cell.contentView viewWithTag:14];
    [badgeView.layer setCornerRadius:5.f];
    
    switch (indexPath.row) {
        case 0:
        {
            [imageView setImage:[UIImage imageNamed:@"chat_ico_girl"]];
            [titleLB setText:@"腹肌撕裂者"];
            [detailLB setText:@"大哥，你晚上还来不来了，都等着呢"];
        }
            break;
        case 1:
        {
            [imageView setImage:[UIImage imageNamed:@"chat_ico_boy"]];
            [titleLB setText:@"战队消息"];
            [detailLB setText:@"Sharon申请加入战队"];
        }
            break;
        case 2:
        {
            [imageView setImage:[UIImage imageNamed:@"chat_ico_remind"]];
            [titleLB setText:@"通知中心"];
            [detailLB setText:@"［文章］如何正确地锻炼腹肌"];
        }
            break;
        default:
            break;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self.navigationController performSegueWithIdentifier:@"ShowChatVC" sender:nil];
            break;
            
        case 1:
            [self.navigationController performSegueWithIdentifier:@"ShowTeamMessageVC" sender:nil];
            break;
        case 2:
            break;
            
        default:
            break;
    }
    [self.tabBarController.tabBar setHidden:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//    if ([segue.identifier isEqualToString:@"ShowChatVC"]) {
//        HChatViewController *chatVC = (HChatViewController *)segue.destinationViewController;
//    }
//}


@end
