//
//  BSTopicCommentController.m
//  百思不得姐
//
//  Created by mac on 16/3/17.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSTopicCommentController.h"
#import "BSTopicCell.h"
#import "BSTopic.h"
#import "BSTopicComment.h"
#import "BSUser.h"
#import "BSCommentCell.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface BSTopicCommentController()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarBottomConstraint;

@property (nonatomic, strong) NSArray *hotCmts;
@property (nonatomic, strong) NSMutableArray *lastCmts;

@property (nonatomic, strong) BSTopicComment *saved_tom_cmt;

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@property (nonatomic, assign) NSInteger totalCount;
@end


@implementation BSTopicCommentController
static NSString * const reuseID = @"comment";
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}
- (NSMutableArray *)lastCmts
{
    if (!_lastCmts) {
        _lastCmts = [NSMutableArray array];
    }
    return _lastCmts;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = BSGlobalColor;
    
    [self setupTableViewHeaderView];
    
    [self setupRefresh];
    
    [self setupBasic];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BSCommentCell" bundle:nil] forCellReuseIdentifier:reuseID];
    
    
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
//    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 54, 0);
}

- (void)setupTableViewHeaderView
{
    self.saved_tom_cmt = self.topic.top_cmt;
    if (self.saved_tom_cmt) {
        
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    
    BSTopicCell *cell = [BSTopicCell topicCell];
    cell.topic = self.topic;
    cell.height = self.topic.cellHeight;
    self.tableView.tableHeaderView = cell;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
- (void)setupRefresh
{
    // 继承下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    [self.tableView.mj_header beginRefreshing];
    
    // 上拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    
    self.tableView.mj_footer.hidden = YES;
    
}
- (void)loadMoreComments
{
    [self.manager.dataTasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"datalist";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    BSTopicComment *cmt = [self.lastCmts lastObject];
    params[@"lastcid"] = cmt.ID;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@----%ld",responseObject[@"total"],self.totalCount);
        NSArray *cmts = [BSTopicComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.lastCmts addObjectsFromArray:cmts];
        
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        if (self.lastCmts.count >= self.totalCount) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [self.tableView.mj_footer endRefreshing];
    }];
}
- (void)setupBasic
{
    
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highlightImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.saved_tom_cmt) {
        self.topic.top_cmt = self.saved_tom_cmt;
        [self.topic setValue:@0 forKeyPath:@"cellHeight"];
    }
    //控制器销毁时，销毁session，并且取消所有任务
    [self.manager invalidateSessionCancelingTasks:YES];
}
- (void)keyboardWillChangeFrame:(NSNotification *)noti
{
    CGRect frame = [noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGFloat offset = BSScreenHeight - frame.origin.y;
    [UIView animateWithDuration:duration animations:^{
        
        self.toolbarBottomConstraint.constant = offset;
    }];
}
- (void)loadNewComments
{
    [self.manager.dataTasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"datalist";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.totalCount = [responseObject[@"total"] intValue];
        self.hotCmts = [BSTopicComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.lastCmts = [BSTopicComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        [self.tableView.mj_header endRefreshing];
        self.tableView.dataSource = self;
        [self.tableView reloadData];
        
        if (self.lastCmts.count >= self.totalCount) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [self.tableView.mj_header endRefreshing];
    }];
    
}
#pragma mark - tableview delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    self.tableView.mj_footer.hidden = (self.lastCmts.count == 0);
    NSLog(@"%d",self.tableView.mj_footer.isHidden);
    if (self.hotCmts.count) {
        return 2;
    } else {
    
        return 1;
    }
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.hotCmts.count) {
        
        return (section == 0) ?@"最热评论":@"最新评论";
    }

    return @"最新评论";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self commentsInSection:section].count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BSCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    
    cell.comment = [self commentInIndexPath:indexPath withSection:indexPath.section];
    return cell;
}

- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotCmts.count?self.hotCmts:self.lastCmts;
    }
    return self.lastCmts;
}
- (BSTopicComment *)commentInIndexPath:(NSIndexPath *)indexPath withSection:(NSInteger)section
{
    return [self commentsInSection:section][indexPath.row];
}

@end
