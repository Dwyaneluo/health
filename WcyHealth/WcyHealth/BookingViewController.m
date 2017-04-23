//
//  BookingViewController.m
//  WcyHealth
//  体检预约套餐
//  Created by 天涯 on 2017/3/28.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "BookingViewController.h"
#import "BookingTableViewCell.h"
#import "ComboDetailViewController.h"

@interface BookingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UIButton *defaultBtn;
    UIButton *priceBtn;
    UIButton *numBtn;
    UITableView  *table;
}
@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"体检预约套餐";
    [self createView];
}
- (void)createView{
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    self.view.backgroundColor = UIColorFromHexValue(0xf4f4f4);
    
    defaultBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth/3, 40)];
    [defaultBtn setTitle:@"默认" forState:UIControlStateNormal];
    [defaultBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    defaultBtn.layer.borderWidth=0.5;
    defaultBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:defaultBtn];
    
    priceBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/3, 64, ScreenWidth/3, 40)];
    [priceBtn setTitle:@"价格" forState:UIControlStateNormal];
    [priceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    priceBtn.layer.borderWidth=0.5;
    priceBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:priceBtn];
    
    numBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth*2/3, 64, ScreenWidth/3, 40)];
    [numBtn setTitle:@"销量" forState:UIControlStateNormal];
    [numBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    numBtn.layer.borderWidth=0.5;
    numBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:numBtn];
    
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight-104)];
    table.delegate=self;
    table.dataSource=self;
    table.tableFooterView = [UIView new];
    [table registerClass:[BookingTableViewCell class] forCellReuseIdentifier:@"cell"];
    table.backgroundColor = UIColorFromHexValue(0xf4f4f4);
    table.rowHeight = 120;
    [self.view addSubview:table];

}
- (void)backBtnClick{
    [self .navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-  tablview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellStr= @"cell";
    BookingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell!=nil) {
        cell = [[BookingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ComboDetailViewController *detail = [ComboDetailViewController new];
    [self.navigationController pushViewController:detail animated:YES];
}
@end
