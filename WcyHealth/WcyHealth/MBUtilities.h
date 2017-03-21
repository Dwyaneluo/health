//
//  MBSUtilities.h
//  MBSMediaGroup
//
//  Created by Johnny on 10-9-11.
//  Copyright 2010 MobiShift. All rights reserved.
//
#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>

@interface MBUtilities : NSObject {

}

+ (void)showMessage:(NSString *)msg;
+ (void)showMessage:(NSString *)msg withTitle:(NSString*)title;
+ (void)showMessage:(NSString *)msg withBlock:(void(^)(void))block;

+(NSString*) SHA1:(NSString*)input;

+ (NSString*)NSDateToNSString:(NSDate*)date;
+ (NSDate*)NSStringToNSDate:(NSString*)string;
+ (NSString*)NSDateTimeToNSString:(NSDate*)date;
+ (NSDate*)NSStringToNSDateTime:(NSString*)string;
+ (NSString *)changeDateEffectiveFormat:(NSInteger)date;
+ (NSString *)timerTransformToString:(NSInteger)atime;

+ (NSString*)stringWithURLEncode:(NSString*)inputstr;

+(BOOL)emailCheck:(NSString*)email;
+(BOOL)phoneNumCheck:(NSString*)phone;
+(BOOL)passwordCheck:(NSString*)pwd;
+(BOOL)userNameCheck:(NSString*)name;
+(BOOL)nickNameCheck:(NSString*)name;
+(BOOL)displayNameCheck:(NSString*)name;
+(BOOL)priceCheck:(NSString*)name;

+(NSString *)getCachePath:(NSString*)name;
+(UIImage*)resizeImage:(UIImage*)img withSize:(CGSize)newSize;

+(NSString *)generateUUID;
+(BOOL)TaskNameCheck:(NSString*)name;
+(NSString*)jsonConvertToString:(id)sender;
+(id)stringConvertToJSON:(NSString*)str;
+(id)stringGB2312ConvertToJSON:(NSString*)str;

+(NSString *) docDirectoryPath;
+(NSString *) archiveFilePath;
+(BOOL)isFileExistWithPath:(NSString*)filepath;
+(BOOL)deleteFileWithPath:(NSString*)filepath;

+(UIColor *) colorWithImage: (NSString *) imgname;
+(UIColor *) colorWithHexString: (NSString *) stringToConvert;

+ (void)sendLocalPush:(NSString*)push;

+(UIImage *)screenShotFrom:(UIView *)view frame:(CGRect)frame;

+ (void)printViewHierarchy:(UIView *)v;

+ (UIImage*)compressJPGImage:(UIImage*)original withinSize:(NSUInteger)size;
+ (UIImage*)compressPNGImage:(UIImage*)original withinSize:(NSUInteger)size;

+ (NSString *)changeChatListDateFormat:(NSInteger)date;
+ (NSString *)changeDateFormat:(NSInteger)date;
+ (NSString *)changeDistanceFormat:(NSString *)distance;

+ (void)showMessage:(NSString *)msg withTitle:(NSString*)title forceOK:(BOOL)forceOK withBlock:(void(^)(void))block withfBlock:(void(^)(void))fblock;
+(float)fileSizeAtPath:(NSString *)path;
//截屏
+ (UIImage *)imageFromView: (UIView *) theView;
//post show time change froamt
+(NSString *)timerTransform:(NSDate *)date;
//压缩图片
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
//garyImage
+ (UIImage*)grayscale:(UIImage*)anImage type:(int)type;

+ (CGSize)countString:(NSString *)str size:(CGSize)size fontSize:(NSInteger)fontSize;
+ (CGSize)countString:(NSString *)str size:(CGSize)size font:(UIFont*)font;
+ (void)showToastWith:(NSString *)msg;

+ (void)showTosatOnNacigationBarWith:(NSString *)msg type:(NSString *)type;

//颜色自右上到坐下的渐变
+(UIImage *)gradientColorImageFromColors:(NSArray*)colors imgSize:(CGSize)imgSize type:(NSString *)type;
//账号登出
+(void)accountsLogout;

+(NSString *) md5: (NSString *) inPutText;

+ (NSString*)dictionaryToJson:(NSDictionary *)dic;


@end
