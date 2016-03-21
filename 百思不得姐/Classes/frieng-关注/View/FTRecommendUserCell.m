//
//  FTRecommendUserCell.m
//  百思不得姐
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "FTRecommendUserCell.h"
#import "BSRecommendUser.h"
#import <UIImageView+WebCache.h>


@interface FTRecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *ReCountLable;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;

@end

@implementation FTRecommendUserCell

- (void)setUser:(BSRecommendUser *)user
{
    _user = user;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.header]];
    self.nameLabel.text = user.screen_name;
    self.ReCountLable.text = [NSString stringWithFormat:@"%@人关注",user.fans_count];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
