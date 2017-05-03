//
//  MakeAppointmentViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/4/6.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "MakeAppointmentViewController.h"
#import "PersonInfoViewController.h"
#import "FMDBTool.h"
@interface MakeAppointmentViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    UILabel *orderNameLb;//套餐名称
    UITextField * nameTld;//姓名
    UITextField *dateTld;//体检日期
    UITextField *phoneNumTld;//电话号码
    UITextField *IdCardTld;//身份证
    UILabel *priceLb;//套餐价格
    UIButton *submitBtn;//提交订单
    
    UIButton *personBtn;//填入个人信息
    UIButton *dateBtn;//选择体检日期
    //男，女
    UIButton *manBtn;
    UIButton *WomanBtn;
    NSString *genderStr;
    //是否结婚
    UIButton *marriedBtn;
    UIButton *unmarriedBtn;
    NSString *marriedStr;
}
@property (nonatomic ,strong)UIDatePicker *datePiker;
@property (nonatomic ,assign)BOOL dateisOn;
@property (nonatomic ,strong)UIView *dateToolBar;
@property (nonatomic ,strong)NSString *loctime;
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
    [self setUpDatePiker];
}

- (void)createView{
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
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
    priceLb.text = [NSString stringWithFormat:@"在线实付:¥%@",_infoDict[@"newprice"]];
    [bottomView addSubview:priceLb];
    [priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(bottomView.mas_centerY);
        make.left.equalTo(bottomView.mas_left);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/2, 20));
    }];
    
    submitBtn = [UIButton new];
    submitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:24];
    [submitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.backgroundColor = UIColorFromHexValue(0x169BD5);
    [bottomView addSubview:submitBtn];
    [submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(bottomView);
        make.width.mas_equalTo(@(ScreenWidth/2));
    }];
    
}
//设置datePicker
- (void)setUpDatePiker
{
    //datePicker
    self.dateToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, 375, 44)];
    self.dateToolBar.backgroundColor = UIColorFromHexString(@"0x8fc31f");
    UIButton *barCancel = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 60, 44)];
    [barCancel setTitle:@"取消" forState:UIControlStateNormal];
    barCancel.titleLabel.font = [UIFont fontWithName:@"Heit SC - Bold" size:16];
    [barCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [barCancel addTarget:self action:@selector(barCancelAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *barDone = [[UIButton alloc] initWithFrame:CGRectMake(305, 0, 60, 44)];
    [barDone setTitle:@"确定" forState:UIControlStateNormal];
    [barDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [barDone addTarget:self action:@selector(barDoneAction:) forControlEvents:UIControlEventTouchUpInside];
    barDone.titleLabel.font = [UIFont fontWithName:@"Heit SC - Bold" size:16];
    [self.dateToolBar addSubview:barCancel];
    [self.dateToolBar addSubview:barDone];
    
    self.datePiker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
    self.datePiker.tintColor = [UIColor whiteColor];
    self.datePiker.datePickerMode = UIDatePickerModeDateAndTime;
    self.datePiker.backgroundColor = [UIColor whiteColor];
    NSDate* minDate = [NSDate date];
    self.datePiker.minimumDate = minDate;
    [self.datePiker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.dateToolBar];
    [self.view addSubview:self.datePiker];
}
//datePickerTool_BtnAction
- (void)barCancelAction:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.dateToolBar setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 44)];
        [self.datePiker setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
    }];
    _dateisOn = NO;
}
- (void)barDoneAction:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        [self.dateToolBar setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 44)];
        [self.datePiker setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
    }];
    dateTld.text = self.loctime;
    _dateisOn = NO;
}

