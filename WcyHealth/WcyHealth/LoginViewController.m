//
//  LoginViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/3/22.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "SFVerificationCodeView.h"
#import "FMDBTool.h"
#import "MBPreferenceManager.h"
@interface LoginViewController ()
{
    UITextField *phoneTld;
    UITextField *verifyTld;
    UITextField *passwordTld;
    UIButton *loginBtn;
    SFVerificationCodeView *verifyView;
    UIButton *registBtn;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
}

-(void)createView{

    
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bgImgView.image= [UIImage imageNamed:@"登陆页面背景"];
    bgImgView.userInteractionEnabled=YES;
    [self.view addSubview:bgImgView];
    
    UIView *TopView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 64)];
    [self.view addSubview:TopView];
    self.view.backgroundColor = UIColorFromHexValue(0xf4f4f4);
    
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(15, 25, 30, 30)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
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
        make.top.equalTo(TopView.mas_bottom).with.offset(240);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-30, 40));
    }];
    phoneTld.placeholder = @"请输入手机号";
    [self.view addSubview:phoneTld];
    UIImageView *phoneIcon=[[UIImageView alloc]initWithFrame:CGRectMake(-20, 0, 32, 24)];
    phoneIcon.image = [UIImage imageNamed:@"phonenumber"];
    phoneTld.leftView=phoneIcon;
    phoneTld.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    phoneTld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    
    passwordTld = [UITextField new];
    passwordTld.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:passwordTld];
    passwordTld.secureTextEntry=YES;
    [passwordTld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneTld.mas_bottom).with.offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-30, 40));
    }];
    passwordTld.placeholder = @"请输入你的密码";
    [self.view addSubview:passwordTld];
    UIImageView *passwordIcon=[[UIImageView alloc]initWithFrame:CGRectMake(-20, 0, 32, 24)];
    passwordIcon.image = [UIImage imageNamed:@"password"];
    passwordTld.leftView=passwordIcon;
    passwordTld.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    passwordTld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    verifyTld = [UITextField new];
    verifyTld.borderStyle = UITextBorderStyleRoundedRect;
    verifyTld.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self.view addSubview:verifyTld];
    [verifyTld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(passwordTld.mas_bottom).with.offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-30, 40));
    }];
    verifyTld.placeholder = @"请输入图形验证码";
    [self.view addSubview:verifyTld];
    UIImageView *verifyIcon=[[UIImageView alloc]initWithFrame:CGRectMake(-20, 0, 32, 24)];
    verifyIcon.image = [UIImage imageNamed:@"vcode"];
    verifyTld.leftView=verifyIcon;
    verifyTld.leftViewMode=UITextFieldViewModeAlways; //此处用来设置leftview现实时机
    verifyTld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
     verifyView= [SFVerificationCodeView new];
    //设置验证码生成模式 默认为Local
    verifyView.mode = SFVerificationCodeModeLocal;
    [verifyView willChangeVerificationCode:^(SFVerificationCodeMode mode) {
        NSLog(@"本地随机生成code");
        
    }];
    [verifyView didChangeVerificationCode:^(NSString *code) {
        NSLog(@"view code:%@",code);
        verifyView.code = code;
        
    }];
    //开始生成code
    [verifyView generateVerificationCode];
    [self.view addSubview:verifyView];
    [verifyView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
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
        make.centerX.equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    

}
//跳转注册界面
-(void)registBtnAction{
    [self presentViewController:[RegisterViewController new] animated:YES completion:nil];
}
//返回主界面
-(void)backBtnAction{
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark -
#pragma mark 登陆功能的实现
//登录按钮事件
-(void)loginBtnClick{
    [self.view endEditing:YES];
    //判断验证码输入是否正确
    if (![verifyTld.text isEqualToString:verifyView.code]) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示信息" message:@"验证码输入错误！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [verifyView generateVerificationCode];
        }];
        
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (![FMDBTool selectWithUserName:phoneTld.text]) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示信息" message:@"登陆失败！用户名不存在！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if ([FMDBTool selectWithInfo:phoneTld.text password:passwordTld.text]) {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示信息" message:@"登录成功！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[MBPreferenceManager sharedPreferenceManager] setLoginState:YES];
            [[MBPreferenceManager sharedPreferenceManager]setPhone:phoneTld.text];
            [[MBPreferenceManager sharedPreferenceManager]setPassword:passwordTld.text];
            [self backBtnAction];
        }];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示信息" message:@"登陆失败！用户名或密码错误！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
