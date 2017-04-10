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
        make.centerX.equalTo(bgView.mas_centerX);
        make.left.equalTo(bgView.mas_left).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    _titleLb = [UILabel new];
    _titleLb.font = [UIFont boldSystemFontOfSize:14];
    _titleLb.numberOfLines=2;
    [bgView addSubview:_titleLb];
    [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top).with.offset(10);
        make.left.equalTo(_imageV.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-130, 35));
    }];
    
    _detailLb = [UILabel new];
    _detailLb.font = [UIFont systemFontOfSize:13];
    _detailLb.numberOfLines=0;
    [bgView addSubview:_detailLb];
    [_detailLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLb.mas_bottom).with.offset(10);
        make.left.equalTo(_imageV.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-130, 60));
    }];
}
- (void)countCellHeight:(NSDictionary *)dict{
    self.titleLb.text = [dict objectForKey:@"title"];
    self.detailLb.text = [dict objectForKey:@"description"];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://tnfs.tngou.net/image%@_100x100",dict[@"img"]]] placeholderImage:nil];
    CGSize size = [MBUtilities countString:self.detailLb.text size:CGSizeMake(ScreenWidth-140, MAXFLOAT) fontSize:13];
    [_detailLb mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenWidth-130, size.height+5));
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
