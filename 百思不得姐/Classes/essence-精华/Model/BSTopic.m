//
//  BSTopic.m
//  百思不得姐
//
//  Created by mac on 16/3/12.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSTopic.h"
#import "BSTopicComment.h"
#import <MJExtension.h>

@implementation BSTopic

{
    CGFloat _cellHeight;
    CGRect _middleViewF;
}

static CGFloat const cellCommentTitleHeight = 16;
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"top_cmt" : @"BSTopicComment"};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"small_image" : @"image0",
             @"large_image" : @"image1",
             @"middle_image" : @"image2",
             @"ID" :@"id",
             @"top_cmt" : @"top_cmt[0]"
             };
}

- (CGFloat)cellHeight
{
    if (!_cellHeight) {
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGSize maxSize = CGSizeMake(width - 2 * BSTopicCellMargin, MAXFLOAT);
        
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        _cellHeight = BSTopicCellTextY + textH +  BSTopicCellMargin;
        
        if (self.type == BSDuanziTypePhoto) {
            
            CGFloat middleW = maxSize.width;
            CGFloat middleX = BSTopicCellMargin;
            CGFloat middleY = _cellHeight;
            CGFloat middleH = middleW * self.height / self.width;
            if (self.height >= 700) {
                middleH = 250;
                self.big = YES;
            }
            _middleViewF = CGRectMake(middleX, middleY, middleW, middleH);
            
            _cellHeight += middleH + BSTopicCellMargin;
        } else if (self.type == BSDuanziTypeVoice) {
            CGFloat voiceX = BSTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = voiceW * self.height / self.width;
            CGFloat voiceY = BSTopicCellTextY + textH + BSTopicCellMargin;
            _voiceViewF = CGRectMake(voiceX,voiceY, voiceW, voiceH);
            _cellHeight += voiceH + BSTopicCellMargin;
            
        } else if (self.type == BSDuanziTypeVideo) {
            CGFloat videoX = BSTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            CGFloat videoY = BSTopicCellTextY + textH + BSTopicCellMargin;
            
            _videoViewF = CGRectMake(videoX, videoY, videoW, videoH);
            _cellHeight += videoH + BSTopicCellMargin;
        }
        
        BSTopicComment *cmt = self.top_cmt;
        if (cmt) {
            
            CGFloat cmtWidth = maxSize.width;
            NSString *content = [NSString stringWithFormat:@"%@ : %@",cmt.user.username,cmt.content];
            
            CGRect cmtSize = [content boundingRectWithSize:CGSizeMake(cmtWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]} context:nil];
            
            CGFloat textHeight = cmtSize.size.height;
            
            _cellHeight += cellCommentTitleHeight + textHeight + BSTopicCellMargin;
        }
        
        
        _cellHeight += BSTopicCellBottomBarHeight + 2 * BSTopicCellMargin;
    }
    return _cellHeight;  
}

@end
