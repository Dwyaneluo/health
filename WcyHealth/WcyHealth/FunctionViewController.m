//
//  FunctionViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/1/8.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "FunctionViewController.h"
#import "AllOrderTableViewCell.h"
#import "OrderDetailViewController.h"
#import "LoginViewController.h"
#import "ComboDetailViewController.h"
@interface FunctionViewController ()<UITableViewDelegate,UITableViewDataSource,cellBtnClickDelegate>
{
    UITableView *table;
    NSArray *dataArr;//订单数组
}
@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
}
- (void)createView{
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    table.delegate=self;
    table.dataSource=self;
    table.tableFooterView = [UIView new];
    [table registerClass:[AllOrderTableViewCell class] forCellReuseIdentifier:@"cell"];
    table.backgroundColor = UIColorFromHexValue(0xf4f4f4);
    table.rowHeight = 100;
    [self.view addSubview:table];
}
-(void)viewWillAppear:(BOOL)animated{
    if (IS_LOGIN!=YES) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"还未登录账号" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self presentViewController:[LoginViewController new] animated:YES completion:nil];
        }];
        UIAlertAction *cancel =  [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            self.tabBarController.selectedIndex = 0;
        }];
        [alert addAction:action];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    dataArr = [FMDBTool getAllOrder];
    [table reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-  tablview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellStr= @"cell";
    AllOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell!=nil) {
        cell = [[AllOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
    }
    OrderInfo *info = [dataArr objectAtIndex:indexPath.row];
    [cell setValueToCell:info];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailViewController* order = [OrderDetailViewController new];
    OrderInfo *info = [dataArr objectAtIndex:indexPath.row];
    order.orderInfo=info;
    order.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:order animated:YES];
}
#pragma mark-
#pragma mark- 重新购买&再次购买按钮事件
-(void)cellBtnclick:(OrderInfo*)info{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setValue:info.ordertitle forKey:@"title"];
    [dict setValue:info.ordermoney forKey:@"newprice"];
    [dict setValue:info.orderoldmoney forKey:@"oldprice"];
    [dict setValue:info.ordersum forKey:@"sum"];
    [dict setValue:info.orderimage forKey:@"image"];
    [dict setValue:info.orderdetail forKey:@"detail"];
    
    ComboDetailViewController *combo = [ComboDetailViewController new];
    combo.infoDict = dict;
    [self.navigationController pushViewController:combo animated:YES];
}
@end
