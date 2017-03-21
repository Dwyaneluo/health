//
//  MyCenterViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/1/8.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "MyCenterViewController.h"

@interface MyCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
}
@end

@implementation MyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self createView];
}
-(void)createView {
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:table];
    table.delegate=self;
    table.dataSource=self;
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    table.tableFooterView =[UIView new];
    table.backgroundColor = UIColorFromHexValue(0xf4f4f4);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark- tablview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }else if (section==1){
        return 2;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section!=0){
        return 10;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        return 100;
    }
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * celLStr= @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celLStr];
    if (cell!=nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celLStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.section==0){
            if (indexPath.row==0) {
                cell.textLabel.text = @"点击登陆";
            }else if(indexPath.row==1){
                cell.textLabel.text = @"我的报告";
            }else if(indexPath.row==2){
                cell.textLabel.text = @"我的订单";
            }
        }else if(indexPath.section==1){
            if (indexPath.row==0) {
                cell.textLabel.text = @"帮助";
            }else if(indexPath.row==1){
                cell.textLabel.text = @"设置";
            }
        }else{
            cell.textLabel.text = @"检查更新";
        }
    }
    return cell;
}
@end
