//
//  BSTopWindow.m
//  百思不得姐
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSTopWindow.h"


@implementation BSTopWindow
static UIWindow  *window_;
+ (void)initialize
{

    UIViewController *vc = [[UIViewController alloc] init];
    window_ = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, BSScreenWidth, 20)];
    window_.windowLevel = UIWindowLevelAlert;
    window_.rootViewController = vc;
    
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClicked)]];
    
}
+ (void)show
{
    window_.hidden = NO;
}
+ (void)windowClicked
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:keyWindow];
}

+ (void)searchScrollViewInView:(UIView *)view
{
    for (UIScrollView *subView in view.subviews) {
        if ([subView isKindOfClass:[UIScrollView class]] && [self isViewInScreen:subView]) {
            CGPoint offset = subView.contentOffset;
            offset.y = - subView.contentInset.top;
            
            [subView setContentOffset:offset animated:YES];
            
        }
        [self searchScrollViewInView:subView];
    }
}
+ (BOOL)isViewInScreen:(UIView *)view
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    CGRect newFrame = [view.superview convertRect:view.frame toView:nil];
    BOOL isIntersect = CGRectIntersectsRect(keyWindow.bounds, newFrame);
    
    return !view.isHidden && view.alpha > 0.01 && isIntersect  && view.window == keyWindow;
}
@end
