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
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    back.backgroundColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem.customView = back;
    
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
        make.top.equalTo(head);
        make.centerX.equalTo(head);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth*3/4, ScreenWidth*3/8));
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
    callConsultBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [callConsultBtn setTitle:@"电话咨询" forState:UIControlStateNormal];
    [callConsultBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    callConsultBtn.layer.borderWidth = 1;
    callConsultBtn.layer.borderColor = [UIColor blueColor].CGColor;
    [callConsultBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    callConsultBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 60);
    //button标题的偏移量，这个偏移量是相对于图片的
    callConsultBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [head addSubview:callConsultBtn];
    [callConsultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oldPrice.mas_bottom).with.offset(20);
        make.left.equalTo(head.mas_left).with.offset(5);
        make.size.mas_equalTo(CGSizeMake((ScreenWidth-30)/3, 40));
    }];
    
    onlineConsultBtn = [UIButton new];
    onlineConsultBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [onlineConsultBtn setTitle:@"在线咨询" forState:UIControlStateNormal];
    [onlineConsultBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    onlineConsultBtn.layer.borderWidth = 1;
    onlineConsultBtn.layer.borderColor = [UIColor redColor].CGColor;
    [onlineConsultBtn setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    onlineConsultBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 60);
    //button标题的偏移量，这个偏移量是相对于图片的
    onlineConsultBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [head addSubview:onlineConsultBtn];
    [onlineConsultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(oldPrice.mas_bottom).with.offset(20);
        make.left.equalTo(callConsultBtn.mas_right).with.offset(20);
        make.size.mas_equalTo(CGSizeMake((ScreenWidth-40)/3, 40));
    }];
    
}
-(void)sectionClick{
    
}
#pragma mark-  tablview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    
    UILabel* title = [UILabel new];
    title.font = [UIFont systemFontOfSize:13];
    [headSection addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headSection.mas_centerY);
        make.left.equalTo(headSection.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-30, 20));
    }];
    if (section==0) {
        title.text =  @"套餐内容";
    }else if (section==1){
        title.text = @"科室检查（4项）";
    }else if (section==2){
        title.text = @"实验室检查（3项）";
    }else if (section==3){
        title.text = @"医技检查（2项）";
    }else {
        title.text = @"其它检查（2项）";
    }
    return headSection;
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 100;
    }else{
        return 60;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellStr= @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell!=nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section==0) {
            
            UILabel* title = [UILabel new];
            title.font = [UIFont systemFontOfSize:13];
            title.text = @"适用人群: 青年女性， 青年男性，中年男性，中年女性";
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:title.text];
            [attrStr addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:15]
                            range:NSMakeRange(0, 4)];
            [attrStr addAttribute:NSForegroundColorAttributeName
                            value:[UIColor blueColor]
                            range:NSMakeRange(0, 4)];
            title.attributedText = attrStr;
            [cell addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(cell.mas_top).with.offset(10);
                make.left.equalTo(cell.mas_left).with.offset(5);
                make.size.mas_equalTo(CGSizeMake(ScreenWidth-10, 20));
            }];
            
            UILabel* title2 = [UILabel new];
            title2.font = [UIFont systemFontOfSize:13];
            title2.text = @"重点检查：基础性全身检查";
            NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc] initWithString:title2.text];
            [attrStr1 addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:15]
                            range:NSMakeRange(0, 4)];
            [attrStr1 addAttribute:NSForegroundColorAttributeName
                            value:[UIColor blueColor]
                            range:NSMakeRange(0, 4)];
            title2.attributedText = attrStr1;
            [cell addSubview:title2];
            [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(title.mas_bottom).with.offset(10);
                make.left.equalTo(cell.mas_left).with.offset(5);
                make.size.mas_equalTo(CGSizeMake(ScreenWidth-10, 20));
            }];
            
            UILabel* title3 = [UILabel new];
            title3.font = [UIFont systemFontOfSize:13];
            title3.text = @"体检项目（4项）";
            [cell addSubview:title3];
            [title3 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(title2.mas_bottom).with.offset(10);
                make.left.equalTo(cell.mas_left).with.offset(5);
                make.size.mas_equalTo(CGSizeMake(ScreenWidth-10, 20));
            }];
        }
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
