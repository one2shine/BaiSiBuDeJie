//
//  BSLoginTextField.m
//  百思不得姐
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSLoginTextField.h"

@implementation BSLoginTextField

- (void)awakeFromNib
{
    self.tintColor = [UIColor whiteColor];
    
    

}

- (BOOL)becomeFirstResponder
{
    [self setValue:self.textColor forKeyPath:@"_placeholderLabel.textColor"];
    return [super becomeFirstResponder];
    
}
- (BOOL)resignFirstResponder
{
    [self setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    return [super resignFirstResponder];
    
}

@end
