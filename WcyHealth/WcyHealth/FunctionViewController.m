//
//  FunctionViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/1/8.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "FunctionViewController.h"


@interface FunctionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    UICollectionView *CollView;
}
@end

@implementation FunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"功能";
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake((ScreenWidth-40)/4, (ScreenWidth-40)/4);
    CollView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) collectionViewLayout:layout];
    CollView.delegate=self;
    CollView.dataSource=self;
    CollView.backgroundColor=[UIColor whiteColor];
    [CollView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.view addSubview:CollView];
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 9;
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
        label.text = @"健康体检";
    }else if (indexPath.row==2){
        image.image = [UIImage imageNamed:@"2"];
        label.text = @"健康评估";
    }else if (indexPath.row==3){
        image.image = [UIImage imageNamed:@"2"];
        label.text = @"健康干预";
    }else if (indexPath.row==4){
        image.image = [UIImage imageNamed:@"2"];
        label.text = @"常规检查";
    }else if (indexPath.row==5){
        image.image = [UIImage imageNamed:@"2"];
        label.text = @"常规检查";
    }else if (indexPath.row==6){
        image.image = [UIImage imageNamed:@"2"];
        label.text = @"常规检查";
    }else if (indexPath.row==7){
        image.image = [UIImage imageNamed:@"2"];
        label.text = @"常规检查";
    }else if (indexPath.row==8){
        image.image = [UIImage imageNamed:@"2"];
        label.text = @"常规检查";
    }
    
    return cell;
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10,10);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
