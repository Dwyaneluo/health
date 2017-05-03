

#import "MBPreferenceManager.h"
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

//#import "SRUserModel.h"
static MBPreferenceManager *sharedManager = nil;

@implementation MBPreferenceManager


+(MBPreferenceManager*)sharedPreferenceManager
{
    if (sharedManager == nil) 
    {			
        sharedManager = [[MBPreferenceManager alloc] init];
    }
	return sharedManager;
}

- (BOOL)isFirstLaunch {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"];
    
}

- (void)setFirstLaunch:(BOOL)first {
    [[NSUserDefaults standardUserDefaults] setBool:first forKey:@"firstLaunch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setLoginState:(BOOL)islogin{
    [[NSUserDefaults standardUserDefaults] setBool:islogin forKey:@"login"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (BOOL)isLogin{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"login"];
}

- (void)setPhone:(NSString *)phone{
    if (phone == nil || [phone isKindOfClass:[NSNull class]]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getPhone{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
}

- (void)setPassword:(NSString *)password{
    if (password == nil || [password isKindOfClass:[NSNull class]]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getPassword{
     return [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
}

- (void)setUserState:(BOOL)isexist{
    [[NSUserDefaults standardUserDefaults] setBool:isexist forKey:@"exist"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (BOOL)isExist{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"exist"];
}

- (void)setUserName:(NSString *)name{
    if (name == nil || [name isKindOfClass:[NSNull class]]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
}

- (void)setUserPhone:(NSString *)phone{
    if (phone == nil || [phone isKindOfClass:[NSNull class]]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"userphone"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserPhone{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userphone"];
}

- (void)setUserIDCard:(NSString *)idcard{
    if (idcard == nil || [idcard isKindOfClass:[NSNull class]]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:idcard forKey:@"useridcard"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserIDCard{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"useridcard"];
}

- (void)setUserGender:(NSString *)gender{
    if (gender == nil || [gender isKindOfClass:[NSNull class]]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:gender forKey:@"usergender"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserGender{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"usergender"];
}

- (void)setUserMarried:(NSString *)married{
    if (married == nil || [married isKindOfClass:[NSNull class]]) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:married forKey:@"usermarried"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)getUserMarried{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"usermarried"];
}
@end
