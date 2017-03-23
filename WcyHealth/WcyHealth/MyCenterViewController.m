//
//  MyCenterViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/1/8.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "MyCenterViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
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
        
        UILabel *title =[UILabel new];
        title.textColor = [UIColor blackColor];
        title.font = [UIFont systemFontOfSize:16];
        [cell addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.mas_left).with.offset(55);
            make.centerY.equalTo(cell.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(150, 20));
        }];
        
        UIImageView *image = [UIImageView new];
        image.backgroundColor = [UIColor blackColor];
        [cell addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_centerY);
            make.left.equalTo(cell.mas_left).with.offset(15);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        if (indexPath.section==0){
            if (indexPath.row==0) {
                image.layer.masksToBounds=true;
                image.layer.cornerRadius=40;
                [image mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(80, 80));
                }];
                title.text = @"点击登陆";
                [title mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(cell.mas_left).with.offset(105);
                }];
            }else if(indexPath.row==1){
                title.text = @"我的报告";
            }else if(indexPath.row==2){
                title.text = @"我的订单";
            }
        }else if(indexPath.section==1){
            if (indexPath.row==0) {
                title.text = @"帮助";
            }else if(indexPath.row==1){
                title.text = @"设置";
            }
        }else{
            title.text = @"检查更新";
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0){
        if (indexPath.row==0) {
            [self presentViewController:[LoginViewController new] animated:YES completion:nil];
        }else if(indexPath.row==1){
        }else if(indexPath.row==2){
        }
    }else if(indexPath.section==1){
        if (indexPath.row==0) {
        }else if(indexPath.row==1){
        }
    }else{
    }
}
@end
