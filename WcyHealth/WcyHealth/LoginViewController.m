//
//  LoginViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/3/22.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
@interface LoginViewController ()
{
    UITextField *phoneTld;
    UITextField *verifyTld;
    UITextField *passwordTld;
    UIButton *loginBtn;
    UIButton *verifyBtn;
    UIButton *registBtn;
    UIButton *findPswBtn;
}
@end

@implementation LoginViewController

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
    title.text = @"登录";
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
    
    loginBtn = [UIButton new];
    loginBtn.layer.masksToBounds=YES;
    loginBtn.layer.cornerRadius=5;
    loginBtn.layer.borderColor = [UIColor blackColor].CGColor;
    loginBtn.layer.borderWidth = 2;
    [loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:loginBtn];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verifyTld.mas_bottom).with.offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-30, 40));
    }];
    
    
    registBtn = [UIButton new];
    registBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [registBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).with.offset(30);
        make.left.equalTo(loginBtn.mas_left);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    findPswBtn = [UIButton new];
    findPswBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [findPswBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    [findPswBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.view addSubview:findPswBtn];
    [findPswBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(loginBtn.mas_bottom).with.offset(30);
        make.right.equalTo(loginBtn.mas_right);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];

}
-(void)registBtnAction{
    [self presentViewController:[RegisterViewController new] animated:YES completion:nil];
}
-(void)backBtnAction{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
