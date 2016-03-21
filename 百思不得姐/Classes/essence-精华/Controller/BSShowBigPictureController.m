//
//  BSShowBigPictureController.m
//  百思不得姐
//
//  Created by mac on 16/3/13.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSShowBigPictureController.h"
#import "BSTopic.h"
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>
#import <M13ProgressViewRing.h>

@interface BSShowBigPictureController ()

- (IBAction)dismissSeeBigController:(id)sender;
@property (weak, nonatomic) IBOutlet M13ProgressViewRing *progressView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) UIImageView *imageView;


@end

@implementation BSShowBigPictureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    [self.progressView setProgress:self.topic.progress animated:YES];
    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.frame = self.scrollView.bounds;
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSeeBigController:)]];
    CGFloat imageW = screenW;
    CGFloat imageH = imageW * self.topic.height / self.topic.width;
    self.imageView = imageView;
    [self.scrollView addSubview:imageView];
    
    if (imageH > screenH) {
        
        imageView.frame = CGRectMake(0, 0, imageW, imageH);
        self.scrollView.contentSize = CGSizeMake(0, imageH);
        
    } else {
        
        imageView.size = CGSizeMake(imageW, imageH);
        self.imageView.centerY = 0.5 * screenH;
    }
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        self.topic.progress = progress;
        [self.progressView setProgress:progress animated:YES];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
    }];
}
- (IBAction)savePhoto:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}
- (IBAction)dismissSeeBigController:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
