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

+(UIColor *) colorWithHexString: (NSString *) stringToConvert;
+ (void)sendLocalPush:(NSString*)push;
+ (CGSize)countString:(NSString *)str size:(CGSize)size fontSize:(NSInteger)fontSize;
+ (CGSize)countString:(NSString *)str size:(CGSize)size font:(UIFont*)font;


@end
