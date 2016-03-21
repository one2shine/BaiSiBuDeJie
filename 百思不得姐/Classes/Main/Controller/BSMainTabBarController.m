//
//  BSMainTabBarController.m
//  百思不得姐
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSMainTabBarController.h"
#import "BSJinghuaViewController.h"
#import "BSNewStatementViewController.h"
#import "BSFocusViewController.h"
#import "BSProfileViewController.h"
#import "BSMainTabbar.h"
#import "BSNavigationController.h"

@interface BSMainTabBarController ()

@end

@implementation BSMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [self setupsetupTabBarItemAppearance];
    
    
    
    BSJinghuaViewController *jingHuaVC = [[BSJinghuaViewController alloc] init];
    [self settup:jingHuaVC title:@"精华" image:@"tabBar_essence_icon" clickImage:@"tabBar_essence_click_icon"];
    
    BSNewStatementViewController *newStateVC = [[BSNewStatementViewController alloc] init];
    [self settup:newStateVC title:@"新帖" image:@"tabBar_new_icon" clickImage:@"tabBar_new_click_icon"];
    
    BSFocusViewController *focusVC = [[BSFocusViewController alloc] init];
    [self settup:focusVC title:@"关注" image:@"tabBar_friendTrends_icon" clickImage:@"tabBar_friendTrends_click_icon"];
    
    BSProfileViewController *profileVC = [[BSProfileViewController alloc] init];
    [self settup:profileVC title:@"我" image:@"tabBar_me_icon" clickImage:@"tabBar_me_click_icon"];
    
    [self setValue:[[BSMainTabbar alloc] init] forKeyPath:@"tabBar"];
    
    
}
- (void)setupsetupTabBarItemAppearance
{
    UITabBarItem *item = [UITabBarItem appearance];
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
    attr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    NSMutableDictionary *selectAttr = [NSMutableDictionary dictionary];
    selectAttr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    selectAttr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    
    
    
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttr forState:UIControlStateSelected];
}

- (void)settup:(UIViewController *)viewController title:(NSString *)title image:(NSString *)image clickImage:(NSString *)clickImage
{
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:image];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:clickImage];
    
    BSNavigationController *navi = [[BSNavigationController alloc] initWithRootViewController:viewController];
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    [viewController.tabBarItem setTitleTextAttributes:attr forState:UIControlStateNormal];
    [self addChildViewController:navi];
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
