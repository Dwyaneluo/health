//
//  DrugViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/4/23.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "DrugViewController.h"
#import "DrugListViewController.h"
@interface DrugViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    NSArray *listArr;
}

@end

@implementation DrugViewController


-(instancetype)init{
    self=[super init];
    if (self) {
        listArr = [NSArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"药品信息";
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
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    table.tableFooterView =[UIView new];
    table.backgroundColor = UIColorFromHexValue(0xf4f4f4);
}
-(void)refreshData{
    [self getNetWork];
}
- (void)backBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
//获取网络数据
-(void)getNetWork
{
    [SVProgressHUD show];
    //创建请求管理器
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    
    NSString *url=@"http://www.tngou.net/api/drug/classify";
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    
    [manger GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        
        
        if (![responseObject[@"error"] boolValue]) {
            [SVProgressHUD dismiss];
            NSArray *tmp=responseObject[@"tngou"];
            //获取数据
            listArr = [NSArray arrayWithArray:tmp];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celLStr];
    if (cell!=nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:celLStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    NSDictionary *dict = listArr[indexPath.row];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    cell.textLabel.text = [dict objectForKey:@"title"];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    cell.detailTextLabel.numberOfLines=0;
    cell.detailTextLabel.text = [dict objectForKey:@"description"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        NSDictionary *dict = listArr[indexPath.row];
        DrugListViewController *list = [DrugListViewController new];
        list.classId = [dict objectForKey:@"id"];
        [self.navigationController pushViewController:list animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
