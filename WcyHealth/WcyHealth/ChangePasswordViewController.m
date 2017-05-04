//
//  ChangePasswordViewController.m
//  WcyHealth
//
//  Created by subang on 17/5/4.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()
{
    UITextField *oldPwdTld;
    UITextField *newPwdTld;
    UITextField *phoneTld;
    UITextField *confirmPwdTld;
    UIButton *certainBtn;
}
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    [self createView];
}


-(void)createView
{
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];
    
    self.view.backgroundColor = UIColorFromHexValue(0xf4f4f4);
    
    phoneTld=[[UITextField alloc]initWithFrame:CGRectMake(20, 70, ScreenWidth-40, 45 )];
    phoneTld.borderStyle=UITextBorderStyleNone;
    phoneTld.backgroundColor=[UIColor whiteColor];
    phoneTld.placeholder=@"请输入手机号码";
    phoneTld.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:phoneTld];
    
    
    oldPwdTld=[[UITextField alloc]initWithFrame:CGRectMake(20, 135, ScreenWidth-40, 45 )];
    oldPwdTld.borderStyle=UITextBorderStyleNone;
    oldPwdTld.backgroundColor=[UIColor whiteColor];
    oldPwdTld.placeholder=@"请输入原密码";
    oldPwdTld.font=[UIFont systemFontOfSize:16];
    oldPwdTld.secureTextEntry=YES;
    [self.view addSubview:oldPwdTld];
    
    
    newPwdTld=[[UITextField alloc]initWithFrame:CGRectMake(20, 200, ScreenWidth-40, 45)];
    newPwdTld.borderStyle=UITextBorderStyleNone;
    newPwdTld.backgroundColor=[UIColor whiteColor];
    newPwdTld.placeholder=@"请输入新密码";
    newPwdTld.secureTextEntry=YES;
    newPwdTld.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:newPwdTld];
    
    
    
    certainBtn=[[UIButton alloc]initWithFrame:CGRectMake(20, 330, ScreenWidth-40, 40)];
    certainBtn.backgroundColor = UIColorFromHexValue(0x169BD5);
    [certainBtn setTitle:@"确定修改" forState:UIControlStateNormal];
    [certainBtn addTarget:self action:@selector(certainBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [certainBtn setTitleColor:UIColorFromRGB(255, 255, 255) forState:UIControlStateNormal];
    certainBtn.layer.cornerRadius=3;
    [self.view addSubview:certainBtn];
}
#pragma mark- 修改密码按钮
- (void)certainBtnClick:(UIButton *)button{
    [self.view endEditing:YES];
    if (phoneTld.text.length>0&&oldPwdTld.text.length>0&&newPwdTld.text.length>0) {
        if ([FMDBTool selectWithInfo:phoneTld.text password:oldPwdTld.text]) {
            if ([FMDBTool changePasswordForUser:phoneTld.text newPassword:newPwdTld.text]) {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"修改密码成功！" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self backBtnClick];
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"修改密码失败！请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                [alert addAction:action];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"账号或密码错误！请重新填写" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
 
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"信息没有填写完整！" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}
- (void)backBtnClick{
    [self .navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
