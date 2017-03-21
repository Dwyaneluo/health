//
//  WcyAdSplashImgView.m
//  WcyHealth
//
//  Created by 天涯 on 2017/2/18.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "WcyAdSplashImgView.h"

@implementation WcyAdSplashImgView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self addSkipButton];
    }
    return self;
}
- (void)addSkipButton
{
    self.skipBtn = [[UIButton alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-50, [UIScreen mainScreen].bounds.size.height-30, 50, 30)];
    self.skipBtn.backgroundColor = [UIColor darkGrayColor];
    [self.skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
    self.skipBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    self.skipBtn.alpha = 0.7;
    [self.skipBtn setTintColor:[UIColor whiteColor]];
    [self.skipBtn addTarget:self action:@selector(viewDismiss) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.skipBtn];
}
- (void)viewDismiss
{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.dismissAction();
        
    }];
}

@end
