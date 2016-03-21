//
//  BSUser.h
//  百思不得姐
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSUser : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *profile_image;
@property (nonatomic, assign) NSInteger is_vip;

@end
