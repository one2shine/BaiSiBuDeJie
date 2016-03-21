//
//  BSCheckNotificationView.m
//  百思不得姐
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSCheckNotificationView.h"

@implementation BSCheckNotificationView
+ (instancetype)checkView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BSCheckNotificationView" owner:nil options:nil] lastObject];
}
+ (void)show
{
    
    NSString *bundleVersionKey = @"CFBundleShortVersionString";
    
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[bundleVersionKey];
    NSString *recoredVersion = [[NSUserDefaults standardUserDefaults] objectForKey:bundleVersionKey];
    
    if (![currentVersion isEqualToString:recoredVersion]) {
        
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:bundleVersionKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        BSCheckNotificationView *view = [BSCheckNotificationView checkView];
        
        view.frame = window.bounds;
        [window addSubview:view];
        NSLog(@"%@----%@",view.subviews,NSStringFromCGRect(view.frame));
    }

}
- (IBAction)dismissCheckView:(UIButton *)sender {
    
    [self removeFromSuperview];
}

@end
