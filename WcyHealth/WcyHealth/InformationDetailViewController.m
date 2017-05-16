//
//  InformationDetailViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/4/22.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "InformationDetailViewController.h"
#import "InformationTableViewCell.h"
@interface InformationDetailViewController ()<UIWebViewDelegate>{
    UIWebView* webView;
    NSDictionary *dict;
}

@end

@implementation InformationDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
    self.title = self.titleStr;
    [SVProgressHUD show];
    NSURL *url=[NSURL URLWithString:self.urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

-(void)createView {
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [back setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:back];

    webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:webView];
    webView.delegate=self;
}

- (void)backBtnClick{
    [self .navigationController popViewControllerAnimated:YES];
}
#pragma mark- tablview delegate

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
