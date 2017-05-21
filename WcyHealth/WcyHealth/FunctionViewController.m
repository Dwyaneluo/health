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
#import "BookingViewController.h"
@interface FunctionViewController ()<UITableViewDelegate,UITableViewDataSource,cellBtnClickDelegate>
{
    UITableView *table;
    NSMutableArray *dataArr;//订单数组
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
    dataArr = [NSMutableArray arrayWithArray:[FMDBTool getAllOrder]];
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
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
//点击删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    //在这里实现删除操作
    OrderInfo *info = [dataArr objectAtIndex:indexPath.row];
    if ([FMDBTool deleteOrderForOrdernum:info.ordernum]) {
        //删除数据，和删除动画
        [dataArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"删除订单失败！请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    

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
    
    BookingViewController *book = [BookingViewController new];
    
    [self.navigationController pushViewController:book animated:YES];
}
@end
