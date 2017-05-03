//
//  ResultsViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/4/10.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "ResultsViewController.h"
#import "summaryTableViewCell.h"
#import "detailTableViewCell.h"
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
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];

}

-(void)createView {
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 104)];
    topView.backgroundColor = [UIColor whiteColor];
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
    
    summaryTabV=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-104) style:UITableViewStyleGrouped];
    [scroll addSubview:summaryTabV];
    summaryTabV.delegate=self;
    summaryTabV.dataSource=self;
    [summaryTabV registerClass:[summaryTableViewCell class] forCellReuseIdentifier:@"cell"];
    summaryTabV.tableFooterView =[UIView new];
    summaryTabV.backgroundColor = UIColorFromHexValue(0xf4f4f4);
    
    detailTabV=[[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight-104) style:UITableViewStyleGrouped];
    [scroll addSubview:detailTabV];
    detailTabV.delegate=self;
    detailTabV.dataSource=self;
    [detailTabV registerClass:[detailTableViewCell class] forCellReuseIdentifier:@"cell"];
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
            return 2;
        }else{
            return 3;
        }
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
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
        label.layer.masksToBounds=YES;
        label.layer.cornerRadius=10;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        if (section==0) {
            label.text = @"一般检查";
            label.backgroundColor = UIColorFromHexValue(0xFF0000);
        }else if (section==1){
            label.text = @"一般检查";
            label.backgroundColor = UIColorFromHexValue(0xFFCD28);
        }else if (section==2){
            label.text = @"外科";
            label.backgroundColor =UIColorFromHexValue(0x63CCCC);
        }else if (section==3){
            label.text = @"眼科";
            label.backgroundColor =UIColorFromHexValue(0x00CD2B);
        }else if (section==4){
            label.text = @"外科";
            label.backgroundColor =UIColorFromHexValue(0x63CCCC);
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
        summaryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celLStr];
        
        if (cell!=nil){
            cell = [[summaryTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celLStr];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            if (indexPath.section!=0) {
                cell.bgView.hidden=YES;
                UILabel *title =[UILabel new];
                title.textColor = [UIColor blackColor];
                title.font = [UIFont systemFontOfSize:14];
                title.numberOfLines=0;
                [cell addSubview:title];
                [title mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(cell.mas_left).with.offset(5);
                    make.top.equalTo(cell.mas_top).with.offset(10);
                    make.size.mas_equalTo(CGSizeMake(ScreenWidth-10, 110));
                }];
                if (indexPath.section==1) {
                    title.text = @"1.血脂异常，总胆固醇值偏高（5.56mmol/L），低密度脂蛋白胆固醇值偏高（3.43mmol/L），建议内科随诊。\n2.超声提示:脂肪肝（轻度），建议消化内科随诊。\n3.高尿酸血症，血清你尿酸值（464.7umpl/L），建议内分泌科随诊。";
                }else{
                    title.text = @"1.血脂异常\n根据《中国成人血脂异常防治指南》中国人血清胆固醇的合适范围为（TC）<5.18mmol/L。5.18-6.19mmol/L为边缘升高。>=6.22mmol/L为升高。甘油三脂（TC）的合适范围为<1.70mmol/L。1.7-2.25mmol/L为边缘升高。";
                }
            
            }
            
            if (indexPath.section==0) {
                if (indexPath.row==0) {
                    cell.titleLb.text = @"裸眼视力左";
                    cell.indexLb.text = @"0.8";
                    cell.normalLb.text = @"正常范围：1～2";
                }else if (indexPath.row==1){
                    cell.titleLb.text = @"裸眼视力右";
                    cell.indexLb.text = @"0.9";
                    cell.normalLb.text = @"正常范围：1～2";
                }else if (indexPath.row==2){
                    cell.titleLb.text = @"血清尿酸";
                    cell.indexLb.text = @"464.7";
                    cell.normalLb.text = @"正常范围：90～420";
                }else if (indexPath.row==3){
                    cell.titleLb.text = @"总胆固醇";
                    cell.indexLb.text = @"5.56";
                    cell.normalLb.text = @"正常范围：<5.18";
                }else if (indexPath.row==4){
                    cell.titleLb.text = @"低密度脂蛋白胆固醇";
                    cell.indexLb.text = @"3.43";
                    cell.normalLb.text = @"正常范围：<3.37";
                }
            }
            
        }
        return cell;
    }else{
        
        NSString * celLStr= @"cell";
        detailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celLStr];
        
        if (cell!=nil){
            cell = [[detailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celLStr];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            
            if ((indexPath.section==0&&indexPath.row>1)||(indexPath.section==3&&indexPath.row>0)) {
                
                [cell.detailLb mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.mas_top).with.offset(5);
                    make.left.equalTo(cell.titleLb.mas_right);
                    make.size.mas_equalTo(CGSizeMake((ScreenWidth-20)/2, 15));
                }];
                
                
                UILabel *title =[UILabel new];
                title.textColor = UIColorFromHexValue(0xBCBCBC);
                title.font = [UIFont systemFontOfSize:14];
                [cell addSubview:title];
                [title mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(cell.detailLb.mas_bottom).with.offset(10);
                    make.left.equalTo(cell.detailLb.mas_left);
                    make.size.mas_equalTo(CGSizeMake((ScreenWidth-20)/2, 15));
                }];
                if (indexPath.section==0) {
                    if (indexPath.row==2) {
                        title.text = @"正常值范围:18.5~23.9";
                    }else if (indexPath.row==3){
                        title.text = @"正常值范围:90~139";
                    }else if (indexPath.row==4){
                        title.text = @"正常值范围:60~89";
                    }
                }else if(indexPath.section==3){
                    cell.detailLb.textColor = [UIColor redColor];
                    if (indexPath.row==1) {
                        title.text = @"正常值范围:90~420";
                    }
                }
                
            }
            
            if (indexPath.section==0) {
                if (indexPath.row==0) {
                    cell.titleLb.text = @"身高";
                    cell.detailLb.text = @"172.0";
                }else if (indexPath.row==1){
                    cell.titleLb.text = @"体重";
                    cell.detailLb.text = @"66.0";
                }else if (indexPath.row==2){
                    cell.titleLb.text = @"体重指数BMI";
                    cell.detailLb.text = @"22.3";
                }else if (indexPath.row==3){
                    cell.titleLb.text = @"收缩压";
                    cell.detailLb.text = @"114";
                }else if (indexPath.row==4){
                    cell.titleLb.text = @"舒张压";
                    cell.detailLb.text = @"73";
                }
            }else if (indexPath.section==1){
                if (indexPath.row==0) {
                    cell.titleLb.text = @"体质";
                    cell.detailLb.text = @"营养良好";
                }else if (indexPath.row==1){
                    cell.titleLb.text = @"面容";
                    cell.detailLb.text = @"正常";
                }else if (indexPath.row==2){
                    cell.titleLb.text = @"心律";
                    cell.detailLb.text = @"齐";
                }else if (indexPath.row==3){
                    cell.titleLb.text = @"心音";
                    cell.detailLb.text = @"正常";
                }else if (indexPath.row==4){
                    cell.titleLb.text = @"心脏杂音";
                    cell.detailLb.text = @"无";
                }else if (indexPath.row==5){
                    cell.titleLb.text = @"肺部";
                    cell.detailLb.text = @"两肺呼吸正常";
                }else if (indexPath.row==6){
                    cell.titleLb.text = @"腹部";
                    cell.detailLb.text = @"未见异常";
                }
            }else if (indexPath.section==2){
                if (indexPath.row==0) {
                    cell.titleLb.text = @"皮肤";
                    cell.detailLb.text = @"未见异常";
                }else if (indexPath.row==1){
                    cell.titleLb.text = @"浅表淋巴结";
                    cell.detailLb.text = @"未见异常";
                }else if (indexPath.row==2){
                    cell.titleLb.text = @"甲状腺";
                    cell.detailLb.text = @"未见异常";
                }else if (indexPath.row==3){
                    cell.titleLb.text = @"乳房";
                    cell.detailLb.text = @"未见异常";
                }else if (indexPath.row==4){
                    cell.titleLb.text = @"脊柱";
                    cell.detailLb.text = @"未见异常";
                }else if (indexPath.row==5){
                    cell.titleLb.text = @"四肢关节";
                    cell.detailLb.text = @"未见异常";
                }
            }else if (indexPath.section==3){
                if (indexPath.row==0) {
                    cell.titleLb.text = @"外眼检查";
                    cell.detailLb.text = @"未见异常";
                    
                }else if (indexPath.row==1){
                    cell.titleLb.text = @"血清尿酸";
                    cell.detailLb.text = @"464.7";
                }
            }else if (indexPath.section==4){
                if (indexPath.row==0) {
                    cell.titleLb.text = @"耳";
                    cell.detailLb.text = @"未见异常";
                }else if (indexPath.row==1){
                    cell.titleLb.text = @"鼻";
                    cell.detailLb.text = @"未见异常";
                }else if (indexPath.row==2){
                    cell.titleLb.text = @"口咽";
                    cell.detailLb.text = @"未见异常";
                }
            }

            
        }
        return cell;
    }
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
