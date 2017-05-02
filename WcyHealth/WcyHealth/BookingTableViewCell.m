//
//  BookingTableViewCell.m
//  WcyHealth
//
//  Created by 天涯 on 2017/3/29.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "BookingTableViewCell.h"

@implementation BookingTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpCell];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}
- (void)setUpCell{
    _icon = [UIImageView new];
    [self addSubview:_icon];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 60));
    }];
    
    _title = [UILabel new];
    _title.font = [UIFont boldSystemFontOfSize:17];

    [self addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(10);
        make.top.equalTo(self.mas_top).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    _oldPrice = [UILabel new];
    _oldPrice.font = [UIFont boldSystemFontOfSize:15];

    [self addSubview:_oldPrice];
    [_oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(10);
        make.top.equalTo(_title.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    
    _bookingNum = [UILabel new];
    _bookingNum.font = [UIFont boldSystemFontOfSize:15];

    [self addSubview:_bookingNum];
    [_bookingNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_oldPrice.mas_right).with.offset(10);
        make.top.equalTo(_title.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 20));
    }];
    
    _price = [UILabel new];
    _price.font = [UIFont boldSystemFontOfSize:15];
    _price.textColor = [UIColor redColor];
    _price.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(10);
        make.top.equalTo(_oldPrice.mas_bottom).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
}
-(void)setValueToCell:(NSDictionary *)dict{
    _icon.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",dict[@"image"]]];
    _title.text = [NSString stringWithFormat:@"%@",dict[@"title"]];
    _oldPrice.text =  [NSString stringWithFormat:@"原价：¥%@",dict[@"oldprice"]];
    _bookingNum.text = [NSString stringWithFormat:@"%@人已预约",dict[@"sum"]];
    _price.text = [NSString stringWithFormat:@"现价：¥%@",dict[@"newprice"]];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
