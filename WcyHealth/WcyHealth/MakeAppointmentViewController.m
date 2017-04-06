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
}
@end

@implementation MakeAppointmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"订单填写";
    [self createView];
}

- (void)createView{
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    back.backgroundColor = [UIColor blackColor];
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
}
#pragma mark - tableview delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellStr= @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell!=nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section==0) {
            UILabel *title = [UILabel new];
        }
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
