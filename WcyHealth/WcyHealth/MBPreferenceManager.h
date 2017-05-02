
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


- (void)setUserName:(NSString *)name;
- (NSString *)getUserName;
- (void)setUserPhone:(NSString *)phone;
- (NSString *)getUserPhone;
- (void)setUserIDCard:(NSString *)idcard;
- (NSString *)getUserIDCard;
- (void)setUserGender:(NSString *)gender;
- (NSString *)getUserGender;
- (void)setUserMarried:(NSString *)married;
- (NSString *)getUserMarried;
@end
