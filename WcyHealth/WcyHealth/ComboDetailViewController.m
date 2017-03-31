//
//  ComboDetailViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/3/30.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "ComboDetailViewController.h"
#import "MBUtilities.h"
@interface ComboDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    UIImageView *imageV;
    UILabel *nameLb;
    UILabel *detailLb;
    UILabel *moneyLb;
    UILabel *oldPrice;
    UIButton *confirmBtn;//立即预约
    UIButton *callConsultBtn;//电话咨询
    UIButton *onlineConsultBtn;//在线咨询
}
@end

@implementation ComboDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"套餐详情";
    [self createView];
}

- (void)createView{
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    table.delegate=self;
    table.dataSource=self;
    table.tableFooterView = [UIView new];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    table.backgroundColor = UIColorFromHexValue(0xf4f4f4);
    [self.view addSubview:table];
    
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
    table.tableHeaderView = head;
    
    imageV = [UIImageView new];
    imageV.backgroundColor = [UIColor redColor];
    [head addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(head);
        make.height.mas_equalTo(@100);
    }];
    
    nameLb = [UILabel new];
    nameLb.text = @"入职体检套餐";
    nameLb.textColor = [UIColor blueColor];
    nameLb.font = [UIFont boldSystemFontOfSize:15];
    [head addSubview:nameLb];
    [nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(head.mas_left).offset(5);
        make.top.equalTo(imageV.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-10, 20));
    }];
    
    detailLb = [UILabel new];
    detailLb.text = @"简单基础的入职体检项目，让你了解自身的基本状况，价格适宜";
    detailLb.numberOfLines=0;
    detailLb.font = [UIFont systemFontOfSize:14];
    [head addSubview:detailLb];
    CGSize detailsize = [MBUtilities countString:detailLb.text size:CGSizeMake(ScreenWidth-10, MAXFLOAT) fontSize:14];
    [detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(head.mas_left).offset(5);
        make.top.equalTo(nameLb.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-10, detailsize.height+5));
    }];
    
    moneyLb = [UILabel new];
    moneyLb.text = @"¥99.00";
    moneyLb.textColor = [UIColor redColor];
    moneyLb.font = [UIFont boldSystemFontOfSize:16];
    [head addSubview:moneyLb];
    [moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(head.mas_left).offset(5);
        make.top.equalTo(detailLb.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    oldPrice = [UILabel new];
    oldPrice.text = @"原价:140";
    oldPrice.textColor = [UIColor redColor];
    oldPrice.font = [UIFont systemFontOfSize:14];
    [head addSubview:oldPrice];
    [oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyLb.mas_right).offset(10);
        make.top.equalTo(detailLb.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    confirmBtn = [UIButton new];
    [confirmBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.backgroundColor = [UIColor redColor];
    [head addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oldPrice.mas_bottom).with.offset(20);
        make.right.equalTo(head.mas_right).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    callConsultBtn = [UIButton new];
    [callConsultBtn setTitle:@"电话咨询" forState:UIControlStateNormal];
    [callConsultBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    callConsultBtn.layer.borderWidth = 1;
    callConsultBtn.layer.backgroundColor = [UIColor blueColor].CGColor;
    [callConsultBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [head addSubview:callConsultBtn];
    [callConsultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oldPrice.mas_bottom).with.offset(80);
        make.left.equalTo(head.mas_left).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    onlineConsultBtn = [UIButton new];
    [onlineConsultBtn setTitle:@"在线咨询" forState:UIControlStateNormal];
    [onlineConsultBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    onlineConsultBtn.layer.borderWidth = 1;
    onlineConsultBtn.layer.backgroundColor = [UIColor redColor].CGColor;
    [onlineConsultBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    [head addSubview:onlineConsultBtn];
    [onlineConsultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oldPrice.mas_bottom).with.offset(80);
        make.left.equalTo(head.mas_left).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
}
#pragma mark-  tablview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else if(section==1){
        return 4;
    }else if(section==2){
        return 3;
    }else if(section==3){
        return 2;
    }else{
        return 2;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellStr= @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell!=nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
