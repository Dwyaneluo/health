//
//  MakeAppointmentViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/4/6.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "MakeAppointmentViewController.h"

@interface MakeAppointmentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    UILabel *orderNameLb;
    UITextField * nameTld;
    UITextField *dateTld;
    UITextField *phoneNumTld;
    UITextField *IdCardTld;
    UILabel *priceLb;
    UIButton *submitBtn;
    
    UIButton *personBtn;
    UIButton *dateBtn;
    
    UIButton *manBtn;
    UIButton *WomanBtn;
    UIButton *marriedBtn;
    UIButton *unmarriedBtn;
}
@end

@implementation MakeAppointmentViewController
-(instancetype)init{
    self= [super init];
    if (self) {
        orderNameLb = [UILabel new];
        nameTld = [UITextField new];
        dateTld = [UITextField new];
        phoneNumTld = [UITextField new];
        IdCardTld = [UITextField new];
        
        personBtn = [UIButton new];
        dateBtn = [UIButton new];
        
        manBtn = [UIButton new];
        WomanBtn = [UIButton new];
        marriedBtn = [UIButton new];
        unmarriedBtn = [UIButton new];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"订单填写";
    [self createView];
}

- (void)createView{
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-50)];
    table.delegate=self;
    table.dataSource=self;
    table.tableFooterView = [UIView new];
    table.rowHeight=50;
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    table.backgroundColor = UIColorFromHexValue(0xf4f4f4);
    [self.view addSubview:table];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 50)];
    bottomView.backgroundColor = UIColorFromHexValue(0xf4f4f4);
    [self.view addSubview:bottomView];

    priceLb = [UILabel new];
    priceLb.font = [UIFont boldSystemFontOfSize:15];
    priceLb.textAlignment = NSTextAlignmentCenter;
    priceLb.text = @"在线实付:¥99.00";
    [bottomView addSubview:priceLb];
    [priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.left.equalTo(bottomView.mas_left);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/2, 20));
    }];
    
    submitBtn = [UIButton new];
    submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    [submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.backgroundColor = UIColorFromHexValue(0x169BD5);
    [bottomView addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(bottomView);
        make.width.mas_equalTo(@(ScreenWidth/2));
    }];
    
}
- (void)backBtnClick{
    [self .navigationController popViewControllerAnimated:YES];
}
#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellStr= @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell!=nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.row==0) {
            UILabel *title = [UILabel new];
            title.font = [UIFont boldSystemFontOfSize:15];
            [cell addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(cell.mas_left).with.offset(10);
                make.size.mas_equalTo(CGSizeMake(150, 20));
            }];
            title.text = @"套餐名称";
            
            orderNameLb.text = @"入职体检套餐";
            orderNameLb.textAlignment = NSTextAlignmentRight;
            orderNameLb.font = [UIFont systemFontOfSize:15];
            [cell addSubview:orderNameLb];
            [orderNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.right.equalTo(cell.mas_right).with.offset(-15);
                make.size.mas_equalTo(CGSizeMake(200, 20));
            }];
        }else if(indexPath.row==1){
            nameTld.borderStyle = UITextBorderStyleRoundedRect;
            nameTld.placeholder = @"请输入体检人姓名";
            [nameTld setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
            [cell addSubview:nameTld];
            [nameTld mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(cell.mas_left).with.offset(10);
                make.size.mas_equalTo(CGSizeMake(200, 30));
            }];
            
            personBtn.backgroundColor = [UIColor blackColor];
            [cell addSubview:personBtn];
            [personBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.right.equalTo(cell.mas_right).with.offset(-10);
                make.size.mas_equalTo(CGSizeMake(40, 40));
            }];
            
        }else if(indexPath.row==2){
            dateTld.borderStyle = UITextBorderStyleRoundedRect;
            dateTld.placeholder = @"请输入体检日期";
            [dateTld setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
            [cell addSubview:dateTld];
            [dateTld mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(cell.mas_left).with.offset(10);
                make.size.mas_equalTo(CGSizeMake(200, 30));
            }];
            
            dateBtn.backgroundColor = [UIColor blackColor];
            [cell addSubview:dateBtn];
            [dateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.right.equalTo(cell.mas_right).with.offset(-10);
                make.size.mas_equalTo(CGSizeMake(40, 40));
            }];
        }else if(indexPath.row==3){
            phoneNumTld.borderStyle = UITextBorderStyleRoundedRect;
            phoneNumTld.placeholder = @"请输入体检人手机";
            [phoneNumTld setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
            [cell addSubview:phoneNumTld];
            [phoneNumTld mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(cell.mas_left).with.offset(10);
                make.size.mas_equalTo(CGSizeMake(200, 30));
            }];
        }else if(indexPath.row==4){
            IdCardTld.borderStyle = UITextBorderStyleRoundedRect;
            IdCardTld.placeholder = @"请输入体检人身份证";
            [IdCardTld setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
            [cell addSubview:IdCardTld];
            [IdCardTld mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(cell.mas_left).with.offset(10);
                make.size.mas_equalTo(CGSizeMake(200, 30));
            }];
        }else if(indexPath.row==5){
            UILabel *title = [UILabel new];
            title.font = [UIFont boldSystemFontOfSize:15];
            [cell addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(cell.mas_left).with.offset(10);
                make.size.mas_equalTo(CGSizeMake(60, 20));
            }];
            title.text = @"性别";
            
            [manBtn setTitle:@"男" forState:UIControlStateNormal];
            manBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            [manBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [manBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
            manBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 40);
            //button标题的偏移量，这个偏移量是相对于图片的
            manBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            [cell addSubview:manBtn];
            [manBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(cell.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(80, 40));
            }];
            
            [WomanBtn setTitle:@"女" forState:UIControlStateNormal];
            [WomanBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            WomanBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            [WomanBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
            WomanBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 40);
            //button标题的偏移量，这个偏移量是相对于图片的
            WomanBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            [cell addSubview:WomanBtn];
            [WomanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(manBtn.mas_right);
                make.size.mas_equalTo(CGSizeMake(80, 40));
            }];
        }else if(indexPath.row==6){
            UILabel *title = [UILabel new];
            title.font = [UIFont boldSystemFontOfSize:15];
            [cell addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(cell.mas_left).with.offset(10);
                make.size.mas_equalTo(CGSizeMake(60, 20));
            }];
            title.text = @"婚否";
            
            [marriedBtn setTitle:@"未婚" forState:UIControlStateNormal];
            marriedBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            [marriedBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
            [marriedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            marriedBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 40);
            //button标题的偏移量，这个偏移量是相对于图片的
            marriedBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            [cell addSubview:marriedBtn];
            [marriedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(cell.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(80, 40));
            }];
            
            [unmarriedBtn setTitle:@"已婚" forState:UIControlStateNormal];
            unmarriedBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            [unmarriedBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
            [unmarriedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            unmarriedBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 40);
            //button标题的偏移量，这个偏移量是相对于图片的
            unmarriedBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
            [cell addSubview:unmarriedBtn];
            [unmarriedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(marriedBtn.mas_right);
                make.size.mas_equalTo(CGSizeMake(80, 40));
            }];
        }

    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
