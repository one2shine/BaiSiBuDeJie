//
//  BSTopicCellVideoView.m
//  百思不得姐
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSTopicCellVideoView.h"
#import "BSTopic.h"
#import <UIImageView+WebCache.h>

@interface BSTopicCellVideoView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *videoTimeLabel;


@end

@implementation BSTopicCellVideoView

+ (instancetype)videoView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)setTopic:(BSTopic *)topic
{
    _topic = topic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    self.playCountLabel.text = [NSString stringWithFormat:@"%zd次播放",topic.playcount];
    NSInteger minute = topic.videotime / 60;
    NSInteger second = topic.videotime % 60;
    self.videoTimeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd",minute,second];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
}
@end
