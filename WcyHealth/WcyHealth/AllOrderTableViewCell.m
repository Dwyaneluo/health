//
//  AllOrderTableViewCell.m
//  WcyHealth
//
//  Created by 天涯 on 2017/3/28.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "AllOrderTableViewCell.h"

@implementation AllOrderTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpCell];
    }
    return self;
}
- (void)setUpCell{
    _icon = [UIImageView new];
    _icon.backgroundColor = [UIColor redColor];
    [self addSubview:_icon];
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(80, 60));
    }];
    
    _title = [UILabel new];
    _title.font = [UIFont boldSystemFontOfSize:17];
    _title.text = @"常规体检套餐（女已婚）";
    [self addSubview:_title];
    [_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(10);
        make.top.equalTo(self.mas_top).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];
    
    _price = [UILabel new];
    _price.font = [UIFont boldSystemFontOfSize:15];
    _price.text = @"实付款：¥699.00";
    [self addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(10);
        make.top.equalTo(_title.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    _againBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_againBtn setTitle:@"再次购买" forState:UIControlStateNormal];
    [self addSubview:_againBtn];
    [_againBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
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
