//
//  FMDBTool.h
//  InternetOflaundryDemo
//
//  Created by AppleUser on 15/12/17.
//  Copyright © 2015年 AppleUser. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "FMDB.h"
#import "OrderInfo.h"
#import "User.h"
@interface FMDBTool : NSObject
+(BOOL)selectWithInfo:(NSString*)username password:(NSString*)password;//登陆判断
+(BOOL)addUser:(User*)user;//注册用户
+(NSArray*)getAllUser;//获取所有用户
+(BOOL)selectWithUserName:(NSString*)username;//判断用户是否已经注册
+(BOOL)addOrder:(OrderInfo*)order;//增加订单
+(BOOL)deleteOrderForOrdernum:(NSNumber*)number;//删除订单根据订单号
+(BOOL)changeOrderForOrderID:(NSString*)ordernum state:(NSString *)state;//修改订单状态
+(NSArray*)getAllOrder;//获取所有订单
+(NSArray*)getFinishOrder:(NSString *)string;//获取已完成订单，或未完成订单


@end
