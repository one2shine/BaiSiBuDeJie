//
//  BSFocusViewController.m
//  百思不得姐
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSFocusViewController.h"
#import "BSRecommendViewController.h"
#import "BSLoginController.h"

@interface BSFocusViewController ()
- (IBAction)login:(id)sender;

@end

@implementation BSFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsRecommentIconClicked)];
    
}
- (void)friendsRecommentIconClicked
{
    BSRecommendViewController *recommendVC = [[BSRecommendViewController alloc] init];
    
    [self.navigationController pushViewController:recommendVC animated:YES];

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

- (IBAction)login:(id)sender {
    
    BSLoginController *loginVC = [[BSLoginController alloc] init];
    loginVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self presentViewController:loginVC animated:YES completion:nil];
}
@end
