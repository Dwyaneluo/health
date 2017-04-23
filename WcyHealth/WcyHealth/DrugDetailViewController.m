//
//  DrugDetailViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/4/23.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "DrugDetailViewController.h"

@interface DrugDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    NSDictionary *infoDict;
}
@end

@implementation DrugDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
- (void)backBtnClick{
    [self .navigationController popViewControllerAnimated:YES];
}
-(void)refreshData{
    [self getNetWork];
}
-(void)getNetWork
{
    [SVProgressHUD show];
    //创建请求管理器
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    NSString *url=[NSString stringWithFormat:@"http://www.tngou.net/api/drug/show?id=%@",self.idStr];
    NSLog(@"%@",url);
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    
    
    [manger GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"responseObject:%@",responseObject);
        
        if (![responseObject[@"error"] boolValue]) {
            [SVProgressHUD dismiss];
            infoDict = responseObject;
            
            //获取数据
            [table reloadData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"获取失败"];
        NSLog(@"数据获取失败，%@",error);
    }];
}

#pragma mark- tablview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * celLStr= @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celLStr];
    if (cell!=nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celLStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.numberOfLines=0;
        cell.textLabel.textColor = [UIColor blackColor];
        
    }
    cell.textLabel.text = [infoDict objectForKey:@"message"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *str = [infoDict objectForKey:@"message"];
    CGSize size = [MBUtilities countString:str size:CGSizeMake(ScreenWidth-130, MAXFLOAT) fontSize:13];
    return size.height+10;
}



@end
