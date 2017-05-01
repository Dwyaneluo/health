
#import <Foundation/Foundation.h>

@class SRShareModel;

@interface MBPreferenceManager : NSObject {
}

+ (MBPreferenceManager *)sharedPreferenceManager;



- (BOOL)isFirstLaunch;
- (void)setFirstLaunch:(BOOL)first;

- (void)setLoginState:(BOOL)islogin;
- (BOOL)isLogin;

- (void)setPhone:(NSString *)name;
- (NSString *)getPhone;

- (void)setPassword:(NSString *)password;
- (NSString *)getPassword;

@end
