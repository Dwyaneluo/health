//
//  MyCenterViewController.m
//  WcyHealth
//
//  Created by 天涯 on 2017/1/8.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "MyCenterViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "medicalReportViewController.h"
#import "PersonInfoViewController.h"
#import "ChangePasswordViewController.h"
@interface MyCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView *table;
    UIImage *avatarImage;
}
@end

@implementation MyCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self createView];
}
-(void)createView {
    table=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:table];
    table.delegate=self;
    table.dataSource=self;
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    table.tableFooterView =[UIView new];
    table.backgroundColor = UIColorFromHexValue(0xf4f4f4);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [table reloadData];
}
#pragma mark- 
#pragma mark- 设置头像
- (void)AvatarImageClick{
    if (IS_LOGIN!=YES) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"还未登录账号" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self presentViewController:[LoginViewController new] animated:YES completion:nil];
        }];
        UIAlertAction *cancel =  [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"设置头像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
        UIImagePickerController *ImgPicker = [[UIImagePickerController alloc] init];
        ImgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        ImgPicker.allowsEditing = YES;
        ImgPicker.delegate = self;
        [self presentViewController:ImgPicker animated:YES completion:nil];
    }];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *ImgPicker = [[UIImagePickerController alloc] init];
            ImgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            ImgPicker.allowsEditing = YES;
            ImgPicker.delegate = self;
            [self presentViewController:ImgPicker animated:YES completion:nil];
        } else {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示消息" message:@"没有相机设备" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alert addAction:action];
    [alert addAction:action1];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark- 相册选择代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    UIImage *avatar = [info valueForKey:UIImagePickerControllerEditedImage];
    avatarImage = [self imageCompressForWidth:avatar targetWidth:300.0];
    NSData *data = [NSData new];
    if(UIImagePNGRepresentation(avatarImage)){
        /*判断图片是不是png格式的文件*/
        data = UIImagePNGRepresentation(avatarImage);
    }else{
        /*判断图片是不是jpeg格式的文件*/
        data = UIImageJPEGRepresentation(avatarImage,1.0);
    }
    [[MBPreferenceManager sharedPreferenceManager] setAvatar:data];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [table reloadData];
}
//处理图片
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}
#pragma mark- tablview delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section!=0){
        return 10;
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        return 100;
    }
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * celLStr= @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celLStr];
    if (cell!=nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:celLStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UILabel *title =[UILabel new];
        title.textColor = [UIColor blackColor];
        title.font = [UIFont systemFontOfSize:16];
        [cell addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cell.mas_left).with.offset(55);
            make.centerY.equalTo(cell.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(150, 20));
        }];
        
        UIButton *image = [UIButton new];
        
  
        
        
        [cell addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_centerY);
            make.left.equalTo(cell.mas_left).with.offset(15);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        
        if (indexPath.section==0){
            if (indexPath.row==0) {
                //给头像添加点击事件
                [image addTarget:self action:@selector(AvatarImageClick) forControlEvents:UIControlEventTouchUpInside];
                [image setImage:[UIImage imageNamed:@"默认头像"] forState:UIControlStateNormal];
                image.layer.masksToBounds=true;
                image.layer.cornerRadius=40;
                [image mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_equalTo(CGSizeMake(80, 80));
                }];
                [title mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(cell.mas_left).with.offset(105);
                }];
                title.text = @"点击登陆";
                if (IS_LOGIN==YES) {
                    title.text = [NSString stringWithFormat:@"用户%@",[[MBPreferenceManager sharedPreferenceManager] getPhone]];
                    if ([[MBPreferenceManager sharedPreferenceManager] getAvatar]!=nil) {
                        [image setImage:[UIImage imageWithData:[[MBPreferenceManager sharedPreferenceManager] getAvatar]] forState:UIControlStateNormal];
                    }
                    if (avatarImage!=nil) {
                        [image setImage:avatarImage forState:UIControlStateNormal];
                    }
                    
                }
                

            }else if(indexPath.row==1){
                [image setImage:[UIImage imageNamed:@"personalpage_ongoing"] forState:UIControlStateNormal];
                title.text = @"我的报告";
            }else if(indexPath.row==2){
                [image setImage:[UIImage imageNamed:@"personalpage_ongoing"] forState:UIControlStateNormal];
                title.text = @"我的订单";
            }else if(indexPath.row==3){
                [image setImage:[UIImage imageNamed:@"personalpage_setting"] forState:UIControlStateNormal];
                title.text = @"修改密码";
            }
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
            title.text = @"账号退出";
            title.font = [UIFont boldSystemFontOfSize:18];
            title.textColor = [UIColor redColor];
            [title mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.centerY.equalTo(cell);
            }];
        }
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (IS_LOGIN!=YES) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示信息" message:@"还未登录账号" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self presentViewController:[LoginViewController new] animated:YES completion:nil];
        }];
        UIAlertAction *cancel =  [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if (indexPath.section==0){
        if (indexPath.row==0) {
            PersonInfoViewController *person = [PersonInfoViewController new];
            person.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:person animated:YES];
        }else if(indexPath.row==1){
            medicalReportViewController *medical = [medicalReportViewController new];
            medical.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:medical animated:YES];
        }else if(indexPath.row==2){
            self.tabBarController.selectedIndex = 2;
        }else if(indexPath.row==3){
            ChangePasswordViewController *change = [ChangePasswordViewController new];
            [self.navigationController pushViewController:change animated:YES];
        }
    }else{
        [MBUtilities accountsLogout];
        [self presentViewController:[LoginViewController new] animated:YES completion:nil];
        
    }
}
@end
