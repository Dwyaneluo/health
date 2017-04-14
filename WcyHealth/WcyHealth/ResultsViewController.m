//
//  ResultsViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/4/10.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "ResultsViewController.h"

@interface ResultsViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
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
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 30)];
    back.backgroundColor = [UIColor blackColor];
    [back addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];

}

-(void)createView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth    , 104)];
    [self.view addSubview:topView];
    
    summaryBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth/2, 40)];
    [summaryBtn setTitle:@"体检总结" forState:UIControlStateNormal];
    [summaryBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [summaryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [topView addSubview:summaryBtn];
    
    detailBtn = [[UIButton alloc] initWithFrame:CGRectMake( ScreenWidth/2, 64, ScreenWidth/2, 40)];
    [detailBtn setTitle:@"体检详情" forState:UIControlStateNormal];
    [detailBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [detailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [topView addSubview:detailBtn];
    
    under_line = [UIView new];
    under_line.backgroundColor = [UIColor redColor];
    [topView addSubview:under_line];
    [under_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(summaryBtn.mas_left);
        make.bottom.equalTo(summaryBtn.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/2, 1));
    }];
    
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight-64)];
    scroll.pagingEnabled = YES;
    scroll.scrollEnabled=NO;
    scroll.delegate=self;
    scroll.contentSize = CGSizeMake(2*ScreenWidth, ScreenHeight-40);
    [self.view addSubview:scroll];
    
    summaryTabV=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-104)];
    [scroll addSubview:summaryTabV];
    summaryTabV.delegate=self;
    summaryTabV.dataSource=self;
    [summaryTabV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    summaryTabV.tableFooterView =[UIView new];
    summaryTabV.backgroundColor = UIColorFromHexValue(0xf4f4f4);
    
    detailTabV=[[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight-104)];
    [scroll addSubview:detailTabV];
    detailTabV.delegate=self;
    detailTabV.dataSource=self;
    [detailTabV registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    detailTabV.tableFooterView =[UIView new];
    detailTabV.backgroundColor = UIColorFromHexValue(0xf4f4f4);
}
- (void)backBtnClick{
    [self .navigationController popViewControllerAnimated:YES];
}
-(void)buttonClick:(UIButton *)button{
    [under_line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button.mas_left);
        make.bottom.equalTo(button.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth/2, 1));
    }];
    if (button==summaryBtn) {
        scroll.contentOffset = CGPointMake(0, 0);
    }else{
        scroll.contentOffset = CGPointMake(ScreenWidth, 0);
    }
}
#pragma mark- tablview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView==summaryTabV) {
        return 3;
    }
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView==summaryTabV) {
        if (section==0) {
            return 5;
        }else if (section==1){
            return 1;
        }else{
            return 1;
        }
    }else{
        if (section==0) {
            return 5;
        }else if (section==1){
            return 7;
        }else if (section==2){
            return 6;
        }else if (section==3){
            return 3;
        }else{
            return 4;
        }
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    UILabel *label = [UILabel new];
    [view addSubview:label];
    if(tableView==summaryTabV){
        
        label.font = [UIFont boldSystemFontOfSize:16];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.equalTo(view.mas_left).with.offset(15);
            make.size.mas_equalTo(CGSizeMake(200, 20));
        }];
        if (section==0) {
            label.text = @"异常指标";
            label.textColor = UIColorFromHexValue(0xFD9827);
        }else if (section==1){
            label.text = @"体检结论";
            label.textColor = UIColorFromHexValue(0x009966);
        }else if (section==2){
            label.text = @"体检建议";
            label.textColor =UIColorFromHexValue(0x009966);
        }
        
    }else{
        
        label.font = [UIFont boldSystemFontOfSize:13];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left);
            make.bottom.equalTo(view.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(100, 20));
        }];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        if (section==0) {
            label.text = @"一般检查";
            label.backgroundColor = UIColorFromHexValue(0xFF0000);
        }else if (section==1){
            label.text = @"一般检查";
            label.textColor = UIColorFromHexValue(0xFFCD28);
        }else if (section==2){
            label.text = @"外科";
            label.textColor =UIColorFromHexValue(0x63CCCC);
        }else if (section==3){
            label.text = @"眼科";
            label.textColor =UIColorFromHexValue(0x00CD2B);
        }else if (section==2){
            label.text = @"外科";
            label.textColor =UIColorFromHexValue(0x63CCCC);
        }
    }


    
    
    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView==summaryTabV) {
        if (indexPath.section==0) {
            return 60;
        }else{
            return 120;
        }
    }else{
        return 60;
    }


}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (tableView==summaryTabV) {
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
    }else{
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
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
