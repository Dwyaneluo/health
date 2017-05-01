

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
    return ![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"];
}

- (void)setFirstLaunch:(BOOL)first {
    [[NSUserDefaults standardUserDefaults] setBool:first forKey:@"firstLaunch"];
}

- (void)setLoginState:(BOOL)islogin{
    [[NSUserDefaults standardUserDefaults] setBool:islogin forKey:@"login"];
}
- (BOOL)isLogin{
    return ![[NSUserDefaults standardUserDefaults] boolForKey:@"login"];
}

- (void)setPhone:(NSString *)name{
    [[NSUserDefaults standardUserDefaults] setBool:name forKey:@"phone"];
}
- (NSString *)getPhone{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
}

- (void)setPassword:(NSString *)password{
    [[NSUserDefaults standardUserDefaults] setBool:password forKey:@"password"];
}
- (NSString *)getPassword{
     return [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
}


@end
