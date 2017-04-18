//
//  AppDelegate.m
//  WcyHealth
//
//  Created by 天涯 on 2017/1/8.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import "InformationViewController.h"
#import "FunctionViewController.h"
#import "MyCenterViewController.h"
#import "WcyAdSplashImgView.h"
#import "IQKeyboardManager.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
@interface AppDelegate ()

@property (strong, nonatomic) WcyAdSplashImgView *splashView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [IQKeyboardManager sharedManager].enable=YES;
    //1.创建Window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    //a.初始化一个tabBar控制器
    UITabBarController *tb=[[UITabBarController alloc]init];
    //设置控制器为Window的根控制器
    
    self.window.rootViewController=tb;
     //b.创建子控制器
    HomeViewController *home=[[HomeViewController alloc]init];
    self.srnav = [[UINavigationController alloc] initWithRootViewController:home];
    home.view.backgroundColor=UIColorFromHexValue(0xf4f4f4);
    home.tabBarItem.title=@"首页";
    home.title=@"首页";
    home.tabBarItem.image=[UIImage imageNamed:@"4"];
    home.tabBarItem.image=[home.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    InformationViewController *inform=[[InformationViewController alloc]init];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:inform];
    inform.tabBarItem.title=@"资讯";
    inform.view.backgroundColor=UIColorFromHexValue(0xf4f4f4);
    inform.title=@"资讯";
    inform.tabBarItem.image=[UIImage imageNamed:@"2"];
    inform.tabBarItem.image=[inform.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    FunctionViewController *func=[[FunctionViewController alloc]init];
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:func];
    func.view.backgroundColor=UIColorFromHexValue(0xf4f4f4);
    func.tabBarItem.title=@"订单";
    func.title=@"订单";
    func.tabBarItem.image=[UIImage imageNamed:@"3"];
    func.tabBarItem.image=[func.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   
    MyCenterViewController *my=[[MyCenterViewController alloc]init];
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:my];
    my.view.backgroundColor=UIColorFromHexValue(0xf4f4f4);
    my.tabBarItem.title=@"我的";
    my.title=@"个人中心";
    my.tabBarItem.image=[UIImage imageNamed:@"1"];
    my.tabBarItem.image=[my.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tb.viewControllers=@[self.srnav,nav2,nav3,nav4];
    
    UIView *mView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth ,48)];//这是整个tabbar的颜色
    
    [mView setBackgroundColor:[UIColor whiteColor]];
    
    [tb.tabBar insertSubview:mView atIndex:0];
    mView.alpha=1;
    
    
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
     AppDelegate *app=[UIApplication sharedApplication].delegate;
    
    //广告页的实现
    self.splashView= [[WcyAdSplashImgView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.splashView.image = [UIImage imageNamed:@"Yosemite02.jpg"];
    AppDelegate __weak* weakSelf = self;
    self.splashView.dismissAction = ^(void) {
        [weakSelf.splashView removeFromSuperview];
        weakSelf.splashView = nil;
    };
    [app.window addSubview:self.splashView];
    //            [self performSelectorOnMainThread:@selector(removePromotion2) withObject:nil waitUntilDone:NO];
    [self performSelector:@selector(splashCacheDismiss) withObject:nil afterDelay:2.0];
}
//#pragma mark-广告页和引导页的展示
- (void)splashCacheDismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.splashView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.splashView removeFromSuperview];
        self.splashView = nil;
    }];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
