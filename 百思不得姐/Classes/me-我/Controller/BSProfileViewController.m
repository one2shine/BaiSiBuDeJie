//
//  BSProfileViewController.m
//  百思不得姐
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSProfileViewController.h"

@interface BSProfileViewController ()

@end

@implementation BSProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的";
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightImage:@"mine-setting-icon-click" target:self action:@selector(mineSettingClicked)];
    UIBarButtonItem *moonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightImage:@"mine-moon-icon-click" target:self action:@selector(moonButtonClicked)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem,moonItem];
}
- (void)mineSettingClicked
{
    
}
- (void)moonButtonClicked
{
    
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

@end
