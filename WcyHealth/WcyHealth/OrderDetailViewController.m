//
//  OrderDetailViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/4/8.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "ResultsViewController.h"
#import "ComboDetailViewController.h"
@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    UILabel *date;
    UILabel *name;
    UILabel *IDCard;
    UILabel *phoneNum;
    UILabel *gender;
    UILabel *marry;
    UILabel *orderNum;
    UIButton *lookBtn;
}

@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    [self createView];
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
    table.rowHeight=100;
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    table.tableFooterView =[UIView new];
    
    
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 260)];
    head.backgroundColor = UIColorFromHexValue(0xf4f4f4);
    table.tableHeaderView = head;
    
    date = [UILabel new];
    date.text = [NSString stringWithFormat:@"预约体检时间:%@",self.orderInfo.ordertime];
    date.font = [UIFont boldSystemFontOfSize:15];
    [head addSubview:date];
    [date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(head.mas_top).with.offset(20);
        make.left.equalTo(head.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-30, 20));
    }];
    
    name = [UILabel new];
    name.text =[NSString stringWithFormat:@"体检人:    %@",self.orderInfo.name];
    name.font = [UIFont systemFontOfSize:16];
    [head addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(date.mas_bottom).with.offset(30);
        make.left.equalTo(head.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    IDCard = [UILabel new];
    IDCard.text = [NSString stringWithFormat:@"身份证:    %@",self.orderInfo.idcard];
    IDCard.font = [UIFont systemFontOfSize:16];
    [head addSubview:IDCard];
    [IDCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(name.mas_bottom).with.offset(5);
        make.left.equalTo(head.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-30, 20));
    }];
    
    phoneNum = [UILabel new];
    phoneNum.text = [NSString stringWithFormat:@"手机号:    %@",self.orderInfo.phone];
    phoneNum.font = [UIFont systemFontOfSize:16];
    [head addSubview:phoneNum];
    [phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(IDCard.mas_bottom).with.offset(5);
        make.left.equalTo(head.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-30, 20));
    }];
    
    gender = [UILabel new];
    gender.text = [NSString stringWithFormat:@"性别:    %@",self.orderInfo.gender];
    gender.font = [UIFont systemFontOfSize:16];
    [head addSubview:gender];
    [gender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneNum.mas_bottom).with.offset(5);
        make.left.equalTo(head.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    marry = [UILabel new];
    marry.text = [NSString stringWithFormat:@"婚否:     %@",self.orderInfo.married];
    marry.font = [UIFont systemFontOfSize:16];
    [head addSubview:marry];
    [marry mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gender.mas_bottom).with.offset(5);
        make.left.equalTo(head.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    orderNum = [UILabel new];
    orderNum.text = [NSString stringWithFormat:@"订单号:%@",self.orderInfo.ordernum];
    orderNum.font = [UIFont systemFontOfSize:16];
    [head addSubview:orderNum];
    [orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(marry.mas_bottom).with.offset(30);
        make.left.equalTo(head.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-30, 20));
    }];
    
//    lookBtn =[UIButton new];
//    [lookBtn setTitle:@"查看报告" forState:UIControlStateNormal];
//    [lookBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [lookBtn addTarget:self action:@selector(lookBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    lookBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    lookBtn.layer.borderWidth=1;
//    lookBtn.layer.borderColor = [UIColor blackColor].CGColor;
//    [head addSubview:lookBtn];
//    [lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(head.mas_top).with.offset(60);
//        make.right.equalTo(head.mas_right).with.offset(-10);
//        make.size.mas_equalTo(CGSizeMake(80, 30));
//    }];
}
#pragma mark - 
#pragma mark - 查看报告按钮事件
- (void)lookBtnClick{
    ResultsViewController *results = [ResultsViewController new];
    [self.navigationController pushViewController:results animated:YES];
}
#pragma mark - 返回按钮事件
- (void)backBtnClick{
    [self .navigationController popViewControllerAnimated:YES];
}
#pragma mark - 列表代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * celLStr= @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celLStr];
    if (cell!=nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celLStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *image = [UIImageView new];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",self.orderInfo.orderimage]];
        [cell addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.mas_top).with.offset(10);
            make.left.equalTo(cell.mas_left).with.offset(10);
            make.bottom.equalTo(cell.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(@(100));
        }];
        
        UILabel *title = [UILabel new];
        title.text = self.orderInfo.ordertitle;
        title.font = [UIFont boldSystemFontOfSize:15];
        [cell addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.mas_top).with.offset(5);
            make.left.equalTo(image.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(150, 20));
        }];
        
        UILabel *detail = [UILabel new];
        detail.text = self.orderInfo.orderdetail;
        detail.numberOfLines=3;
        detail.font = [UIFont boldSystemFontOfSize:14];
        [cell addSubview:detail];
        [detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title.mas_bottom).with.offset(5);
            make.left.equalTo(image.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(150, 60));
        }];
        
        UILabel *price = [UILabel new];
        price.text = [NSString stringWithFormat:@"¥%@",self.orderInfo.ordermoney];
        price.numberOfLines=3;
        price.font = [UIFont boldSystemFontOfSize:14];
        [cell addSubview:price];
        [price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(detail.mas_top);
            make.left.equalTo(detail.mas_right).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(80, 20));
        }];
        
        UIButton *refund =[UIButton new];
        [refund setTitle:@"取消" forState:UIControlStateNormal];
        [refund addTarget:self action:@selector(refundBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [refund setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        refund.titleLabel.font = [UIFont systemFontOfSize:13];
        refund.layer.borderWidth=1;
        refund.layer.borderColor = [UIColor blackColor].CGColor;
        [cell addSubview:refund];
        [refund mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(price.mas_bottom).with.offset(10);
            make.left.equalTo(price.mas_left);
            make.size.mas_equalTo(CGSizeMake(80, 20));
        }];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.orderInfo.ordertitle forKey:@"title"];
    [dict setValue:self.orderInfo.ordermoney forKey:@"newprice"];
    [dict setValue:self.orderInfo.orderoldmoney forKey:@"oldprice"];
    [dict setValue:self.orderInfo.ordersum forKey:@"sum"];
    [dict setValue:self.orderInfo.orderimage forKey:@"image"];
    [dict setValue:self.orderInfo.orderdetail forKey:@"detail"];
    
    ComboDetailViewController *combo = [ComboDetailViewController new];
    combo.infoDict = dict;
    [self.navigationController pushViewController:combo animated:YES];
}
#pragma mark -
#pragma mark - 退款按钮事件
- (void)refundBtnClick{
    if ([self.orderInfo.orderstate isEqualToString:@"已取消"]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"该订单已取消，不可重新取消" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"确定取消该订单？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"是的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([FMDBTool changeOrderForOrderID:self.orderInfo.ordernum state:@"已取消"]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"取消订单成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self backBtnClick];
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"取消订单失败，请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    UIAlertAction *cancel =  [UIAlertAction actionWithTitle:@"不用了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
