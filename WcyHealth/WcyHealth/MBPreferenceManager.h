
#import <Foundation/Foundation.h>

@class SRShareModel;

@interface MBPreferenceManager : NSObject {
}

+ (MBPreferenceManager *)sharedPreferenceManager;

- (BOOL)isUSEOLD;
- (void)setUSEOLD:(BOOL)useOld;

- (BOOL)isFirstLaunch;
- (void)setFirstLaunch:(BOOL)first;

- (void)setSplashCacheTime:(NSString *)cacheTime;
- (NSString *)getSplashCacheTime;

- (void)setAliPay:(BOOL)AliPay;
- (BOOL)AliPay;

- (void)setLoginState:(BOOL)islogin;
- (BOOL)isLogin;

- (void)setOfflineMode:(BOOL)islogin;
- (BOOL)isOffline;

- (void)setDownloadable:(BOOL)islogin;
- (BOOL)isDownloadable;

- (void)setWalletId:(NSString *)WalletId;
- (NSString *)getWalletId;

- (void)setAPNSEnabled:(BOOL)apns;
- (BOOL)apnsEnabled;

- (void)setAPNSToken:(NSString *)name;
- (NSString *)getAPNSToken;

- (void)SETIMINFO:(NSString *)IMIINFO;
- (NSString *)GETIMINFO;

- (void)setUserNumber:(NSString *)UserNumber;
- (NSString *)getUserNumber;

- (void)setUserSource:(NSString *)name;
- (NSString *)getUserSource;

- (void)setEmail:(NSString *)name;
- (NSString *)getEmail;

- (void)setPhone:(NSString *)name;
- (NSString *)getPhone;

- (void)setAvatar:(NSString *)name;
- (NSString *)getAvatar;

- (void)setNickName:(NSString *)name;
- (NSString *)getNickName;

- (void)setUserName:(NSString *)name;
- (NSString *)getUserName;

- (void)setUserStatus:(NSString *)name;
- (NSString *)getUserStatus;

- (void)setPassword:(NSString *)password;
- (NSString *)getPassword;

- (void)setUserId:(NSString *)userId;
- (NSString *)getUserId;

- (void)setRememberPwd:(BOOL)rempwd;
- (BOOL)getRememberPwd;

- (void)setAutoLogin:(BOOL)autologin;
- (BOOL)getAutoLogin;

- (void)setSecurityKey:(NSString *)key;
- (NSString *)getSecurityKey;

- (void)setUserKey:(NSString *)key;
- (NSString *)getUserKey;

- (void)setImgQuality:(NSString*)key;
- (NSString*)getImgQuality;

- (void)setLocalStorage:(NSDictionary*)key;
- (NSDictionary*)getLocalStorage;

- (void)setUserGender:(NSString*)index;
- (NSString*)getUserGender;

- (void)setUserLocation:(NSString*)loc;
- (NSString*)getUserLocation;

- (void)setDefaultLat:(NSString*)lat;
- (NSString*)getDefaultLat;
- (void)setDefaultLng:(NSString*)lng;
- (NSString*)getDefaultLng;
- (void)setUserAddress:(NSString*)address;
- (NSString*)getUserAddress;


- (void)setUserBio:(NSString*)loc;
- (NSString*)getUserBio;

- (void)setBirthday:(NSDate*)type;
- (NSDate*)getBirthday;

- (void)setUserRegistrationID:(NSString*)loc;
- (NSString*)getUserRegistrationID;

- (void)setPayment_initialized:(NSString *)payment;
- (NSString *)getPayment_initialized;

- (void)setSchool:(NSString *)school;
- (NSString *)getSchool;

- (void)setUpdate:(BOOL)isUpdate;
- (BOOL)isUpdate;

- (void)setPush:(BOOL)isPush;
- (BOOL)isPush;

- (NSString *)getUDID;
- (NSString *)getUUID;
- (NSString *)getVendor;
- (NSString *)getPlatform;
- (NSString *)getOS;
- (NSString *) macaddress;
- (NSMutableDictionary *)getSIMInfo;
- (void)setPostShowTimer:(NSDate *)date;
- (NSString *)getPostShowTimer;
- (void)setUpdateShowTimer:(NSDate *)date;
- (NSString *)getUpdateShowTimer;

- (void)saveSplashImageCacheWith:(NSDictionary *)splashDic;
//- (UIImage *)getSplashCacheImage;
//计时器
- (void)run_Stime:(int)ti endAction:(void(^)(void))endAction runAction:(void(^)(void))runAction;
- (NSString *)judgeHTTPIsAdd:(NSString *)url;
//用户信息

- (void)setLevel:(NSString*)level;
- (NSString*)getLevel;
- (void)setUserInfo:(id)info;
- (id)getUserInfo;

- (void)setUserInfoNSDictionary:(NSDictionary *)userInfoDic;
- (NSDictionary *)getUserInfoNSDictionary;
@end
