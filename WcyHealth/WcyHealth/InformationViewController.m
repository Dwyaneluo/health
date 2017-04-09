//
//  InformationViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/1/8.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "InformationViewController.h"
#import "InformationTableViewCell.h"

@interface InformationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    NSInteger *currentPage;
    NSMutableArray *listArr;
}
@end

@implementation InformationViewController
-(instancetype)init{
    self=[super init];
    if (self) {
        currentPage=1;
        listArr = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资讯";
    [self createView];
}
-(void)viewWillAppear:(BOOL)animated{
    [self refreshData];
}

-(void)createView {
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:table];
    table.delegate=self;
    table.dataSource=self;
    table.rowHeight=100;
    [table registerClass:[InformationTableViewCell class] forCellReuseIdentifier:@"cell"];
    MJRefreshNormalHeader *head = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshData)];
    [head setTitle:@"下拉刷新中。。。" forState:MJRefreshStateRefreshing];
    table.mj_header = head;
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"正在加载更多数据。。。"  forState:MJRefreshStateRefreshing];
    table.mj_footer = footer;
    table.tableFooterView =[UIView new];
    table.backgroundColor = UIColorFromHexValue(0xf4f4f4);
}
-(void)refreshData{
    [self getNetWork:1];
}
-(void)loadMoreData{
    currentPage++;
    [self getNetWork:currentPage];
}
//获取网络数据
-(void)getNetWork:(NSInteger *)page
{
    [table.mj_header endRefreshing];
    [table.mj_footer endRefreshing];
    [SVProgressHUD show];
    //创建请求管理器
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    
    NSString *url=[NSString stringWithFormat:@"http://www.tngou.net/api/info/list?page=%d",page];
    NSMutableDictionary *params=[NSMutableDictionary dictionary];

    //获取数据
    [manger GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        
        
        if (![responseObject[@"error"] boolValue]) {
            [SVProgressHUD dismiss];
            NSArray *tmp=responseObject[@"tngou"];
            if (page==1) {
                listArr = [listArr mutableCopy];
                [listArr removeAllObjects];
                listArr = [NSMutableArray arrayWithArray:tmp];
            }else{
                listArr = [listArr arrayByAddingObjectsFromArray:tmp];
            }
            [table reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showWithStatus:@"获取失败"];
        NSLog(@"数据获取失败，%@",error);
    }];
}

#pragma mark- tablview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  listArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * celLStr= @"cell";
    InformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celLStr];
    if (cell!=nil){
        cell = [[InformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celLStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    NSDictionary *dict = listArr[indexPath.row];
    cell.titleLb.text = [dict objectForKey:@"title"];
    cell.detailLb.text = [dict objectForKey:@"description"];
    [cell.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://tnfs.tngou.net/image%@_100x80",dict[@"img"]]] placeholderImage:nil];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
