//
//  BSCategory.h
//  百思不得姐
//
//  Created by mac on 16/3/9.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BSCategory : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger count;

@property (nonatomic, strong) NSMutableArray *users;

@property (nonatomic, assign) NSInteger total;

@property (nonatomic, assign) NSInteger currentPage;

@end
