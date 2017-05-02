//
//  MBSUtilities.m
//  MBSMediaGroup
//
//  Created by Johnny on 10-9-11.
//  Copyright 2010 MobiShift. All rights reserved.
//

#import "MBUtilities.h"


#import <CommonCrypto/CommonDigest.h>


#define kDEFAULT_DATE_TIME_FORMAT (@"yyyy-MM-dd HH:mm")
#define kDEFAULT_DATE_FORMAT (@"yyyy-MM-dd")

@implementation MBUtilities

+(UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString]; //去掉前后空格换行符
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor redColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor redColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];  //扫描16进制到int
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (void)sendLocalPush:(NSString*)push {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = push;
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}
+ (CGSize)countString:(NSString *)str size:(CGSize)size fontSize:(NSInteger)fontSize
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize newSize;
    newSize = [str boundingRectWithSize:CGSizeMake(size.width,size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return newSize;
}
+ (CGSize)countString:(NSString *)str size:(CGSize)size font:(UIFont*)font
{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    CGSize newSize;
    newSize = [str boundingRectWithSize:CGSizeMake(size.width,size.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    return newSize;
}
//帐号登出
+(void)accountsLogout{
    [[MBPreferenceManager sharedPreferenceManager] setLoginState:NO];
    [[MBPreferenceManager sharedPreferenceManager] setPhone:@""];
    [[MBPreferenceManager sharedPreferenceManager] setPassword:@""];

}

@end
