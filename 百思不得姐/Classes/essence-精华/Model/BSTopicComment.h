//
//  BSTopicComment.h
//  百思不得姐
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BSUser.h"
@interface BSTopicComment : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, strong) BSUser *user;
@property (nonatomic, assign) NSInteger voicetime;
@property (nonatomic, assign) NSInteger like_count;
@property (nonatomic, copy) NSString *content;



@end
