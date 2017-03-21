//
//  WcyAdSplashImgView.h
//  WcyHealth
//
//  Created by 天涯 on 2017/2/18.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^SRSplashDismissBlock)();

@interface WcyAdSplashImgView : UIImageView

@property (nonatomic, strong)UIButton *skipBtn;

@property (nonatomic, copy) SRSplashDismissBlock dismissAction;
@end
