//
//  UIBarButtonItem+extension.h
//  百思不得姐
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (extension)
+ (instancetype)itemWithImage:(NSString *)image highlightImage:(NSString *)highlightImage target:(id)target action:(SEL)action;
@end
