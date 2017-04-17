//
//  PersonInfoViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/4/8.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "PersonInfoViewController.h"

@interface PersonInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *table;
    UITextField * nameTld;
    UITextField *phoneNumTld;
    UITextField *IdCardTld;
    UIButton *manBtn;
    UIButton *WomanBtn;
    UIButton *marriedBtn;
    UIButton *unmarriedBtn;
    
    UIButton *confirmBtn;

}

@end

@implementation PersonInfoViewController
-(instancetype)init{
    self= [super init];
    if (self) {
        manBtn = [UIButton new];
        WomanBtn = [UIButton new];
        nameTld = [UITextField new];
        phoneNumTld = [UITextField new];
        IdCardTld = [UITextField new];
        marriedBtn = [UIButton new];
        unmarriedBtn = [UIButton new];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    [self createView];
}

-(void)createView {
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];

    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:table];
    table.delegate=self;
    table.dataSource=self;
    table.rowHeight=50;
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    table.tableFooterView =[UIView new];
    table.backgroundColor = UIColorFromHexValue(0xf4f4f4);
    
    
    confirmBtn = [UIButton new];
    confirmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [confirmBtn setTitle:@"保存" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    confirmBtn.layer.masksToBounds = YES;
    confirmBtn.layer.cornerRadius = 3;
    confirmBtn.layer.borderWidth = 1;
    confirmBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [table addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(table.mas_centerX);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(200, 30));
    }];
}
- (void)backBtnClick{
    [self .navigationController popViewControllerAnimated:YES];
}
#pragma mark - 列表代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * celLStr= @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celLStr];
    if (cell!=nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celLStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *title = [UILabel new];
        title.font = [UIFont systemFontOfSize:15];
        [cell addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_centerY);
            make.left.equalTo(cell.mas_left).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(80, 20));
        }];
        
        if(indexPath.row==0){
            
            title.text = @"姓 名：";
            
            nameTld.borderStyle = UITextBorderStyleRoundedRect;
            nameTld.placeholder = @"请输入体检人姓名";
            [nameTld setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
            [cell addSubview:nameTld];
            [nameTld mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.right.equalTo(cell.mas_right).with.offset(-15);
                make.size.mas_equalTo(CGSizeMake(200, 30));
            }];
            
        }else if(indexPath.row==1){
            title.text = @"手机号：";
            phoneNumTld.borderStyle = UITextBorderStyleRoundedRect;
            phoneNumTld.placeholder = @"请输入手机号";
            [phoneNumTld setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
            [cell addSubview:phoneNumTld];
            [phoneNumTld mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.right.equalTo(cell.mas_right).with.offset(-15);
                make.size.mas_equalTo(CGSizeMake(200, 30));
            }];
        }else if(indexPath.row==2){
            title.text = @"身份证：";
            IdCardTld.borderStyle = UITextBorderStyleRoundedRect;
            IdCardTld.placeholder = @"请输入人身份证号";
            [IdCardTld setValue:[UIFont systemFontOfSize:15] forKeyPath:@"_placeholderLabel.font"];
            [cell addSubview:IdCardTld];
            [IdCardTld mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.right.equalTo(cell.mas_right).with.offset(-15);
                make.size.mas_equalTo(CGSizeMake(200, 30));
            }];
        }else if(indexPath.row==3){
            title.text = @"性 别：";
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
        }else if(indexPath.row==4){

            title.text = @"婚 否";
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
