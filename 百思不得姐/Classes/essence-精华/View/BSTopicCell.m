//
//  BSTopicCell.m
//  百思不得姐
//
//  Created by mac on 16/3/12.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSTopicCell.h"
#import "BSTopic.h"
#import "BSTopicCellMiddleView.h"
#import "BSTopicCellVoiceView.h"
#import "BSTopicCellVideoView.h"
#import "BSTopicComment.h"

#import <UIImageView+WebCache.h>

@interface BSTopicCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingBtn;
@property (weak, nonatomic) IBOutlet UIButton *caiBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UILabel *text_label;

@property (nonatomic, weak) BSTopicCellMiddleView *middelView;
@property (nonatomic, weak) BSTopicCellVoiceView *vocieView;
@property (nonatomic, weak) BSTopicCellVideoView *videoView;

@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UILabel *cmtContentLabel;



@end

@implementation BSTopicCell
- (BSTopicCellVideoView *)videoView
{
    if (!_videoView) {
        _videoView = [BSTopicCellVideoView videoView];
        [self addSubview:_videoView];
    }
    return _videoView;
}
- (BSTopicCellVoiceView *)vocieView
{
    if (!_vocieView) {
        _vocieView = [BSTopicCellVoiceView vocieView];
        
        [self addSubview:_vocieView];
        
    }
    return _vocieView;
}
- (BSTopicCellMiddleView *)middelView
{
    if (!_middelView) {
        _middelView = [BSTopicCellMiddleView middleView];
        [self.contentView addSubview:_middelView];
    }
    return _middelView;
}
+ (instancetype)topicCell
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib {
    
//    UIImageView *bgView = [[UIImageView alloc] init];
//    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
//    self.backgroundView = bgView;
    
    self.iconView.layer.cornerRadius = 20;
    self.iconView.clipsToBounds = YES;
    
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
}
- (void)setFrame:(CGRect)frame
{
//    frame.origin.x = BSTopicCellMargin;
//    frame.origin.y += BSTopicCellMargin;
//    frame.size.width -= 2 *BSTopicCellMargin;
    frame.size.height = self.topic.cellHeight - BSTopicCellMargin;
    
    [super setFrame:frame];
}

- (void)setTopic:(BSTopic *)topic
{
    _topic = topic;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLabel.text = topic.name;
    
    
    self.timeLabel.text = [self deltaTime:topic.created_at];
    
    self.text_label.text = topic.text;
    
    if (topic.type == BSDuanziTypePhoto) {
        self.middelView.frame = topic.middleViewF;
        self.middelView.topic = self.topic;
        
        self.middelView.hidden = NO;
        self.vocieView.hidden = YES;
        self.videoView.hidden = YES;
    } else  if (topic.type == BSDuanziTypeVoice){
        self.vocieView.hidden = NO;
        
        self.vocieView.frame = topic.voiceViewF;
        self.vocieView.topic = self.topic;
        
        self.middelView.hidden = YES;
        self.videoView.hidden = YES;
        
    } else if (topic.type == BSDuanziTypeVideo) {
        self.videoView.hidden = NO;
        self.videoView.topic = topic;
        self.videoView.frame = topic.videoViewF;
        
        self.middelView.hidden = YES;
        self.vocieView.hidden = YES;
        
    } else {
        self.middelView.hidden = YES;
        self.vocieView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
    BSTopicComment *cmt = topic.top_cmt;
    if (cmt) {
        self.commentView.hidden = NO;
        self.cmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@",cmt.user.username,cmt.content];
    } else {
        self.commentView.hidden = YES;
    }
    
    
    
    [self setBtn:self.dingBtn title:topic.ding placeholder:@"顶"];
    [self setBtn:self.caiBtn title:topic.cai placeholder:@"踩"];
    [self setBtn:self.shareBtn title:topic.repost placeholder:@"转发"];
    [self setBtn:self.dingBtn title:topic.comment placeholder:@"评论"];
    
}

- (NSString *)deltaTime:(NSString *)time
{
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];

    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *now = [NSDate date];
    NSDate *from = [fmt dateFromString:time];
    
    if ([self isThisYear:from]) {
        
        if ([self isToday:from]) {
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSCalendarUnit unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
            NSDateComponents *cmps = [calendar components:unit fromDate:from toDate:now options:0];
            
            if (cmps.hour == 0) {
                if (cmps.minute == 0) {
                    return @"刚刚";
                } else {
                    return [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
                }
            } else {
                
                return [NSString stringWithFormat:@"%ld小时前",cmps.hour];
            }
            
            
        } else if ([self isYesterday:from]) {
            fmt.dateFormat = @"HH:mm";
            return [NSString stringWithFormat:@"昨天 %@",[fmt stringFromDate:from]];
        } else {
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:from];
        }
    } else {
       
        return [fmt stringFromDate:from];
    }
    
    
    
}
/**
 *  判断某一日期是否为昨天
 *
 *  @param date 要判断的日期
 *
 *  @return yes or no
 */
- (BOOL)isYesterday:(NSDate *)date
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSDate *now = [NSDate date];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;

}
/**
 *  判断某一日期是否为今天
 *
 *  @param date 要判断的日期
 *
 *  @return yes or no
 */
- (BOOL)isToday:(NSDate *)date
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy-MM-dd"];
//    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
//    [fmt setLocale:locale];
//    [fmt setDateStyle:NSDateFormatterShortStyle];
//    [fmt setTimeStyle:NSDateFormatterNoStyle];
    
    
    NSDate *now = [NSDate date];
   
    NSString *dateStr = [fmt stringFromDate:date];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}
/**
 *  判断某一日期是否为今年
 *
 *  @param date 要判断的日期
 *
 *  @return yes or no
 */
- (BOOL)isThisYear:(NSDate *)date
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger now = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger from = [calendar component:NSCalendarUnitYear fromDate:date];
    
    return now == from;
    
}
- (void)setBtn:(UIButton *)button title:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count >= 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万",count/ 10000.0];
        
    } else if ( count> 0 ){
        placeholder = [NSString stringWithFormat:@"%ld",count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
