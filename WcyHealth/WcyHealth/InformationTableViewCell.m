//
//  InformationTableViewCell.m
//  WcyHealth
//
//  Created by 天涯 on 2017/4/9.
//  Copyright © 2017年 tianya. All rights reserved.
//

#import "InformationTableViewCell.h"

@implementation InformationTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpCell];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}
- (void)setUpCell{
    UIView* bgView = [UIView new];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(bgView);
    }];
    
    _imageV = [UIImageView new];
    [bgView addSubview:_imageV];
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top).with.offset(10);
        make.left.equalTo(bgView.mas_left).with.offset(10);
        make.bottom.equalTo(bgView.mas_bottom).with.offset(-10);
        make.width.mas_equalTo(@100);
    }];
    
    _titleLb = [UILabel new];
    _titleLb.font = [UIFont boldSystemFontOfSize:14];
    _titleLb.numberOfLines=2;
    [bgView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top).with.offset(10);
        make.left.equalTo(_imageV.mas_right).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-140, 30));
    }];
    
    _detailLb = [UILabel new];
    _detailLb.font = [UIFont systemFontOfSize:13];
    _detailLb.numberOfLines=3;
    [bgView addSubview:_detailLb];
    [_detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLb.mas_bottom).with.offset(5);
        make.left.equalTo(_imageV.mas_right).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-140, 60));
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
