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
    UIButton *defaultBtn;//默认排序
    UIButton *priceBtn;//按照价格排序
    UIButton *numBtn;//按照数量排序
    UITableView  *table;//列表
    NSMutableArray *dataArr;
    NSArray *defaultArr;//默认数组
    NSArray *priceArr;//价格数组
    NSArray *sumArr;//数量数组
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
    [defaultBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [defaultBtn addTarget:self action:@selector(defaultBtnClick) forControlEvents:UIControlEventTouchUpInside];
    defaultBtn.layer.borderWidth=0.5;
    defaultBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:defaultBtn];
    
    priceBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth/3, 64, ScreenWidth/3, 40)];
    [priceBtn setTitle:@"价格" forState:UIControlStateNormal];
    [priceBtn addTarget:self action:@selector(priceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [priceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    priceBtn.layer.borderWidth=0.5;
    priceBtn.layer.borderColor = [UIColor blackColor].CGColor;
    [self.view addSubview:priceBtn];
    
    numBtn = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth*2/3, 64, ScreenWidth/3, 40)];
    [numBtn setTitle:@"销量" forState:UIControlStateNormal];
    [numBtn addTarget:self action:@selector(numBtnClick) forControlEvents:UIControlEventTouchUpInside];
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
    
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"Combo" ofType:@"plist"];
    dataArr = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    defaultArr = [NSArray arrayWithArray:dataArr];
    NSLog(@"%@",dataArr);//直接打印数据

}
#pragma mark-
#pragma mark- 返回按钮
- (void)backBtnClick{
    [self .navigationController popViewControllerAnimated:YES];
}
#pragma mark- 按钮点击事件
//默认按钮
- (void)defaultBtnClick{

    [defaultBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [priceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [numBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    dataArr = [NSMutableArray arrayWithArray:defaultArr];
    [table reloadData];
}
//价格按钮
- (void)priceBtnClick{
    [priceBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [defaultBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [numBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    if (priceArr.count<1) {
        priceArr = [dataArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if ([[obj1 objectForKey:@"oldprice"] integerValue] < [[obj2 objectForKey:@"oldprice"] integerValue])
            {
                return NSOrderedDescending;
            }
            else
            {
                return NSOrderedAscending;
            }
        }];
    }
    dataArr = [NSMutableArray arrayWithArray:priceArr];
    [table reloadData];
}
//销量按钮
- (void)numBtnClick{
    [numBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [defaultBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [priceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (sumArr.count<1) {
        sumArr = [dataArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            if ([[obj1 objectForKey:@"sum"] integerValue] < [[obj2 objectForKey:@"sum"] integerValue])
            {
                return NSOrderedDescending;
            }
            else
            {
                return NSOrderedAscending;
            }
        }];
    }
    dataArr = [NSMutableArray arrayWithArray:sumArr];
    [table reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark-  tablview delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellStr= @"cell";
    BookingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell!=nil) {
        cell = [[BookingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    NSDictionary *dict = dataArr[indexPath.row];
    [cell setValueToCell:dict];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = [dataArr objectAtIndex:indexPath.row];
    ComboDetailViewController *detail = [ComboDetailViewController new];
    detail.infoDict = dict;
    [self.navigationController pushViewController:detail animated:YES];
}
@end
