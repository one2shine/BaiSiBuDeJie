//
//  BSDuanziController.m
//  百思不得姐
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSDuanziController.h"
#import "BSTopic.h"
#import "BSTopicCell.h"
#import "BSTopicCommentController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <MJRefresh.h>
#import <UIImageView+WebCache.h>
@interface BSDuanziController ()
@property (nonatomic, strong) NSMutableArray *topics;
@property (nonatomic, copy) NSString *maxtime;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) UIImageView *bigImageView;
@end

@implementation BSDuanziController

static NSString * const reuseID = @"topic";

- (UIImageView *)bigImageView
{
    if (!_bigImageView) {
        _bigImageView = [[UIImageView alloc] init];
    }
    return _bigImageView;
}
- (NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self settupTableView];
    
}
- (void)settupTableView
{
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = BSTitlesViewH + BSTitlesViewY;
    self.tableView.scrollsToTop = YES;
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(top, 0, 0, 0);
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.backgroundColor = [UIColor clearColor];
    [self setupRefresh];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSTopicCell class]) bundle:nil] forCellReuseIdentifier:reuseID];
}
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}
/**
 *  上拉加载更多
 */
- (void)loadMoreTopics
{
    self.page++;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (!(self.params == params)) return ;
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *moreTopics = [BSTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:moreTopics];
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [self.tableView.mj_footer endRefreshing];
        self.page--;
    }];
}
- (void)loadNewTopics
{

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (!(self.params == params)) return ;
        

        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        self.topics = [BSTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)topicCellMiddleViewSeeBigPictureBtnClickedWithTopic:(BSTopic *)topic
{
    NSLog(@"%s",__func__);
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.bigImageView.x = self.bigImageView.y = 0;
    self.bigImageView.width = topic.width;
    self.bigImageView.height = topic.height;
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    [window addSubview:self.bigImageView];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    cell.topic = self.topics[indexPath.row];
   
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSTopic *topic = self.topics[indexPath.row];
    
    return topic.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSTopic *topic = self.topics[indexPath.row];
    BSTopicCommentController *topicCmt = [[BSTopicCommentController alloc] init];
    topicCmt.topic = topic;
    [self.navigationController pushViewController:topicCmt animated:YES];
    
    
}

@end
