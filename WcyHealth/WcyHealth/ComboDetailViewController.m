//
//  ComboDetailViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/3/30.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "ComboDetailViewController.h"
#import "MBUtilities.h"
#import "MakeAppointmentViewController.h"
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
@property(nonatomic, strong)NSMutableArray *rowInSectionArray;//section中的cell个数
@property(nonatomic, strong)NSMutableArray *selectedArray;//是否被点击
@property(nonatomic, strong)NSMutableArray *sectionArray;//section标题
@end

@implementation ComboDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"套餐详情";
    [self createView];
    _sectionArray = [NSMutableArray arrayWithObjects:@"套餐内容",@"科室检查（4项）",@"实验室检查（3项）",@"医技检查（2项）",@"其它检查（2项）", nil];//每个分区的标题
    _rowInSectionArray = [NSMutableArray arrayWithObjects:@"1",@"4",@"3",@"2",@"2", nil];//每个分区中cell的个数
    _selectedArray = [NSMutableArray arrayWithObjects:@"1",@"0",@"0",@"0",@"0", nil];//这个用于判断展开还是缩回当前section的cell
}

- (void)createView{
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    table.delegate=self;
    table.dataSource=self;
    table.tableFooterView = [UIView new];
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    table.backgroundColor = UIColorFromHexValue(0xf4f4f4);
    table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
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
#pragma mark - 按钮点击事件
- (void)confirmBtnClick{
    MakeAppointmentViewController *appoint = [MakeAppointmentViewController new];
    [self.navigationController pushViewController:appoint animated:YES];
}
- (void)backBtnClick{
    [self .navigationController popViewControllerAnimated:YES];
}
-(void)sectionClick:(UIButton*)button{
    if ([_selectedArray[button.tag - 1000] isEqualToString:@"0"]) {
        
        
        //如果当前点击的section是缩回的,那么点击后就需要把它展开,是_selectedArray对应的值为1,这样当前section返回cell的个数就变为真实个数,然后刷新这个section就行了
        [_selectedArray replaceObjectAtIndex:button.tag - 1000 withObject:@"1"];
        [table reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1000] withRowAnimation:UITableViewRowAnimationFade];
    }
    else
    {
        //如果当前点击的section是展开的,那么点击后就需要把它缩回,使_selectedArray对应的值为0,这样当前section返回cell的个数变成0,然后刷新这个section就行了
        [_selectedArray replaceObjectAtIndex:button.tag - 1000 withObject:@"0"];
        [table reloadSections:[NSIndexSet indexSetWithIndex:button.tag - 1000] withRowAnimation:UITableViewRowAnimationFade];
    }
}
#pragma mark-  tablview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _sectionArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    
    UIButton *sectionButton =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    [sectionButton setTitle:[_sectionArray objectAtIndex:section] forState:UIControlStateNormal];
    [sectionButton addTarget:self action:@selector(sectionClick:) forControlEvents:UIControlEventTouchUpInside];
    sectionButton.titleLabel.font = [UIFont systemFontOfSize:15];
//    sectionButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    sectionButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    sectionButton.backgroundColor = UIColorFromHexValue(0xf4f4f4);
    [sectionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sectionButton.tag = 1000 + section;
    [headSection addSubview:sectionButton];
    
    return headSection;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //判断section的标记是否为1,如果是说明为展开,就返回真实个数,如果不是就说明是缩回,返回0.
    if ([_selectedArray[section] isEqualToString:@"1"]) {
        return [_rowInSectionArray[section] integerValue];
    }
    return 0;
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
        }else{
            UILabel* title = [UILabel new];
            title.font = [UIFont systemFontOfSize:13];
            title.textAlignment = NSTextAlignmentCenter;
            title.text = @"内科";
            [cell addSubview:title];
            [title mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(cell.mas_left);
                make.size.mas_equalTo(CGSizeMake(100, 20));
            }];
            
            UIView *line = [UIView new];
            line.backgroundColor = [UIColor blackColor];
            [cell addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(title.mas_right);
                make.top.equalTo(cell.mas_top).with.offset(1);
                make.bottom.equalTo(cell.mas_bottom).with.offset(-1);
                make.width.mas_equalTo(@1);
            }];
            
            UILabel* title2 = [UILabel new];
            title2.font = [UIFont systemFontOfSize:13];
            title2.numberOfLines=2;
            title2.text = @"心，肺，肝，脾，腹部，现病史及既往病史采集";
            [cell addSubview:title2];
            [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.left.equalTo(line.mas_right).with.offset(4);
                make.size.mas_equalTo(CGSizeMake(ScreenWidth-105, 40));
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
