//
//  OrderInfo.h
//  InternetOflaundryDemo
//
//  Created by AppleUser on 15/12/17.
//  Copyright © 2015年 AppleUser. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderInfo : NSObject
@property (nonatomic,copy) NSString *ordernum;//订单号
@property (nonatomic,copy) NSString *orderstate;//订单状态
@property (nonatomic,copy) NSNumber *ordermoney;//订单折扣金额
@property (nonatomic,copy) NSNumber *orderoldmoney;//订单原来金额
@property (nonatomic,copy) NSString *ordertime;//订单时间
@property (nonatomic,copy) NSString *ordertitle;//订单标题
@property (nonatomic,copy) NSString *orderdetail;//订单描述
@property (nonatomic,copy) NSString *orderimage;//订单图片
@property (nonatomic,copy) NSString *ordersum;//订单人数
@property (nonatomic,copy) NSString *name;//姓名
@property (nonatomic,copy) NSString *idcard;//身份证
@property (nonatomic,copy) NSString *gender;//性别
@property (nonatomic,copy) NSString *married;//婚否
@property (nonatomic,copy) NSString *phone;//手机号
@end
