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



+ (NSString*)NSDateToNSString:(NSDate*)date
{   
	if (date == nil) {
		return nil;
	}
	NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat: kDEFAULT_DATE_FORMAT];
	NSString *dateString = [formatter stringFromDate:date ];
	return dateString;
}

+ (NSDate*)NSStringToNSDate:(NSString*)string
{   
	if (string == nil) {
		return nil;
	}
	NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat: kDEFAULT_DATE_FORMAT];
	NSDate *date = [formatter dateFromString:string ];
	return date;
}

+ (NSString*)NSDateTimeToNSString:(NSDate*)date
{
	if (date == nil) {
		return nil;
	}
	NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat: kDEFAULT_DATE_TIME_FORMAT];
	NSString *dateString = [formatter stringFromDate:date ];
	return dateString;
}

+ (NSDate*)NSStringToNSDateTime:(NSString*)string
{
	if (string == nil) {
		return nil;
	}
	NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat: kDEFAULT_DATE_TIME_FORMAT];
	NSDate *date = [formatter dateFromString:string ];
	return date;
}

+ (NSString*)stringWithURLEncode:(NSString*)inputstr {
	return [inputstr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}



+(NSString *)getCachePath:(NSString*)name
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
	return [basePath stringByAppendingPathComponent:name];
}

+(UIImage*)resizeImage:(UIImage*)img withSize:(CGSize)newSize
{
	UIGraphicsBeginImageContext(newSize);
	CGRect imageRect = CGRectMake(0.0, 0.0, newSize.width, newSize.height);
	[img drawInRect:imageRect];
	UIImage *resizedImg = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return resizedImg;
}

+(NSString *)generateUUID
{
	CFUUIDRef theUUID = CFUUIDCreate(NULL);
	CFStringRef aCFString = CFUUIDCreateString(NULL, theUUID);
	CFRelease(theUUID);

	return ((__bridge NSString *)aCFString);
}




+(NSString*) SHA1:(NSString*)input
{
	const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
	NSData *data = [NSData dataWithBytes:cstr length:input.length];
	
	uint8_t digest[CC_SHA1_DIGEST_LENGTH];
	
	CC_SHA1(data.bytes, data.length, digest);
	
	NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
	
	for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
		[output appendFormat:@"%02x", digest[i]];
	
	return output;
}

+(NSString *) docDirectoryPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return documentsDirectory;
}

+(NSString *) archiveFilePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	NSString *imageDirectory = [documentsDirectory stringByAppendingString:@"/MBS_Archive"];
	return imageDirectory;
}

+(BOOL)isFileExistWithPath:(NSString*)filepath {
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:filepath];
    return success;
}

+(BOOL)deleteFileWithPath:(NSString*)filepath {
    BOOL bret = YES;
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSError * errorStruct;
    if ([fileMgr removeItemAtPath:filepath error:&errorStruct] == NO) {
        bret = NO;
    }
    return bret;
}

+(UIColor *) colorWithImage: (NSString *) imgname {
    return [UIColor colorWithPatternImage:[UIImage imageNamed:imgname]];
}

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

+(UIImage *)screenShotFrom:(UIView *)view frame:(CGRect)frame
{
    if(UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0);
    } else {
        UIGraphicsBeginImageContext(frame.size);
    }
    
    //获取图像
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    static int index;
    //保存图像
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingFormat:@"/%d.png",index];
    if ([UIImagePNGRepresentation(image) writeToFile:path atomically:YES]) {
        index += 1;
        NSLog(@"Succeeded!");
    }
    else {
        NSLog(@"Failed!");
    }
    return image;
}

+ (void)printViewHierarchy:(UIView *)superView
{
    static uint level = 0;
    for(uint i = 0; i < level; i++){
        printf("\t");
    }
    
    const char *className = NSStringFromClass([superView class]).UTF8String;
    const char *frame = NSStringFromCGRect(superView.frame).UTF8String;
    printf("%s:%s\n", className, frame);
    
    ++level;
    for(UIView *view in superView.subviews){
        [self printViewHierarchy:view];
    }
    --level;
}


