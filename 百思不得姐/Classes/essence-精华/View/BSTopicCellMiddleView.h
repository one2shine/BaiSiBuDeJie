//
//  BSTopicCellMiddleView.h
//  百思不得姐
//
//  Created by mac on 16/3/13.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BSTopic, BSTopicCellMiddleView;



@interface BSTopicCellMiddleView : UIView

@property (nonatomic,strong) BSTopic *topic;
+ (instancetype)middleView;

@end
