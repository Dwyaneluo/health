//
//  AllOrderTableViewCell.h
//  WcyHealth
//
//  Created by 天涯 on 2017/3/28.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol cellBtnClickDelegate <NSObject>

- (void)cellBtnclick:(OrderInfo*)info;

@end
@interface AllOrderTableViewCell : UITableViewCell
@property (nonatomic,strong)id<cellBtnClickDelegate> delegate;
@property (nonatomic,strong)UIImageView *icon;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UILabel *price;
@property (nonatomic,strong)UILabel *state;
@property (nonatomic,strong)UIButton *againBtn;
@property (nonatomic,strong)OrderInfo* orderInfo;
- (void)setValueToCell:(OrderInfo*)info;
@end
