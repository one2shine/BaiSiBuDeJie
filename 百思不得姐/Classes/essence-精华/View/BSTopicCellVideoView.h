//
//  BSTopicCellVideoView.h
//  百思不得姐
//
//  Created by mac on 16/3/15.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSTopic;
@interface BSTopicCellVideoView : UIView
@property (nonatomic, strong) BSTopic *topic;
+ (instancetype)videoView;

@end
