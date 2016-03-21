//
//  BSRecommendUser.h
//  百思不得姐
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSRecommendUser : NSObject

@property (nonatomic, copy) NSString *uid;

@property (nonatomic, copy) NSString *fans_count;

@property (nonatomic, assign) NSInteger is_follow;

@property (nonatomic, copy) NSString *screen_name;

@property (nonatomic, copy) NSString *header;

@end
