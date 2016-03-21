//
//  UIBarButtonItem+extension.m
//  百思不得姐
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "UIBarButtonItem+extension.h"

@implementation UIBarButtonItem (extension)
+ (instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightImage] forState:UIControlStateHighlighted];
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
