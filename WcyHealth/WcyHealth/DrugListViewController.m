//
//  DrugListViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/4/23.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "DrugListViewController.h"
#import "InformationTableViewCell.h"
#import "DrugDetailViewController.h"
@interface DrugListViewController ()
<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    NSMutableArray *listArr;
}

@end
static int  currentPage=1;
static int  totlePage=1;
@implementation DrugListViewController



-(instancetype)init{
    self=[super init];
    if (self) {
        listArr = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"药品列表";
    [self createView];
}
-(void)viewWillAppear:(BOOL)animated{
    [self refreshData];
}

-(void)createView {
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:table];
    table.delegate=self;
    table.dataSource=self;
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
- (void)backBtnClick{
    [self .navigationController popViewControllerAnimated:YES];
}
-(void)refreshData{
    currentPage=1;
    [self getNetWork:1];
}
-(void)loadMoreData{
    currentPage++;
    if (currentPage>totlePage) {
        [table.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    [self getNetWork:currentPage];
}
//获取网络数据
-(void)getNetWork:(int)page
{
    [table.mj_header endRefreshing];
    [table.mj_footer endRefreshing];
    [SVProgressHUD show];
    //创建请求管理器
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    NSString *url=[NSString stringWithFormat:@"http://www.tngou.net/api/drug/list?id=%@?page=%d",self.classId,currentPage];
    NSLog(@"%@",url);
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    
    
    [manger GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"responseObject:%@",responseObject);
        NSDictionary *tmp = responseObject;
        totlePage = [[responseObject objectForKey:@"total"] intValue];
        if (![responseObject[@"error"] boolValue]) {
            [SVProgressHUD dismiss];
            NSArray *tmp=responseObject[@"tngou"];
            //获取数据
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
        [SVProgressHUD showErrorWithStatus:@"获取失败"];
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
        
    }
    NSDictionary *dict = listArr[indexPath.row];
    NSLog(@"%@",[dict objectForKey:@"infoclass"]);
    cell.titleLb.text = [dict objectForKey:@"name"];
    cell.detailLb.text = [dict objectForKey:@"description"];
    [cell countCellHeight:dict];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = listArr[indexPath.row];
    NSString *str = [dict objectForKey:@"description"];
    CGSize size = [MBUtilities countString:str size:CGSizeMake(ScreenWidth-130, MAXFLOAT) fontSize:13];
    return 80+size.height+5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = listArr[indexPath.row];
    DrugDetailViewController *detail = [DrugDetailViewController new];
    //创建请求管理器
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    NSString *url=[NSString stringWithFormat:@"http://www.tngou.net/api/drug/show?id=%@",[dict objectForKey:@"id"]];
    NSLog(@"%@",url);
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    
    
    [manger GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        
        
        if (![responseObject[@"error"] boolValue]) {
            
            
            //获取数据
            detail.titleStr = [responseObject objectForKey:@"name"];
            detail.urlStr = [responseObject objectForKey:@"url"];
            [self.navigationController pushViewController:detail animated:YES];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showWithStatus:@"获取失败"];
        NSLog(@"数据获取失败，%@",error);
    }];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
