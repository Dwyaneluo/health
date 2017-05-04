//
//  RegisterViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/3/22.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "RegisterViewController.h"
#import "SFVerificationCodeView.h"
#import "FMDBTool.h"
@interface RegisterViewController ()
{
    UITextField *phoneTld;
    UITextField *verifyTld;
    UITextField *passwordTld;
    UIButton *registBtn;
    UIButton *verifyBtn;
    SFVerificationCodeView *verifyView;
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
}
-(void)createView{
    UIImageView *bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    bgImgView.image= [UIImage imageNamed:@"login"];
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
    [passwordTld mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(phoneTld.mas_bottom).with.offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-30, 40));
    }];
    passwordTld.placeholder = @"请输入你的密码";
    [self.view addSubview:passwordTld];
    passwordTld.secureTextEntry=YES;
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
    

    
    registBtn = [UIButton new];
    registBtn.layer.masksToBounds=YES;
    registBtn.layer.cornerRadius=5;
    registBtn.layer.borderColor = [UIColor blackColor].CGColor;
    registBtn.layer.borderWidth = 2;
    [registBtn setTitle:@"注 册" forState:UIControlStateNormal];
    [registBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registBtn];
    [registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(verifyTld.mas_bottom).with.offset(30);
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-30, 40));
    }];
    
}
//后退按钮事件
-(void)backBtnAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
#pragma mark -
#pragma mark 注册功能的实现
-(void)registBtnClick
{
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
    //判断信息是否输入完整
    if (phoneTld.text.length>0&&passwordTld.text.length>0) {
        if ([FMDBTool selectWithUserName:phoneTld.text]) {
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示信息" message:@"用户已注册！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            User *u=[User new];
            u.phonenum=phoneTld.text;
            u.password=passwordTld.text;
            [FMDBTool addUser:u];
            UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示信息" message:@"注册成功！" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self backBtnAction];
            }];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    else
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示信息" message:@"用户信息填写不完整！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
