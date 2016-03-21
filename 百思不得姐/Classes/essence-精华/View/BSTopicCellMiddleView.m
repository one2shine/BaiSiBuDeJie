//
//  BSTopicCellMiddleView.m
//  百思不得姐
//
//  Created by mac on 16/3/13.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSTopicCellMiddleView.h"
#import "BSTopic.h"
#import <UIImageView+WebCache.h>
#import "BSShowBigPictureController.h"
#import <M13ProgressViewRing.h>

@interface BSTopicCellMiddleView()
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
@property (weak, nonatomic) IBOutlet UIButton *seeBigBtn;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet M13ProgressView *progressView;
- (IBAction)seeBigPicture:(id)sender;


@end

@implementation BSTopicCellMiddleView
+ (instancetype)middleView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([BSTopicCellMiddleView class]) owner:nil options:nil] lastObject];
}
- (void)awakeFromNib
{
    self.autoresizingMask = NO;
    self.photoView.clipsToBounds = YES;
}

- (void)setTopic:(BSTopic *)topic
{
    _topic = topic;
    
    [self.progressView setProgress:topic.progress animated:YES];
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        topic.progress = progress;
        [self.progressView setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.progressView.hidden = YES;
        if (topic.isBig == NO) return ;
        
        UIGraphicsBeginImageContextWithOptions(self.size, 0, 1.0);
        
        CGFloat width = self.width;
        CGFloat height = width / image.size.width * image.size.height;
        
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        
        self.photoView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        self.progressView.hidden = YES;
    }];
    
    [self.photoView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(seeBigPicture:)]];
    
    NSString *extension = topic.large_image.pathExtension;
   
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    if (topic.isBig) {
        self.seeBigBtn.hidden = NO;
        self.photoView.contentMode = UIViewContentModeScaleAspectFill;
    } else {
        self.seeBigBtn.hidden = YES;
        self.photoView.contentMode = UIViewContentModeScaleToFill;
    }
    
}

- (IBAction)seeBigPicture:(id)sender {
    BSShowBigPictureController *showBigPicture = [[BSShowBigPictureController alloc] init];
    showBigPicture.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    showBigPicture.topic= self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showBigPicture animated:YES completion:nil];
    
}
@end
