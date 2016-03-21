//
//  BSTopicCellVoiceView.m
//  百思不得姐
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSTopicCellVoiceView.h"
#import "BSTopic.h"
#import <UIImageView+WebCache.h>

@interface BSTopicCellVoiceView()
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *vocieTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation BSTopicCellVoiceView

+ (instancetype)vocieView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setTopic:(BSTopic *)topic
{
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.countLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.vocieTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
    
    
}
- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
