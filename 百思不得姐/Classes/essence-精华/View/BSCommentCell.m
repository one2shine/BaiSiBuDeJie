//
//  BSCommentCell.m
//  百思不得姐
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSCommentCell.h"
#import "BSTopicComment.h"
#import <UIImageView+WebCache.h>

@interface BSCommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *comentLabel;

@end

@implementation BSCommentCell

- (void)awakeFromNib {
    self.iconView.layer.cornerRadius = 17.5;
    self.iconView.layer.masksToBounds = YES;
    
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:an

   
}
- (void)setComment:(BSTopicComment *)comment
{
    _comment = comment;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = comment.user.username;
    self.sexView.image = [comment.user.sex isEqualToString:BSUserSexMale]?[UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.like_count];
    self.comentLabel.text = comment.content;
    
    
    
    
}
@end
