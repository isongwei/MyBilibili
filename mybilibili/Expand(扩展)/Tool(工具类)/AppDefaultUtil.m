//
//  AppDefaultUtil.m
//
//
//
//  
//

#import "AppDefaultUtil.h"


#define KEY_FIRST_LANCHER @"FirstLancher" // 记录用户是否第一次登陆，YES为是，NO为否

#define KEY_USER_NAME @"UserName" // 用户昵称

#define KEY_ACCOUNT @"Account" // 账号

#define KEY_IsCzbActive @"IsCzbActive" //是否浙商账号

#define KEY_userSign @"userSign" //userSign

#define KEY_PASSWORD @"Password" // 密码

#define NO_KEY_PASSWORD @"noPassword" // 密码(没有加密)

#define KEY_HEARD_IMAGE @"HeardImage" //头像

#define KEY_realName @"realName" //真实姓名

#define KEY_bindSerNo @"bindSerNo" //浙商绑定

#define KEY_idNum @"idNum" //身份证号

#define KEY_id @"id" //ID号

#define KEY_phoneNum @"phoneNum" //手机号

#define KEY_czPhoneNum @"czPhoneNum" //手机号

#define KEY_GESTURES_PASSWORD @"GesturesPassword" //手势密码

#define KEY_REMEBER_USER @"RemeberUser" //  记住用户

#define KEY_DEVICE_TYPE @"deviceType" //设备型号

#define KEY_appImage @"appImage" //启动网络图片

#define KEY_isLock @"isLock"//是否锁屏



@interface AppDefaultUtil()

@end

@implementation AppDefaultUtil

+ (instancetype)sharedInstance {
    
    static AppDefaultUtil *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[AppDefaultUtil alloc] init];
        
    });
    
    return _sharedClient;
}





// 移除某账户的
-(void) removeUser
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults removeObjectForKey:KEY_userSign];//登录标记
    
    [defaults removeObjectForKey:KEY_PASSWORD];//密码
    
    [defaults removeObjectForKey:KEY_USER_NAME];//用户名
    
    [defaults removeObjectForKey:KEY_HEARD_IMAGE];//用户头像
    
    [defaults removeObjectForKey:KEY_idNum];//身份证
    
    [defaults removeObjectForKey:KEY_id];//ID
    
    [defaults removeObjectForKey:KEY_realName];//真名字
    
    [defaults removeObjectForKey:KEY_phoneNum];//电话
    
    [defaults removeObjectForKey:KEY_bindSerNo];//浙商号
    
    [defaults removeObjectForKey:KEY_czPhoneNum];//浙商手机号
    
    [defaults removeObjectForKey:KEY_IsCzbActive];//是否开通浙商
    
    [defaults synchronize];
    
    
}



// 用户是否第一次登陆
-(void) setFirstLancher:(BOOL)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * versionOld = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [defaults setBool:value forKey:versionOld];
    [defaults synchronize];
}

-(BOOL) isLanched;
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString * versionOld = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return [defaults boolForKey:versionOld];
}





//保存账户userSign
-(void) setDefaultUserSign:(NSString *)value{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:KEY_userSign];
    [defaults synchronize];
}
//获取账户userSign
-(NSString *) getDefaultUserSign{
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_userSign];
}





//设置是否开通浙商账户
-(void) setDefaultIsCzbActive:(BOOL )value{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:KEY_IsCzbActive];
    [defaults synchronize];
}

//获取是否开通浙商账户
-(BOOL ) getDefaultIsCzbActive{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:KEY_IsCzbActive];
    
}








// 用户昵称
-(void) setDefaultUserName:(NSString *)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:KEY_USER_NAME];
    [defaults synchronize];
}

-(NSString *) getDefaultUserName
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_USER_NAME];
}

// 账号
-(void) setDefaultLastAccount:(NSString *)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:KEY_ACCOUNT];
    [defaults synchronize];
}

-(NSString *) getDefaultLastAccount
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_ACCOUNT];
}

// 密码 (des 加密后)
-(void) setDefaultUserPassword:(NSString *)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:KEY_PASSWORD];
    [defaults synchronize];
}

-(NSString *) getDefaultUserPassword
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_PASSWORD];
}

// 用户头像
-(void) setDefaultHeaderImageUrl:(NSString *)value
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:KEY_HEARD_IMAGE];
    [defaults synchronize];
}

-(NSString *) getDefaultHeaderImageUrl
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_HEARD_IMAGE];
}





// 设置用户认证号码
-(void) setDefaultidNumber:(NSString *)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:KEY_idNum];
    [defaults synchronize];
}

// 获取某用户的认证
-(NSString *) getDefaultidNumber{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_idNum];
}



// 设置用户id
-(void) setDefaultID:(NSString *)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:KEY_id];
    [defaults synchronize];
}

// 获取某用户的id
-(NSString *) getDefaultID{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_id];
}






// 设置用户认证姓名
-(void) setDefaultRealName:(NSString *)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:KEY_realName];
    [defaults synchronize];
}

// 获取某用户的认证姓名
-(NSString *) getDefaultRealName{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_realName];
}





// 设置用户认证姓名
-(void) setDefaultPhoneNum:(NSString *)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:KEY_phoneNum];
    [defaults synchronize];
}

// 获取某用户的认证姓名
-(NSString *) getDefaultPhoneNum{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_phoneNum];
}






// 设置用户认证号码
-(void) setDefaultczPhoneNum:(NSString *)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:KEY_czPhoneNum];
    [defaults synchronize];
    
}

// 获取某用户的认证号码
-(NSString *) getDefaultczPhoneNum{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_czPhoneNum];
    
    
}







// 设置用户浙商绑定
-(void) setDefaultbindSerNo:(NSString *)value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:KEY_bindSerNo];
    [defaults synchronize];
}

// 获取某用户的浙商绑定
-(NSString *) getDefaultbindSerNo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_bindSerNo];
}









// 设置手势密码
-(void) setGesturesPasswordWithAccount:(NSString *) userAccount gesturesPassword:(NSString *) gestures
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    
    [defaults setObject:gestures forKey: [NSString stringWithFormat:@"%@%@",KEY_GESTURES_PASSWORD,userAccount] ];
    
    [defaults synchronize];
}



// 获取某账号的手势密码
-(NSString *) getGesturesPasswordWithAccount:(NSString *) userAccount
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:[NSString stringWithFormat:@"%@%@",KEY_GESTURES_PASSWORD,userAccount]];
    

}

// 移除某账户的手势密码
-(void) removeGesturesPasswordWithAccount:(NSString *) userAccount
{
    
    
    NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
    [defaults1 removeObjectForKey:[NSString stringWithFormat:@"%@%@",KEY_GESTURES_PASSWORD,userAccount]];
    [defaults1 synchronize];
    
}





-(void) setdeviceType:(NSString *) deviceType {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:deviceType forKey:KEY_DEVICE_TYPE];
    [defaults synchronize];
}

-(NSString *) getdeviceType
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_DEVICE_TYPE];
}

// 保存启动网络图片
-(void) setAppImage:(NSString *)value {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:KEY_appImage];
    [defaults synchronize];
}
// 获取启动网络图片
-(NSString *) getAppImage
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:KEY_appImage];
}





//分享后回来  无锁
-(void) setAppIsLock:(BOOL )value{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:value forKey:KEY_isLock];
    [defaults synchronize];
}
// 分享后回来  是否有所

//yes  有   no   没有
-(BOOL) getAppIsLock{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:KEY_isLock];
    
}




@end
