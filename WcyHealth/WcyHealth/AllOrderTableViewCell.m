//
//  AllOrderTableViewCell.m
//  WcyHealth
//
//  Created by 天涯 on 2017/3/28.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "AllOrderTableViewCell.h"
#import "OrderInfo.h"
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
    
    _state = [UILabel new];
    _state.font = [UIFont systemFontOfSize:13];
    _state.textAlignment=NSTextAlignmentRight;
    [self addSubview:_state];
    [_state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.centerY.equalTo(_title.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(60, 15));
    }];
    
    
    _price = [UILabel new];
    _price.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:_price];
    [_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_icon.mas_right).with.offset(10);
        make.top.equalTo(_title.mas_bottom).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(150, 20));
    }];
    
    _againBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _againBtn.layer.masksToBounds=YES;
    _againBtn.layer.cornerRadius=5;
    _againBtn.layer.borderWidth=1;
    [_againBtn addTarget:self action:@selector(againBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _againBtn.layer.borderColor=UIColorFromHexValue(0x006FFF).CGColor;
    [self addSubview:_againBtn];
    [_againBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
}
- (void)setValueToCell:(OrderInfo*)info{
    self.orderInfo = info;
    _icon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",info.orderimage]];
    _title.text = info.ordertitle;
    _price.text = [NSString stringWithFormat:@"实付款：¥%@",info.ordermoney];
    _state.text = info.orderstate;
    if ([info.orderstate isEqualToString:@"已完成"]) {
        [_againBtn setTitle:@"再次购买" forState:UIControlStateNormal];
    }else{
        [_againBtn setTitle:@"重新购买" forState:UIControlStateNormal];
    }
}
#pragma mark-  按钮点击事件
- (void)againBtnClick{
    [self.delegate cellBtnclick:self.orderInfo];
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
