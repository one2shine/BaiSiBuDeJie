//
//  BSRecommendViewController.m
//  百思不得姐
//
//  Created by mac on 16/3/9.
//  Copyright © 2016年 one2shine. All rights reserved.
//

#import "BSRecommendViewController.h"
#import "BSCategory.h"
#import "BSCategoryCell.h"
#import "FTRecommendUserCell.h"
#import "BSRecommendUser.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>

#import <SVProgressHUD.h>

#define selectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]
@interface BSRecommendViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
@property (nonatomic, strong) NSArray *categories;

@property (weak, nonatomic) IBOutlet UITableView *userTableVIew;

@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation BSRecommendViewController
static  NSString * const reuseId = @"category";
static  NSString * const userReuseId = @"user";
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupTableView];
    
    self.view.backgroundColor = BSRGBColor(245 , 245, 245);
    self.title = @"推荐关注";
    
    [self loadCategories];
}


- (void)setupTableView
{
    
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([BSCategoryCell class]) bundle:nil] forCellReuseIdentifier:reuseId];
    
    [self.userTableVIew registerNib:[UINib nibWithNibName:NSStringFromClass([FTRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:userReuseId];
    //view中有两个tableview，navigation造成的inset只会在一个tableview上显示，所以要重新设置
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableVIew.contentInset = self.categoryTableView.contentInset;
    self.userTableVIew.rowHeight = 66;

    self.userTableVIew.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
    self.userTableVIew.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
}

- (void)loadCategories
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    
    [SVProgressHUD showProgress:4.0 maskType:SVProgressHUDMaskTypeBlack];
    
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        self.categories = [BSCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.categoryTableView reloadData];
        
        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.categoryTableView selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone];
//        [self tableView:self.categoryTableView didSelectRowAtIndexPath:index];
        [self.userTableVIew.mj_header beginRefreshing];
        
        //        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"加载失败222"];
    }];


}
- (void)loadNewUsers
{
    BSCategory *category = selectedCategory;
    category.currentPage = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] =category.ID;
    params[@"page"] = @(category.currentPage);
    self.params = params;

    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        category.users = nil;
        [category.users addObjectsFromArray:[BSRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]]];
        
        category.total = [responseObject[@"total"] integerValue];
        
        if (params != self.params) return ;
        
        [self.userTableVIew reloadData];
        [self.userTableVIew.mj_header endRefreshing];
        
        [self checkFooterState];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return ;
        [SVProgressHUD showErrorWithStatus:@"加载失败111"];
        
        [self.userTableVIew.mj_header endRefreshing];
    }];
    
}
- (void)loadMoreUsers
{
    BSCategory *category = selectedCategory;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = category.ID;
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *array = [BSRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        [category.users addObjectsFromArray:array];
//        NSLog(@"%@----%ld",responseObject[@"total"],category.users.count);
        
        if (self.params != params) return ;
        [self.userTableVIew reloadData];
        
        [self checkFooterState];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.params != params) return ;
        
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
        [self.userTableVIew.mj_footer endRefreshing];
        
        
    }];
}
- (void)checkFooterState
{
    BSCategory *category = selectedCategory;
    self.userTableVIew.mj_footer.hidden = (category.users.count == 0);
    
    if (category.users.count == category.total) {
        [self.userTableVIew.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.userTableVIew.mj_footer endRefreshing];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) {
        
        return self.categories.count;
    } else {
        BSCategory *category = selectedCategory;
        
        [self checkFooterState];
        
        return category.users.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.categoryTableView) {
        
        BSCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else {
        
        FTRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:userReuseId];
        BSCategory *category = selectedCategory;
        
        cell.user = category.users[indexPath.row];
        return cell;
    }
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.userTableVIew.mj_header endRefreshing];
    [self.userTableVIew.mj_footer endRefreshing];
    
    BSCategory *category = self.categories[indexPath.row];
    
    if (category.users.count) {
        
        [self.userTableVIew reloadData];
        
    } else {
        
        [self.userTableVIew reloadData];
        
        [self.userTableVIew.mj_header beginRefreshing];
    }

}

- (void)dealloc
{
    [self.manager.operationQueue cancelAllOperations];
}
@end
