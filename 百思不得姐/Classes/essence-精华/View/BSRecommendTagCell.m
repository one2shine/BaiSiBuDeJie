//
//  BSRecommendTagCell.m
//  百思不得姐
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSRecommendTagCell.h"
#import "BSRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface BSRecommendTagCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *reCountLabel;

@end

@implementation BSRecommendTagCell

+ (instancetype)cell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BSRecommendTagCell class]) owner:nil options:nil] lastObject];
}

- (void)setRecommendTag:(BSRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list]];
    
    self.nameLabel.text = recommendTag.theme_name;
    if (recommendTag.sub_number > 10000) {
        self.reCountLabel.text = [NSString stringWithFormat:@"%.1f万人关注",recommendTag.sub_number/10000.0];
    } else {
        self.reCountLabel.text = [NSString stringWithFormat:@"%ld人关注",recommendTag.sub_number];
    }
}

- (void)awakeFromNib {
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.contentView.x = 10;
}
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = 4;
    frame.size.width = frame.size.width - frame.origin.x * 2;
    frame.size.height -= 1;
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