+ (UIImage*)compressJPGImage:(UIImage*)original withinSize:(NSUInteger)size {
    NSData* inImageData = UIImageJPEGRepresentation(original, 1.0);
    NSUInteger sizeOrigin = [inImageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    NSData* outImageData = nil;
    UIImage* outImage = nil;
    if (sizeOriginKB > size) {
        float a = size;
        float b = (float)sizeOriginKB;
        float q = sqrtf(a / b);
        
        CGSize sizeImage = [original size];
        CGFloat widthSmall = sizeImage.width * q;
        CGFloat heighSmall = sizeImage.height * q;
        CGSize sizeImageSmall = CGSizeMake(widthSmall, heighSmall);
        
        UIGraphicsBeginImageContext(sizeImageSmall);
        CGRect smallImageRect = CGRectMake(0, 0, sizeImageSmall.width, sizeImageSmall.height);
        [original drawInRect:smallImageRect];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *dataImage = UIImageJPEGRepresentation(smallImage, 1.0);
        
        outImageData = dataImage;
        outImage = smallImage;

    }
    return outImage;
}

+ (UIImage*)compressPNGImage:(UIImage*)original withinSize:(NSUInteger)size {
    NSData* inImageData = UIImagePNGRepresentation(original);
    NSUInteger sizeOrigin = [inImageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    NSData* outImageData = nil;
    UIImage* outImage = original;
    if (sizeOriginKB > size) {
        float a = size;
        float b = (float)sizeOriginKB;
        float q = sqrtf(a / b);
        
        CGSize sizeImage = [original size];
        CGFloat widthSmall = sizeImage.width * q;
        CGFloat heighSmall = sizeImage.height * q;
        CGSize sizeImageSmall = CGSizeMake(widthSmall, heighSmall);
        
        UIGraphicsBeginImageContext(sizeImageSmall);
        CGRect smallImageRect = CGRectMake(0, 0, sizeImageSmall.width, sizeImageSmall.height);
        [original drawInRect:smallImageRect];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSData *dataImage = UIImagePNGRepresentation(smallImage);
        
        outImageData = dataImage;
        outImage = smallImage;
        
    }
    return outImage;
}
//时间格式
+ (NSString *)changeChatListDateFormat:(NSInteger)date{
    NSString *time = @"";
    NSDate *taskDate = [NSDate dateWithTimeIntervalSince1970:date];
    NSDate *nowDate = [NSDate date];
    NSInteger tempTime = nowDate.timeIntervalSince1970 - date;
    if (date > 0) {
        if (tempTime > 0) {
            NSInteger day = tempTime/60/60/24;
            NSInteger hour = tempTime%(60*60*24)/60/60;
            NSInteger min = tempTime%(60*60*24)%(60*60)/60;
            NSInteger sec = tempTime%(60*60*24)%(60*60)%60;
            
            if (!(day == 0)) {
                time = [NSString stringWithFormat:@"%ld天前",day];
            } else {
                if (!(hour == 0)) {
                    time = [NSString stringWithFormat:@"%ld小时前",hour];
                } else {
                    if (!(min == 0)) {
                        time = [NSString stringWithFormat:@"%ld分钟前",min];
                    } else {
                        time = [NSString stringWithFormat:@"%ld秒前",sec];
                    }
                }
            }
            return time;
        } else if (tempTime == 0) {
            time = @"刚刚";
            return time;
        } else {
            NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *time = [formatter stringFromDate:taskDate];
            return time;
        }
    } else {
        time = @"";
        return time;
    }
    
}
+ (NSString *)timerTransformToString:(NSInteger)atime {
    NSDate *taskDate = [NSDate dateWithTimeIntervalSince1970:atime];
    NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *time = [formatter stringFromDate:taskDate];
    return time;
}

+ (NSString *)changeDateEffectiveFormat:(NSInteger)date
{
    NSString *time = @"";
    NSDate *taskDate = [NSDate dateWithTimeIntervalSince1970:date];
    NSDate *nowDate = [NSDate date];
    NSInteger tempTime = date - nowDate.timeIntervalSince1970;
    if (tempTime > 0) {
        NSInteger day = tempTime/60/60/24;
        NSInteger hour = tempTime%(60*60*24)/60/60;
        NSInteger min = tempTime%(60*60*24)%(60*60)/60;
        
        if (!(day == 0)) {
            time = [NSString stringWithFormat:@"%ld天内有效",day];
        } else {
            if (!(hour == 0)) {
                time = [NSString stringWithFormat:@"%ld小时内有效",hour];
            } else {
                time = [NSString stringWithFormat:@"%ld分钟内有效",min];
            }
        }
        return time;
    } else {
        NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        NSString *time = [formatter stringFromDate:taskDate];
        return time;
    }
}
+ (NSString *)changeDateFormat:(NSInteger)date
{
    NSString *time = @"";
    NSDate *taskDate = [NSDate dateWithTimeIntervalSince1970:date];
    NSDate *nowDate = [NSDate date];
    NSInteger tempTime = date - nowDate.timeIntervalSince1970;
    if (tempTime > 0) {
        NSInteger day = tempTime/60/60/24;
        NSInteger hour = tempTime%(60*60*24)/60/60;
        NSInteger min = tempTime%(60*60*24)%(60*60)/60;
        
        if (!(day == 0)) {
            time = [NSString stringWithFormat:@"剩%ld天",day];
        } else {
            if (!(hour == 0)) {
                time = [NSString stringWithFormat:@"剩%ld小时",hour];
            } else {
                time = [NSString stringWithFormat:@"剩%ld分钟",min];
            }
        }
        return time;
    } else {
        NSDateFormatter *formatter= [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *time = [formatter stringFromDate:taskDate];
        return time;
    }
}
//距离格式
+ (NSString *)changeDistanceFormat:(NSString *)distance
{
    NSString *dist = @"";
    float distan = [distance floatValue];
    float km = distan/1000;
    if (km >= 1) {
        dist = [NSString stringWithFormat:@"距离%.1f公里",km];
    } else {
        if (km * 1000 < 0) {
            dist = [NSString stringWithFormat:@"无法获取地理位置"];
        } else if (km * 1000 <=10 && km * 1000 >= 0){
            dist = [NSString stringWithFormat:@"10米以内"];
        } else {
            dist = [NSString stringWithFormat:@"距离%.f米",km*1000];
        }
    }
//    NSLog(@"%@",dist);
    return dist;
}
+(float)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long folderSize=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return folderSize/1024.0/1024.0;
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}
+ (UIImage *)imageFromView: (UIView *) theView
{
    
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}
+(NSString *)timerTransform:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
// 压缩上传图片
+(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth{
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}
//garyImage
+ (UIImage*)grayscale:(UIImage*)anImage type:(int)type
{ CGImageRef imageRef = anImage.CGImage;
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    size_t bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    size_t bitsPerPixel = CGImageGetBitsPerPixel(imageRef);
    size_t bytesPerRow = CGImageGetBytesPerRow(imageRef);
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(imageRef);
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    bool shouldInterpolate = CGImageGetShouldInterpolate(imageRef);
    CGColorRenderingIntent intent = CGImageGetRenderingIntent(imageRef);
    CGDataProviderRef dataProvider = CGImageGetDataProvider(imageRef);
    CFDataRef data = CGDataProviderCopyData(dataProvider);
    UInt8 *buffer = (UInt8*)CFDataGetBytePtr(data); NSUInteger x, y;
    for (y = 0; y < height; y++) { for (x = 0; x < width; x++) {
        UInt8 *tmp; tmp = buffer + y * bytesPerRow + x * 4;
        UInt8 red,green,blue;
        red = *(tmp + 0);
        green = *(tmp + 1);
        blue = *(tmp + 2);
        UInt8 brightness;
        switch (type) {
            case 1: brightness = (77 * red + 28 * green + 151 * blue) / 256; *(tmp + 0) = brightness; *(tmp + 1) = brightness; *(tmp + 2) = brightness;
            break;
            case 2: *(tmp + 0) = red; *(tmp + 1) = green * 0.7; *(tmp + 2) = blue * 0.4;
            break;
            case 3: *(tmp + 0) = 255 - red; *(tmp + 1) = 255 - green; *(tmp + 2) = 255 - blue;
            break;
            default: *(tmp + 0) = red; *(tmp + 1) = green; *(tmp + 2) = blue;
            break; }
        }
    }
    CFDataRef effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    CGDataProviderRef effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    CGImageRef effectedCgImage = CGImageCreate( width, height, bitsPerComponent, bitsPerPixel, bytesPerRow, colorSpace, bitmapInfo, effectedDataProvider, NULL, shouldInterpolate, intent);
    UIImage *effectedImage = [[UIImage alloc] initWithCGImage:effectedCgImage];
    CGImageRelease(effectedCgImage);
    CFRelease(effectedDataProvider);
    CFRelease(effectedData);
    CFRelease(data);
    return effectedImage;
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

/**
 *  颜色自右上到坐下的渐变
 *
 *  @param colors  渐变的颜色
 *  @param imgSize 面积
 *  @param type    渐变的方向
 *
 *  @return 图片
 */
+(UIImage *)gradientColorImageFromColors:(NSArray*)colors imgSize:(CGSize)imgSize type:(NSString *)type{
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    //left_top,左上开始渐变,right_left,
    if ([type isEqualToString:@"right_top"]) {
        start = CGPointMake(imgSize.width, 0.0);
        end = CGPointMake(0.0, imgSize.height);
    }else if([type isEqualToString:@"right_left"]){
        start = CGPointMake(0.0, imgSize.height/2);
        end = CGPointMake(imgSize.width, imgSize.height/2);
    }else if([type isEqualToString:@"left_top"]){
        start = CGPointMake(0.0, imgSize.width);
        end = CGPointMake(imgSize.height,0.0);
    }else if([type isEqualToString:@"top_bottom"]){
        start = CGPointMake(imgSize.width/2, 0.0);
        end = CGPointMake(0.0, imgSize.height/2);
    }

    
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}
//帐号登出
+(void)accountsLogout{
    NSNotification  *notifi=[[NSNotification alloc]initWithName:@"SRChangeInfoWithAvatar" object:nil userInfo:@{@"type":@"out"}];
    [[NSNotificationCenter defaultCenter]postNotification:notifi];
    [[MBPreferenceManager sharedPreferenceManager] setLoginState:NO];
    [[MBPreferenceManager sharedPreferenceManager] setSecurityKey:@""];
    [[MBPreferenceManager sharedPreferenceManager] setUserId:@""];
    [[MBPreferenceManager sharedPreferenceManager] setUserAddress:@""];
    [[MBPreferenceManager sharedPreferenceManager] setPhone:@""];
    [[MBPreferenceManager sharedPreferenceManager] setPassword:@""];
    [[MBPreferenceManager sharedPreferenceManager] setAvatar:@""];
    [[MBPreferenceManager sharedPreferenceManager] setWalletId:@""];
    [[MBPreferenceManager sharedPreferenceManager] setUserGender:@""];
    [[MBPreferenceManager sharedPreferenceManager] setPayment_initialized:@""];
    [[MBPreferenceManager sharedPreferenceManager] setNickName:@""];
    [[MBPreferenceManager sharedPreferenceManager] setSchool:@""];
    [[MBPreferenceManager sharedPreferenceManager] SETIMINFO:@""];
    [[MBPreferenceManager sharedPreferenceManager]setDefaultLat:@""];
    [[MBPreferenceManager sharedPreferenceManager]setDefaultLng:@""];
    [[MBPreferenceManager sharedPreferenceManager]setUserNumber:@""];
}

+(NSString *) md5: (NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}


+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

@end
