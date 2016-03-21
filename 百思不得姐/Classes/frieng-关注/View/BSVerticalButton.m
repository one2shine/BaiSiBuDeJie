//
//  BSVerticalButton.m
//  百思不得姐
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSVerticalButton.h"

@implementation BSVerticalButton

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.x = 0;
    self.imageView.y = 0;
    
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height + 10;
    self.titleLabel.width = self.width;
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;

}

@end
