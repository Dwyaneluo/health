//
//  BookingTableViewCell.h
//  WcyHealth
//
//  Created by 天涯 on 2017/3/29.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookingTableViewCell : UITableViewCell
@property (nonatomic,strong)UIImageView *icon;
@property (nonatomic,strong)UILabel *title;
@property (nonatomic,strong)UILabel *price;
@property (nonatomic,strong)UILabel *bookingNum;
@property (nonatomic,strong)UILabel *oldPrice;
-(void)setValueToCell:(NSDictionary *)dict;
@end
