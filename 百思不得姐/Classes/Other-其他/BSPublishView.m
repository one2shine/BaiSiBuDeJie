//
//  BSPublishView.m
//  百思不得姐
//
//  Created by mac on 16/3/14.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSPublishView.h"
#import "BSVerticalButton.h"
#import <POP.h>

@interface BSPublishView()

@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak ,nonatomic) UIImageView *sloganView;
@property (nonatomic, strong) NSMutableArray *btns;
@end

@implementation BSPublishView
static UIWindow *window_;

- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [NSMutableArray array];
        
    }
    return _btns;
}
+ (void)show
{
    window_ = [[UIWindow alloc] init];
    window_.windowLevel = UIWindowLevelStatusBar;
    window_.frame = [UIScreen mainScreen].bounds;
    window_.hidden = NO;
    BSPublishView *view = [self publishView];
    view.frame = [UIScreen mainScreen].bounds;
    [window_ addSubview:view];
}
+ (instancetype)publishView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib
{
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelBtnClicked)]];
    
    self.userInteractionEnabled = NO;
    
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    int maxCols = 3;
    CGFloat btnW = 72;
    CGFloat btnH = 72 + 30;
    NSInteger count = titles.count;
    CGFloat screenH = BSScreenHeight;
    CGFloat screenW = BSScreenWidth;
    CGFloat startMaginX = 20;
    CGFloat btnXMargin = (screenW - 2 * startMaginX  - maxCols * btnW) / (maxCols - 1);
    CGFloat startY = screenH * 0.5 - btnH;
    
    for (NSInteger i = 0; i<count; i++) {
        BSVerticalButton *btn = [[BSVerticalButton alloc] init];
        btn.tag = i;
        [self addSubview:btn];
        [self.btns addObject:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger row = i / maxCols;
        NSInteger col = i % maxCols;
        CGFloat btnX = startMaginX + col * (btnW + btnXMargin);
        CGFloat btnStartY = startY + row * btnH - screenH;
        CGFloat btnEndY = startY + row * btnH;
        
        POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        animation.springBounciness = 10;
        animation.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnStartY, btnW, btnH)];
        animation.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnEndY, btnW, btnH)];
        animation.beginTime = CACurrentMediaTime() + 0.6 - 0.1 * i;
        [btn pop_addAnimation:animation forKey:nil];
        
    }
    
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self addSubview:sloganView];
    
    self.sloganView = sloganView;
    CGFloat sloganCenterX = screenW * 0.5;
    CGFloat sloganCenterEndY = screenH * 0.2;
    
    
    CGFloat sloganCenterStartY = sloganCenterEndY - screenH;
    sloganView.y = sloganCenterStartY;
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    animation.springBounciness = 5;
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(sloganCenterX, sloganCenterStartY)];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(sloganCenterX, sloganCenterEndY)];
    animation.beginTime = CACurrentMediaTime() + count * 0.1 + 0.1;
    [animation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
        self.userInteractionEnabled = YES;
    }];
    NSLog(@"%@",NSStringFromCGRect(sloganView.frame));
    [sloganView pop_addAnimation:animation forKey:nil];
    
    
    
}
- (void)btnClicked:(BSVerticalButton *)btn
{
    switch (btn.tag) {
        case 0:
            NSLog(@"发视频");
            [self cancelBtnClicked];
            break;
            
        case 1:
            NSLog(@"发图片");
            break;
            
        case 2:
            NSLog(@"发视频");
            break;
            
        case 3:
            NSLog(@"发图片");
            break;
        case 4:
            NSLog(@"发视频");
            break;
            
        case 5:
            NSLog(@"发图片");
            break;
            
        default:
            break;
            
    }
}

- (void)cancelBtnClicked
{
    self.userInteractionEnabled = NO;
    
    for ( NSInteger i = 0; i < self.btns.count; i++) {
        
        BSVerticalButton *btn = self.btns[i];
        CGFloat centerEndY = btn.centerY + BSScreenHeight;
        POPSpringAnimation *ani = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        ani.springBounciness = 10;
        ani.toValue = [NSValue valueWithCGPoint:CGPointMake(btn.centerX, centerEndY)];
        ani.fromValue = [NSValue valueWithCGPoint:CGPointMake(btn.centerX, btn.centerY)];
        ani.beginTime = CACurrentMediaTime() + i * 0.1;
        
        [btn pop_addAnimation:ani forKey:nil];
        
    }
    
    CGFloat sloganEndY = self.sloganView.centerY + BSScreenHeight;
    POPSpringAnimation *ani = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    ani.springBounciness = 10;
    ani.toValue = [NSValue valueWithCGPoint:CGPointMake(self.sloganView.centerX, sloganEndY)];
    ani.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.sloganView.centerX, self.sloganView.centerY)];
    ani.beginTime = self.btns.count * 0.1;
    
    [ani setCompletionBlock:^(POPAnimation *ani, BOOL finished)  {
        
        [self removeFromSuperview];
        window_.hidden = YES;
        window_ = nil;
    }];
    [self.sloganView pop_addAnimation:ani forKey:nil];
}
@end
