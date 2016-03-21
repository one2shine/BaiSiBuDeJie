//
//  BSRecommendTagCell.h
//  百思不得姐
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BSRecommendTag;
@interface BSRecommendTagCell : UITableViewCell
@property (nonatomic, strong) BSRecommendTag *recommendTag;

+ (instancetype)cell;
@end
