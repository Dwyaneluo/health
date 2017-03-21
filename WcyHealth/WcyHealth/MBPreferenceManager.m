

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
- (void)setUserInfoNSDictionary:(NSDictionary *)userInfoDic
{
    if (userInfoDic == nil||[userInfoDic isKindOfClass:[NSNull class]]) {
        return;
    }
    NSError *parseError = nil;
    NSData *dataJson = [NSJSONSerialization dataWithJSONObject:userInfoDic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:dataJson forKey:@"userInfoDic"];
    [defaults synchronize];
}
- (NSDictionary *)getUserInfoNSDictionary
{
    NSData *dataJson = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfoDic"];
    if (dataJson == nil){
        NSDictionary *dic = [NSDictionary dictionary];
        return dic;
    }
    NSError *parseError = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:dataJson options:NSJSONReadingMutableContainers error:&parseError];
    return dict;
}
- (void)setUserNumber:(NSString *)UserNumber
{
    if (UserNumber == nil || [UserNumber isKindOfClass:[NSNull class]]) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:UserNumber forKey:@"UserNumber"];
    [defaults synchronize];
}
- (NSString *)getUserNumber
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"UserNumber"];
}
- (void)SETIMINFO:(NSString *)IMIINFO
{
    if (IMIINFO == nil || [IMIINFO isKindOfClass:[NSNull class]]) {
        return;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:IMIINFO forKey:@"IMINFO"];
    [defaults synchronize];
}
- (NSString *)GETIMINFO
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"IMINFO"];
}

- (BOOL)isUSEOLD {
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"USEOLD"];
}

- (void)setUSEOLD:(BOOL)useOld {
    [[NSUserDefaults standardUserDefaults] setBool:useOld forKey:@"USEOLD"];
}

- (BOOL)isFirstLaunch {
    return ![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"];
}

- (void)setFirstLaunch:(BOOL)first {
    [[NSUserDefaults standardUserDefaults] setBool:first forKey:@"firstLaunch"];
}

- (void)setSplashCacheTime:(NSString *)cacheTime
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:cacheTime forKey:@"splashCache"];
    [defaults synchronize];
}
- (NSString *)getSplashCacheTime
{
    NSString *cacheTime = [[NSUserDefaults standardUserDefaults] objectForKey:@"splashCache"];
    return cacheTime;
}

- (NSString *)macaddress
{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return [outstring uppercaseString];
}
- (NSMutableDictionary *)getSIMInfo
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = networkInfo.subscriberCellularProvider;
    if (carrier != nil) {
        if (carrier.carrierName != nil) {
            [dict setObject:carrier.carrierName forKey:@"carrier"];
        }
        if (carrier.mobileCountryCode != nil) {
            [dict setObject:carrier.mobileCountryCode forKey:@"MCC"];
        }
        if (carrier.mobileNetworkCode != nil) {
            [dict setObject:carrier.mobileNetworkCode forKey:@"MNC"];
        }
    }
    return  dict;
}


@end
