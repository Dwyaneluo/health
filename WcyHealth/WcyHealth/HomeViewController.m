//
//  HomeViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/1/8.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "HomeViewController.h"
#import "BookingViewController.h"
#import "medicalReportViewController.h"
#import "DrugViewController.h"

@interface HomeViewController ()<NewPagedFlowViewDelegate, NewPagedFlowViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    UILabel *dateLb;
    UILabel *weatherLb;
    UILabel *temperLb;
    UILabel *windLb;
    UIImageView *dayImgV;
    UIImageView *nightImgV;
    UICollectionView *CollView;
}
/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;
/**
 *  轮播图
 */
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    

    
    for (int index = 0; index < 5; index++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite%02d.jpg",index]];
        [self.imageArray addObject:image];
    }
    
    
    
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, ScreenWidth, 200)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    dateLb = [UILabel new];
    dateLb.font = [UIFont systemFontOfSize:15];
    [headView addSubview:dateLb];
    [dateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headView.mas_top).with.offset(20);
        make.left.equalTo(headView.mas_left).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    UILabel  *cityLb= [UILabel new];
    cityLb.font = [UIFont systemFontOfSize:15];
    cityLb.text = @"城市：苏州";
    [headView addSubview:cityLb];
    [cityLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dateLb.mas_centerY);
        make.left.equalTo(dateLb.mas_right).with.offset(30);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    UILabel  *dayLb= [UILabel new];
    dayLb.font = [UIFont systemFontOfSize:13];
    dayLb.text = @"日间天气";
    [headView addSubview:dayLb];
    [dayLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dateLb.mas_bottom).with.offset(20);
        make.left.equalTo(headView.mas_left).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    UILabel  *nightLb= [UILabel new];
    nightLb.font = [UIFont systemFontOfSize:13];
    nightLb.text = @"夜间天气";
    [headView addSubview:nightLb];
    [nightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dayLb.mas_bottom).with.offset(30);
        make.left.equalTo(headView.mas_left).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    dayImgV = [UIImageView new];
    [headView addSubview:dayImgV];
    [dayImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(dayLb.mas_centerY);
        make.left.equalTo(dayLb.mas_right).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    

    nightImgV = [UIImageView new];
    [headView addSubview:nightImgV];
    [nightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(nightLb.mas_centerY);
        make.left.equalTo(nightLb.mas_right).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    weatherLb= [UILabel new];
    weatherLb.font = [UIFont systemFontOfSize:15];
    [headView addSubview:weatherLb];
    [weatherLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dateLb.mas_bottom).with.offset(15);
        make.left.equalTo(cityLb.mas_left);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    windLb= [UILabel new];
    windLb.font = [UIFont systemFontOfSize:15];
    [headView addSubview:windLb];
    [windLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weatherLb.mas_bottom).with.offset(10);
        make.left.equalTo(weatherLb.mas_left);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    
    temperLb= [UILabel new];
    temperLb.font = [UIFont systemFontOfSize:15];
    [headView addSubview:temperLb];
    [temperLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(windLb.mas_bottom).with.offset(10);
        make.left.equalTo(weatherLb.mas_left);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    [self setupUI];
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((ScreenWidth-40)/4, (ScreenWidth-40)/4);
    CollView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 420, ScreenWidth, ScreenHeight-460) collectionViewLayout:layout];
    CollView.scrollEnabled=YES;
    CollView.delegate=self;
    CollView.dataSource=self;
    CollView.backgroundColor=[UIColor whiteColor];
    [CollView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:CollView];
}

