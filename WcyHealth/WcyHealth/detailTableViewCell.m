//
//  detailTableViewCell.m
//  WcyHealth
//
//  Created by subang on 17/4/17.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "detailTableViewCell.h"

@implementation detailTableViewCell
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
    
    _titleLb = [UILabel new];
    _titleLb.font = [UIFont systemFontOfSize:16];
    _titleLb.text = @"身高";
    [_bgView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bgView);
        make.left.equalTo(_bgView.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake((ScreenWidth-20)/2, 15));
    }];
    
    _detailLb = [UILabel new];
    _detailLb.font = [UIFont systemFontOfSize:16];
    _detailLb.text = @"172.00";
    [_bgView addSubview:_detailLb];
    [_detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bgView);
        make.left.equalTo(_titleLb.mas_right);
        make.size.mas_equalTo(CGSizeMake((ScreenWidth-20)/2, 15));
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
