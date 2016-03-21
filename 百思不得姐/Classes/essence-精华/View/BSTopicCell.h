//
//  BSTopicCell.h
//  百思不得姐
//
//  Created by mac on 16/3/12.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTopicCellMiddleView.h"
@class BSTopic;

@interface BSTopicCell : UITableViewCell
@property (nonatomic, strong) BSTopic *topic;
+ (instancetype)topicCell;
@end