#pragma mark-
#pragma mark- 返回按钮点击事件
- (void)backBtnClick{
    [self .navigationController popViewControllerAnimated:YES];
}
#pragma mark- 提交订单按钮点击事件
- (void)submitBtnClick{
    if (nameTld.text.length>0&&phoneNumTld.text.length>0&&IdCardTld.text.length>0&&([manBtn isSelected]||[WomanBtn isSelected])&&([marriedBtn isSelected]||[unmarriedBtn isSelected])&&dateTld.text.length>0) {
        OrderInfo *order = [OrderInfo new];
        //生成随机订单号
        NSString *ordernum = [MBUtilities randomOrderID];
        
        order.ordernum=ordernum;//订单号
        order.ordersum = [_infoDict objectForKey:@"sum"];//订单预约人数
        order.orderimage =[_infoDict objectForKey:@"image"];//订单图片
        order.orderstate=@"已完成";//订单状态
        order.ordermoney=[_infoDict objectForKey:@"newprice"];//订单折扣金额
        order.orderoldmoney=[_infoDict objectForKey:@"oldprice"];//订单原来金额
        order.ordertime=dateTld.text;//订单时间
        order.ordertitle=[_infoDict objectForKey:@"title"];//订单标题
        order.orderdetail=[_infoDict objectForKey:@"detail"];//订单描述
        order.name=nameTld.text;//姓名
        order.idcard=IdCardTld.text;//身份证
        order.gender=genderStr;//性别
        order.married=marriedStr;//婚否
        order.phone=phoneNumTld.text;//手机号
        
        
        
        if ([FMDBTool addOrder:order]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"提交订单成功，可去我的订单界面查看。" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self backBtnClick];
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"提交订单失败，请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }

    }else{

        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"信息还未填写完整！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
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
            
            orderNameLb.text =[NSString stringWithFormat:@"%@",_infoDict[@"title"]];
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
            
            [personBtn setImage:[UIImage imageNamed:@"individuals-sel"] forState:UIControlStateNormal];
            [personBtn addTarget:self action:@selector(personBtnClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:personBtn];
            [personBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.right.equalTo(cell.mas_right).with.offset(-10);
                make.size.mas_equalTo(CGSizeMake(40, 40));
            }];
            
        }else if(indexPath.row==2){
            dateTld.borderStyle = UITextBorderStyleRoundedRect;
            dateTld.placeholder = @"请输入体检日期，如：2017/08/08";
            [dateTld setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
            [cell addSubview:dateTld];
            [dateTld mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(cell.mas_left).with.offset(10);
                make.size.mas_equalTo(CGSizeMake(200, 30));
            }];
            
            [dateBtn setImage:[UIImage imageNamed:@"alarmclock"] forState:UIControlStateNormal];
            [dateBtn addTarget:self action:@selector(dateBtnClick) forControlEvents:UIControlEventTouchUpInside];
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
                make.size.mas_equalTo(CGSizeMake(300, 30));
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
            [manBtn addTarget:self action:@selector(checkBoxClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [manBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
            manBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 50);
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
            [WomanBtn addTarget:self action:@selector(checkBoxClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [WomanBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
            WomanBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 50);
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
            [marriedBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
            [marriedBtn addTarget:self action:@selector(checkBoxClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [marriedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            marriedBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 50);
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
            [unmarriedBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
            [unmarriedBtn addTarget:self action:@selector(checkBoxClickAction:) forControlEvents:UIControlEventTouchUpInside];
            [unmarriedBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            unmarriedBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 50);
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
#pragma mark-
#pragma mark- 获取个人信息按钮点击事件
- (void)personBtnClick{
    if ([[MBPreferenceManager sharedPreferenceManager] isExist]==YES) {
        nameTld.text = [[MBPreferenceManager sharedPreferenceManager] getUserName];
        phoneNumTld.text = [[MBPreferenceManager sharedPreferenceManager] getUserPhone];
        IdCardTld.text = [[MBPreferenceManager sharedPreferenceManager]getUserIDCard];
        if ([[[MBPreferenceManager sharedPreferenceManager] getUserGender] isEqualToString:@"男"]) {
            [self checkBoxClickAction:manBtn];
        }else{
            [self checkBoxClickAction:WomanBtn];
        }
        
        if ([[[MBPreferenceManager sharedPreferenceManager] getUserMarried] isEqualToString:@"已婚"]) {
            [self checkBoxClickAction:marriedBtn];
        }else{
            [self checkBoxClickAction:unmarriedBtn];
        }
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"您还没有保存个人信息哦！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"现在去填写" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            PersonInfoViewController *info = [PersonInfoViewController new];
            [self.navigationController pushViewController:info animated:YES];
        }];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"不用了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:cancel];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
#pragma mark- 预约体检时间按钮点击事件
- (void)dateBtnClick{
    [self.view endEditing:YES];
    if (self.dateisOn == NO) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.dateToolBar setFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - (216 + 44)), [UIScreen mainScreen].bounds.size.width, 44)];
            [self.datePiker setFrame:CGRectMake(0, ([UIScreen mainScreen].bounds.size.height - 216), [UIScreen mainScreen].bounds.size.width, 216)];
        }];
        self.dateisOn = YES;
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            [self.dateToolBar setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 44 )];
            [self.datePiker setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 0)];
        }];
        _dateisOn = NO;
    }
    NSLog(@"%f%f%f",self.datePiker.frame.origin.y,self.datePiker.frame.size.width,self.datePiker.frame.size.height);
}
-(void)dateChange:(id)sender
{
    dateTld.alpha = 1;
    dateTld.textColor = [UIColor blackColor];
    NSDate *selected = [sender date];
    NSLog(@"date: %@", selected);
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString *time = [formatter stringFromDate:selected];
    self.loctime = [NSString stringWithFormat:@"%@",time];
    NSLog(@"%@",self.loctime);
}
#pragma mark-选择框事件
-(void)checkBoxClickAction:(UIButton *)button{
    if ([button isSelected]) {
        button.selected=NO;
        [button setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
    }else{
        if (button==manBtn) {
            [WomanBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
            genderStr = @"男";
        }else if (button==WomanBtn){
            [manBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
            genderStr = @"女";
        }else if (button==marriedBtn){
            [unmarriedBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
            marriedStr = @"未婚";
        }else if (button==unmarriedBtn){
            [marriedBtn setImage:[UIImage imageNamed:@"未选中"] forState:UIControlStateNormal];
            marriedStr = @"已婚";
        }
        button.selected=YES;
        [button setImage:[UIImage imageNamed:@"选中"] forState:UIControlStateNormal];
    }
}
#pragma mark-
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
