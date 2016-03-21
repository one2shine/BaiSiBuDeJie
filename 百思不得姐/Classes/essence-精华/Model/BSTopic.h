//
//  BSTopic.h
//  百思不得姐
//
//  Created by mac on 16/3/12.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BSTopicComment;
@interface BSTopic : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *profile_image;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) NSInteger ding;
@property (nonatomic, assign) NSInteger cai;
@property (nonatomic, assign) NSInteger comment;
@property (nonatomic, assign) NSInteger repost;

@property (nonatomic, assign) BSDuanziType type;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy) NSString *small_image;
@property (nonatomic, copy) NSString *large_image;
@property (nonatomic, copy) NSString *middle_image;

/**
 *  存放的是最热评论模型
 */
@property (nonatomic, strong) BSTopicComment *top_cmt;

/**
 *  音乐类
 */
@property (nonatomic, copy) NSString *voiceurl;
@property (nonatomic, assign) NSInteger playcount;
@property (nonatomic, assign) NSInteger voicetime;
/**
 *  视频类
 */
@property (nonatomic, copy) NSString *videourl;
@property (nonatomic, assign) NSInteger videotime;

/**
 *  辅助属性
 */
@property (nonatomic, assign,readonly) CGFloat cellHeight;
@property (nonatomic, assign,readonly) CGRect middleViewF;
@property (nonatomic, assign, readonly) CGRect voiceViewF;
@property (nonatomic, assign, readonly) CGRect videoViewF;
@property (nonatomic, assign) CGFloat progress;

@property (nonatomic, assign, getter=isBig) BOOL big;

@end

