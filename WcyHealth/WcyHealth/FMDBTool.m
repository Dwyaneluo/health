//
//  FMDBTool.m
//  InternetOflaundryDemo
//
//  Created by AppleUser on 15/12/17.
//  Copyright © 2015年 AppleUser. All rights reserved.
//

#import "FMDBTool.h"

@implementation FMDBTool
static FMDatabaseQueue *fmq;
static BOOL rs;
static NSMutableArray *arr;

+(void)initialize
{

    //创建数据库
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docpath = [paths objectAtIndex:0];
    NSString *path=[docpath stringByAppendingPathComponent:@"data.db"];
    // 2、判断数据库文件夹是否存在.不存在则创建
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL tag = [manager fileExistsAtPath:path isDirectory:NULL];
        if (!tag) {
           
            [manager createFileAtPath:path contents:nil attributes:nil];
        }
     NSLog(@"-----------%d-----------------",tag);
    
    fmq=[FMDatabaseQueue databaseQueueWithPath:path];
    [fmq inDatabase:^(FMDatabase *db) {
        rs=[db executeUpdate:@"create table if not exists user (id integer primary key autoincrement,phonenum text,password text);"];
        if (rs) {
            NSLog(@"查找用户表成功");
        }else{
            NSLog(@"查找用户表失败");
        }
        rs=[db executeUpdate:@"create table if not exists orde (ordersum text,orderimage text,ordernum text ,orderstate text,ordertime text,ordermoney integer,orderoldmoney integer,ordertitle text,orderdetail text,name text,idcard text,gender text,married text,phone text);"];
        if (rs) {
            NSLog(@"查找订单表成功");
        }else{
            NSLog(@"查找订单表失败");
        }
    }];

}
#pragma mark -判断用户帐号密码是否输入正确
+(BOOL)selectWithInfo:(NSString *)username password:(NSString *)password
{
    arr=[NSMutableArray new];
    [fmq inDatabase:^(FMDatabase *db) {
        NSString *sql=@"select * from user where phonenum = ? and password = ?";
        FMResultSet *re=[db executeQuery:sql,username,password];
        while (re.next) {
            NSString *username=[re stringForColumn:@"phonenum"];
            [arr addObject:username];
        }
    }];
    return arr.count;
}
#pragma mark -注册用户
+(BOOL)addUser:(User*)user
{
    arr=[NSMutableArray new];
    [fmq inDatabase:^(FMDatabase *db) {
        NSString *sql=@"insert into user (phonenum,password) values (?,?);";
        rs=[db executeUpdate:sql,user.phonenum,user.password];
        if (rs) {
            NSLog(@"注册用户成功");
        }
        else
        {
            NSLog(@"注册用户失败");
        }
    }];
    return rs;
}
#pragma mark -修改用户密码
+(BOOL)changePasswordForUser:(NSString*)phonenum newPassword:(NSString *)password
{
    [fmq inDatabase:^(FMDatabase *db) {
        NSString *sql=@"update user set password = ? where phonenum = ? ;";
        BOOL rs=[db executeUpdate:sql,password,phonenum];
        if (rs) {
            NSLog(@"修改密码成功");
        }
        else
        {
            NSLog(@"修改密码失败");
        }
        
    }];
    return rs;
    
}
#pragma mark -判断是否已注册用户
+(BOOL)selectWithUserName:(NSString*)username
{
    arr=[NSMutableArray new];
    [fmq inDatabase:^(FMDatabase *db) {
        NSString *sql=@"select * from user where phonenum=?";
        FMResultSet *re=[db executeQuery:sql,username];
        while (re.next) {
            User *u=[User new];
            u.phonenum=[re stringForColumn:@"phonenum"];
            u.password=[re stringForColumn:@"password"];
            [arr addObject:u];
        }
    }];
    return arr.count;
}
#pragma mark -获取所有用户
+(NSArray *)getAllUser
{
    arr=[NSMutableArray new];
    [fmq inDatabase:^(FMDatabase *db) {
        NSString *sql=@"select * from user";
        FMResultSet *re=[db executeQuery:sql];
        while (re.next) {
            User *u=[User new];
            u.phonenum=[re objectForColumnName:@"phonenum"];
            u.password=[re stringForColumn:@"password"];
            [arr addObject:u];
        }
    }];
    return arr;

}
#pragma mark -增加订单
+(BOOL)addOrder:(OrderInfo*)order
{
    arr=[NSMutableArray new];
    [fmq inDatabase:^(FMDatabase *db) {
        NSString *sql=@"insert into orde (ordersum,orderimage,ordernum,orderstate,ordertime,ordermoney,orderoldmoney,ordertitle,orderdetail,name,idcard,gender,married,phone) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
        rs=[db executeUpdate:sql,order.ordersum,order.orderimage,order.ordernum,order.orderstate,order.ordertime,order.ordermoney,order.orderoldmoney,order.ordertitle,order.orderdetail,order.name,order.idcard,order.gender,order.married,order.phone];
        if (rs) {
            NSLog(@"订单插入成功");
        }
        else
        {
            NSLog(@"订单插入失败");
        }
    }];
    return rs;
}
#pragma mark -删除订单
+(BOOL)deleteOrderForOrdernum:(NSString*)ordernum
{
    [fmq inDatabase:^(FMDatabase *db) {
        NSString *sql=@"delete from orde where ordernum = ? ;";
        BOOL rs=[db executeUpdate:sql,ordernum];
        if (rs) {
            NSLog(@"删除成功");
        }
        else
        {
            NSLog(@"删除失败");
        }
        
    }];
    return rs;

}
#pragma mark -修改订单状态
+(BOOL)changeOrderForOrderID:(NSString*)ordernum state:(NSString *)state
{
    [fmq inDatabase:^(FMDatabase *db) {
        NSString *sql=@"update orde set orderstate = ? where ordernum = ? ;";
        BOOL rs=[db executeUpdate:sql,state,ordernum];
        if (rs) {
            NSLog(@"修改成功");
        }
        else
        {
            NSLog(@"修改失败");
        }
        
    }];
    return rs;
    
}
#pragma mark -获取所有订单
+(NSArray*)getAllOrder
{
    arr=[NSMutableArray new];
    [fmq inDatabase:^(FMDatabase *db) {
        NSString *sql=@"select * from orde";
        FMResultSet *re=[db executeQuery:sql];
        while (re.next) {
            OrderInfo *o=[OrderInfo new];
            o.ordernum=[re objectForColumnName:@"ordernum"];
            o.orderstate=[re stringForColumn:@"orderstate"];
            o.ordertime=[re stringForColumn:@"ordertime"];
            o.ordermoney=[re objectForColumnName:@"ordermoney"];
            o.orderimage=[re stringForColumn:@"orderimage"];
            o.ordersum=[re objectForColumnName:@"ordersum"];
            o.orderoldmoney=[re objectForColumnName:@"orderoldmoney"];
            o.ordertitle=[re objectForColumnName:@"ordertitle"];
            o.orderdetail=[re objectForColumnName:@"orderdetail"];
            o.name=[re objectForColumnName:@"name"];
            o.idcard=[re objectForColumnName:@"idcard"];
            o.phone=[re objectForColumnName:@"phone"];
            o.gender=[re objectForColumnName:@"gender"];
            o.married=[re objectForColumnName:@"married"];
            [arr addObject:o];
        }
    }];
    return arr;
}
#pragma mark -获取已完成或未完成订单
+(NSArray*)getFinishOrder:(NSString *)string
{
    arr=[NSMutableArray new];
    [fmq inDatabase:^(FMDatabase *db) {
        NSString *sql=@"select * from orde where orderstate = ?";
        FMResultSet *re=[db executeQuery:sql,string];
        while (re.next) {
            OrderInfo *o=[OrderInfo new];
            o.ordernum=[re objectForColumnName:@"ordernum"];
            o.orderstate=[re stringForColumn:@"orderstate"];
            o.ordertime=[re stringForColumn:@"ordertime"];
            o.ordermoney=[re objectForColumnName:@"ordermoney"];
            o.orderimage=[re stringForColumn:@"orderimage"];
            o.ordersum=[re objectForColumnName:@"ordersum"];
            o.orderoldmoney=[re objectForColumnName:@"orderoldmoney"];
            o.ordertitle=[re objectForColumnName:@"ordertitle"];
            o.orderdetail=[re objectForColumnName:@"orderdetail"];
            o.name=[re objectForColumnName:@"name"];
            o.idcard=[re objectForColumnName:@"idcard"];
            o.phone=[re objectForColumnName:@"phone"];
            o.gender=[re objectForColumnName:@"gender"];
            o.married=[re objectForColumnName:@"married"];
            [arr addObject:o];
        }
    }];
    return arr;
}
@end