-(void)viewWillAppear:(BOOL)animated{
        [self getNetWork];
}
//设置轮播图
- (void)setupUI {
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 8, ScreenWidth, (ScreenWidth - 84) * 9 / 16 + 24)];
    pageFlowView.backgroundColor = [UIColor whiteColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;
    pageFlowView.minimumPageScale = 0.85;
    pageFlowView.orginPageCount = self.imageArray.count;
    pageFlowView.isOpenAutoScroll = YES;
    //初始化pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, pageFlowView.frame.size.height - 24 - 8, ScreenWidth, 8)];
    pageFlowView.pageControl = pageControl;
    [pageFlowView addSubview:pageControl];
    
    //    [self.view addSubview:pageFlowView];
    
    /****************************
     使用导航控制器(UINavigationController)
     如果控制器中不存在UIScrollView或者继承自UIScrollView的UI控件
     请使用UIScrollView作为NewPagedFlowView的容器View,才会显示正常,如下
     *****************************/
    
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 220, ScreenWidth, 200)];
    [pageFlowView reloadData];
    [bottomScrollView addSubview:pageFlowView];
    [self.view addSubview:bottomScrollView];
    
    [bottomScrollView addSubview:pageFlowView];
    
    self.pageFlowView = pageFlowView;
    
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    return CGSizeMake(ScreenWidth - 84, (ScreenWidth - 84) * 9 / 16);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);

}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.imageArray.count;
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 84, (ScreenWidth - 84) * 9 / 16)];
        bannerView.layer.cornerRadius = 4;
        bannerView.layer.masksToBounds = YES;
    }
    
    //在这里下载网络图片
    //[bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:hostUrlsImg,imageDict[@"img"]]] placeholderImage:[UIImage imageNamed:@""]];
    bannerView.mainImageView.image = self.imageArray[index];
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
//    NSLog(@"TestViewController 滚动到了第%ld页",pageNumber);
}
#pragma mark- collectionView delegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellStr=@"cell";
    UICollectionViewCell* cell =[collectionView dequeueReusableCellWithReuseIdentifier:cellStr forIndexPath:indexPath];
    
    UIImageView *image = [UIImageView new];
    [cell addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.mas_top);
        make.centerX.equalTo(cell.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentRight;
    [cell addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image.mas_bottom).with.offset(5);
        make.left.equalTo(cell.mas_left);
        make.size.mas_equalTo(CGSizeMake((ScreenWidth-40)/4, 20));
    }];
    
    if (indexPath.row==0){
        image.image = [UIImage imageNamed:@"1"];
        label.text = @"预约体检";
    }else if (indexPath.row==1){
        image.image = [UIImage imageNamed:@"2"];
        label.text = @"体检报告";
    }else if (indexPath.row==2){
        image.image = [UIImage imageNamed:@"2"];
        label.text = @"健康宣教";
    }else if (indexPath.row==3){
        image.image = [UIImage imageNamed:@"2"];
        label.text = @"药品信息";
    }else if (indexPath.row==4){
        image.image = [UIImage imageNamed:@"2"];
        label.text = @"健康指数";
    }else if (indexPath.row==5){
        image.image = [UIImage imageNamed:@"2"];
        label.text = @"健康管理";
    }
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0){
        BookingViewController *booking = [BookingViewController new];
        booking.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:booking animated:YES];
        
    }else if (indexPath.row==1){
        medicalReportViewController *medical = [medicalReportViewController new];
        medical.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:medical animated:YES];
    }else if (indexPath.row==2){
        self.tabBarController.selectedIndex = 1;
    }else if (indexPath.row==3){
        DrugViewController *drug = [DrugViewController new];
        drug.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:drug animated:YES];
    }else if (indexPath.row==4){
        
    }else if (indexPath.row==5){
        
    }
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10,10);
}
#pragma mark --懒加载
- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}
//获取网络数据
-(void)getNetWork
{
    [SVProgressHUD show];
    //创建请求管理器
    AFHTTPSessionManager *manger=[AFHTTPSessionManager manager];

    NSString *url=@"http://api.map.baidu.com/telematics/v3/weather";
    NSMutableDictionary *params=[NSMutableDictionary dictionary];
    params[@"location"]=@"苏州";
    params[@"output"]=@"json";
    params[@"ak"]=@"kXCozgObKhiuHs914qgMwLej";
    params[@"mcode"]=@"itany";
    
    [manger GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject:%@",responseObject);

        
        if (![responseObject[@"error"] boolValue]) {
            [SVProgressHUD dismiss];
            NSArray *tmp=responseObject[@"results"];
            NSDictionary *dictData=tmp[0];
            //获取数据
            dateLb.text = [NSString stringWithFormat:@"日期：%@",[responseObject objectForKey:@"date"]];
            NSArray *arr = dictData[@"weather_data"];
            
            NSDictionary *dict = [arr objectAtIndex:0];
            
            weatherLb.text =[NSString stringWithFormat:@"天气：%@",[dict objectForKey:@"weather"]] ;
            temperLb.text =[NSString stringWithFormat:@"气温：%@", [dict objectForKey:@"temperature"]];
            windLb.text =[NSString stringWithFormat:@"风向：%@", [dict objectForKey:@"wind"]];
            
            [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"dayPictureUrl"]]] options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                dayImgV.image = image;
            }];
            [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dict objectForKey:@"nightPictureUrl"]]] options:SDWebImageRetryFailed progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                nightImgV.image = image;
            }];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showWithStatus:@"获取失败"];
        NSLog(@"数据获取失败，%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
