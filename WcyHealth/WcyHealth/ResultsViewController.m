//
//  ResultsViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/4/10.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "ResultsViewController.h"

@interface ResultsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *summaryTabV;
    UITableView *detailTabV;
    UIScrollView *scroll;
    
    UIButton *summaryBtn;
    UIButton *detailBtn;
    UIView *under_line;
}
@end

@implementation ResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报告详情";
    [self createView];
}

-(void)createView {
    summaryBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth/2, 40)];
    [summaryBtn setTitle:@"体检总结" forState:UIControlStateNormal];
    [summaryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:summaryBtn];
    
    detailBtn = [[UIButton alloc] initWithFrame:CGRectMake( ScreenWidth/2, 0, ScreenWidth/2, 40)];
    [detailBtn setTitle:@"体检总结" forState:UIControlStateNormal];
    [detailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:detailBtn];
    
    under_line = [UIView new];
    under_line.backgroundColor = [UIColor redColor];
    [self.view addSubview:under_line];
    [under_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(summaryBtn);
        make.bottom.equalTo(summaryBtn.mas_bottom);
        make.height.mas_equalTo(@1);
    }];
    
    
    
    
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, ScreenHeight-40)];
    scroll.contentSize = CGSizeMake(2*ScreenWidth, ScreenHeight-40);
    [self.view addSubview:scroll];
    
    summaryTabV=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-40)];
    [scroll addSubview:summaryTabV];
    summaryTabV.delegate=self;
    summaryTabV.dataSource=self;
    [summaryTabV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    summaryTabV.tableFooterView =[UIView new];
    summaryTabV.backgroundColor = UIColorFromHexValue(0xf4f4f4);
}
#pragma mark- tablview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }else if (section==1){
        return 1;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    UILabel *label = [UILabel new];
    [view addSubview:label];
    label.font = [UIFont boldSystemFontOfSize:16];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    if (section==0) {
        label.text = @"异常指标";
        label.textColor = [UIColor whiteColor];
        view.backgroundColor = UIColorFromHexValue(0xFD9827);
    }else if (section==1){
        label.text = @"体检结论";
        label.textColor = UIColorFromHexValue(0x009966);
    }else if (section==2){
        label.text = @"体检建议";
        label.textColor =UIColorFromHexValue(0x009966);
    }
    
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 60;
    }else{
        return 120;
    }

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * celLStr= @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celLStr];
    if (cell!=nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celLStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *title =[UILabel new];
        title.textColor = [UIColor blackColor];
        title.font = [UIFont systemFontOfSize:16];
        [cell addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.mas_left).with.offset(55);
            make.centerY.equalTo(cell.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(150, 20));
        }];
        
    }
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
