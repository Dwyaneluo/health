//
//  RegisterViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/3/22.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
{
    UITextField *phoneTld;
    UITextField *verifyTld;
    UITextField *passwordTld;
    UIButton *registBtn;
    UIButton *verifyBtn;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
}
-(void)createView{
    UIView *TopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    TopView.backgroundColor = UIColorFromHexValue(0xf9f9f9);
    [self.view addSubview:TopView];
    self.view.backgroundColor = UIColorFromHexValue(0xf4f4f4);
    
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(15, 25, 20, 30)];
    back.backgroundColor = [UIColor blackColor];
    [back addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [TopView addSubview:back];
    
    
    UILabel *title = [UILabel new];
    title.font = [UIFont boldSystemFontOfSize:17];
    title.text = @"注册";
    title.textAlignment = NSTextAlignmentCenter;
    [TopView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopView.mas_top).with.offset(27);
        make.centerX.equalTo(TopView);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    
    phoneTld = [UITextField new];
    phoneTld.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:phoneTld];
    [phoneTld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(TopView.mas_bottom).with.offset(40);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-30, 40));
    }];
    phoneTld.placeholder = @"请输入手机号";
    [self.view addSubview:phoneTld];
    UIImageView *phoneIcon=[[UIImageView alloc]initWithFrame:CGRectMake(-20, 0, 32, 24)];
    phoneIcon.backgroundColor = [UIColor redColor];
    phoneTld.leftView=phoneIcon;
    phoneTld.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    phoneTld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    
    passwordTld = [UITextField new];
    passwordTld.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:passwordTld];
    [passwordTld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneTld.mas_bottom).with.offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-30, 40));
    }];
    passwordTld.placeholder = @"请输入你的密码";
    [self.view addSubview:passwordTld];
    UIImageView *passwordIcon=[[UIImageView alloc]initWithFrame:CGRectMake(-20, 0, 32, 24)];
    passwordIcon.backgroundColor = [UIColor redColor];
    passwordTld.leftView=passwordIcon;
    passwordTld.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    passwordTld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    verifyTld = [UITextField new];
    verifyTld.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:verifyTld];
    [verifyTld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordTld.mas_bottom).with.offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-30, 40));
    }];
    verifyTld.placeholder = @"请输入图形验证码";
    [self.view addSubview:verifyTld];
    UIImageView *verifyIcon=[[UIImageView alloc]initWithFrame:CGRectMake(-20, 0, 32, 24)];
    verifyIcon.backgroundColor = [UIColor redColor];
    verifyTld.leftView=verifyIcon;
    verifyTld.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    verifyTld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    verifyBtn = [UIButton new];
    verifyBtn.backgroundColor = [UIColor yellowColor];
    [verifyBtn setTitle:@"ZXCV" forState:UIControlStateNormal];
    [verifyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:verifyBtn];
    [verifyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(verifyTld.mas_centerY);
        make.right.equalTo(verifyTld.mas_right).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(120, 30));
    }];
    
    registBtn = [UIButton new];
    registBtn.layer.masksToBounds=YES;
    registBtn.layer.cornerRadius=5;
    registBtn.layer.borderColor = [UIColor blackColor].CGColor;
    registBtn.layer.borderWidth = 2;
    [registBtn setTitle:@"注 册" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:registBtn];
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verifyTld.mas_bottom).with.offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-30, 40));
    }];
    
}
-(void)backBtnAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
