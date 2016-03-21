//
//  BSCategory.m
//  百思不得姐
//
//  Created by mac on 16/3/9.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSCategory.h"
#import <MJExtension.h>

@implementation BSCategory
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
- (NSMutableArray *)users
{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
