//
//  BookingViewController.m
//  WcyHealth
//  体检预约套餐
//  Created by 天涯 on 2017/3/28.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "BookingViewController.h"

@interface BookingViewController ()
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
    
}
- (void)createView{
    UIButton *back = [UIButton new];
    back.backgroundColor = [UIColor blackColor];
    self.navigationItem.leftBarButtonItem.customView = back;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
