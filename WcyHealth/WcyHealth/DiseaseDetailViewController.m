//
//  DiseaseDetailViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/4/29.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "DiseaseDetailViewController.h"

@interface DiseaseDetailViewController ()
<UIWebViewDelegate>{
    UIWebView* webView;
    NSDictionary *dict;
}

@end

@implementation DiseaseDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createView];
}
-(void)viewWillAppear:(BOOL)animated{
    [self refreshData];
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
-(void)refreshData{
    [self getNetWork];
}
- (void)backBtnClick{
    [self .navigationController popViewControllerAnimated:YES];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)getNetWork
{
    [SVProgressHUD show];
    //创建请求管理器
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];
    NSString *url=[NSString stringWithFormat:@"http://www.tngou.net/api/disease/show?id=%@",self.idStr];
    NSLog(@"%@",url);
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    
    
    [manger GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        
        
        if (![responseObject[@"error"] boolValue]) {
            
            
            //获取数据
            dict  = responseObject;
            self.title = [dict objectForKey:@"name"];
            NSURL *url=[NSURL URLWithString:[dict objectForKey:@"url"]];
            NSURLRequest *request=[NSURLRequest requestWithURL:url];
            [webView loadRequest:request];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showWithStatus:@"获取失败"];
        NSLog(@"数据获取失败，%@",error);
    }];
}

@end
