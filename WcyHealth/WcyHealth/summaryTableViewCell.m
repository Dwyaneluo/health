//
//  summaryTableViewCell.m
//  WcyHealth
//
//  Created by subang on 17/4/17.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "summaryTableViewCell.h"

@implementation summaryTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpCell];
    }
    return self;
}
-(void)setUpCell{
    _bgView = [UIView new];
    [self addSubview:_bgView];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self);
    }];
    
    _statusLb = [UILabel new];
    _statusLb.font = [UIFont boldSystemFontOfSize:13];
    _statusLb.backgroundColor = [UIColor redColor];
    _statusLb.textColor = [UIColor whiteColor];
    _statusLb.text = @"异";
    [_bgView addSubview:_statusLb];
    [_statusLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bgView.mas_centerY);
        make.left.equalTo(_bgView.mas_left).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    _titleLb = [UILabel new];
    _titleLb.font = [UIFont boldSystemFontOfSize:15];
    [_bgView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bgView.mas_centerY);
        make.left.equalTo(_statusLb.mas_right).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(150, 15));
    }];
    
    
    _indexLb = [UILabel new];
    _indexLb.font = [UIFont boldSystemFontOfSize:15];
    _indexLb.textColor = [UIColor redColor];
    [_bgView addSubview:_indexLb];
    [_indexLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgView.mas_top).with.offset(5);
        make.left.equalTo(_titleLb.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(150, 15));
    }];
    
    
    _normalLb = [UILabel new];
    _normalLb.font = [UIFont boldSystemFontOfSize:15];
    _normalLb.textColor = UIColorFromHexValue(0xBCBCBC);
    [_bgView addSubview:_normalLb];
    [_normalLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_indexLb.mas_bottom).with.offset(5);
        make.left.equalTo(_indexLb.mas_left);
        make.size.mas_equalTo(CGSizeMake(150, 15));
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
