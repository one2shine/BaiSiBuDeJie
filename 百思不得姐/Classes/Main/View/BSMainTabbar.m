//
//  BSMainTabbar.m
//  百思不得姐
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSMainTabbar.h"
#import "BSPublishView.h"

@interface BSMainTabbar()
@property (nonatomic, weak) UIButton *composeBtn;

@end

@implementation BSMainTabbar
static UIWindow *window_;
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupComposeBtn];
        
        
        
    }
    return self;
}
- (void)setupComposeBtn
{
    
    UIButton *composeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [composeBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [composeBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
    [composeBtn addTarget:self action:@selector(composeBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:composeBtn];
    
    self.composeBtn = composeBtn;

}
- (void)composeBtnClicked
{
//    BSPublishView *publishView = [BSPublishView publishView];
////    UIWindow *window = [UIApplication sharedApplication].keyWindow;
////    publishView.frame = window.bounds;
////    [window addSubview:publishView];
//    
//    window_ = [[UIWindow alloc] init];
//    window_.windowLevel = UIWindowLevelStatusBar;
//    window_.frame = [UIScreen mainScreen].bounds;
//    window_.hidden = NO;
//    window_.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
//    
//    [window_ addSubview:publishView];
    
    [BSPublishView show];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.composeBtn.bounds = CGRectMake(0, 0, _composeBtn.currentBackgroundImage.size.width, _composeBtn.currentBackgroundImage.size.height);
    _composeBtn.center = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height *0.5);
    
    
    CGFloat btnY = 0;
    CGFloat btnH = self.bounds.size.height;
    CGFloat btnW = self.bounds.size.width / 5;
    
    NSInteger i = 0;
    for (UIView *btn in self.subviews) {
        if (![btn isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        if (i== 2) {
            i++;
        }
        CGFloat btnX = i * btnW;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        i++;
    }
}

@end
