//
//  BSJinghuaViewController.m
//  百思不得姐
//
//  Created by mac on 16/3/8.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSJinghuaViewController.h"
#import "BSRecommendTagController.h"
#import "BSDuanziController.h"


@interface BSJinghuaViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIView *indicator;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, weak) UIView *titlesView;
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation BSJinghuaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = BSGlobalColor;
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightImage:@"MainTagSubIconClick" target:self action:@selector(subIconClicked)];
    
    [self setupChildVcs];
    
    [self setupTitlesView];
    
    [self setupContentView];
}
- (void)setupChildVcs
{
    BSDuanziController *totalVC = [[BSDuanziController alloc] init];
    totalVC.type = BSDuanziTypeAll;
    [self addChildViewController:totalVC];
    
    BSDuanziController *videoVC = [[BSDuanziController alloc] init];
    videoVC.type = BSDuanziTypeVideo;
    [self addChildViewController:videoVC];
    
    BSDuanziController *photoVC = [[BSDuanziController alloc] init];
    photoVC.type = BSDuanziTypePhoto;
    [self addChildViewController:photoVC];
    
    BSDuanziController *voiceVC = [[BSDuanziController alloc] init];
    voiceVC.type = BSDuanziTypeVoice;
    [self addChildViewController:voiceVC];
    
    BSDuanziController *duanziVC = [[BSDuanziController alloc] init];
    duanziVC.type = BSDuanziTypeTopic;
    [self addChildViewController:duanziVC];

}
- (void)setupContentView
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.scrollsToTop = NO;
    
    contentView.frame = self.view.bounds;
//    contentView.backgroundColor = BSRandomColor;
    
    contentView.contentSize = CGSizeMake(self.view.width * self.childViewControllers.count, 0);
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    self.contentView = contentView;
    
    [self scrollViewDidEndDecelerating:self.contentView];

}
- (void)setupTitlesView
{
    
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.65];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    

    
    UIView *indicator = [[UIView alloc] init];
    indicator.backgroundColor = [UIColor redColor];
    indicator.height = 2;
    indicator.y = titlesView.height - indicator.height;
    self.indicator = indicator;
    
    
    NSArray *titles = @[@"全部",@"视频",@"图片",@"声音",@"段子"];
    CGFloat btnWidth = titlesView.width / titles.count;
    CGFloat btnH = titlesView.height;

    for (NSInteger i = 0; i<titles.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.tag = i;
        btn.x = i * btnWidth;

        btn.width = btnWidth;
        btn.height = btnH;

        
        
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(titleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:btn];
        if (i == 0) {
            btn.enabled = NO;
            self.selectBtn = btn;
            
            [btn.titleLabel sizeToFit];
            self.indicator.centerX = btn.titleLabel.centerX;
            self.indicator.width = btn.titleLabel.width;
        }
    }
    
    [titlesView addSubview:indicator];
}

- (void)titleBtnClicked:(UIButton *)button
{
    
    self.selectBtn.enabled = YES;
    button.enabled = NO;
    self.selectBtn = button;
    NSInteger index = button.tag;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indicator.centerX = button.centerX;
        self.indicator.width = button.titleLabel.width;
    }];

    [self.contentView setContentOffset:CGPointMake(index *self.view.width, 0) animated:YES];
}
- (void)subIconClicked
{
    BSRecommendTagController *tagVC = [[BSRecommendTagController alloc] init];
    [self.navigationController pushViewController:tagVC animated:YES];
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / self.view.width;
    UITableViewController *vc = self.childViewControllers[index];
    //    vc.view.y = 0;
    vc.view.frame = self.view.bounds;
    
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    CGFloat bottom = CGRectGetHeight(self.tabBarController.tabBar.frame);
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    vc.view.x = scrollView.contentOffset.x;
    [self.contentView addSubview:vc.view];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
   
     NSInteger index = scrollView.contentOffset.x / self.view.width;
    [self titleBtnClicked:self.titlesView.subviews[index]];
    
    
    
    
}

@end
