//
//  BSCategoryCell.m
//  百思不得姐
//
//  Created by mac on 16/3/9.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSCategoryCell.h"

@interface BSCategoryCell()

@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation BSCategoryCell
- (void)setCategory:(BSCategory *)category
{
    _category = category;
    self.textLabel.text = category.name;
}

- (void)awakeFromNib {
    self.backgroundColor = BSRGBColor(244, 244, 244);
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.y = 4;
    self.textLabel.height = self.contentView.height - 2 *self.textLabel.y;
    
}

   // Configure the view for the selected state

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    self.redView.hidden = !selected;
    
    if (selected) {
        
        self.textLabel.textColor = [UIColor redColor];
    } else {
        self.textLabel.textColor = [UIColor grayColor];
    }
}

@end
