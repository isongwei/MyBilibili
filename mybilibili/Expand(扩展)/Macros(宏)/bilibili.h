//
//  bilibili.h
//  mybilibili
//
//  Created by 张松伟 on 16/9/11.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#ifndef bilibili_h
#define bilibili_h

//==================== Server ===================



//加密
//参数key
#define DESparameterKEY @"E92F11C9-AB57-DF7A-CF4E-ACDC72B39FF4"
//接口key
#define DESAPIKEY @"X#f/=s(b"


//极光推送

#define JPUSHAppKey @"f430e91193e5de72d9b415e7"

//shareSDK手机验证key

#define SMSappKey @"16b6f2eac9e58"
#define SMSappSecret @"85b09bea214752d38c444c1971d303fc"

//友盟统计
//#define UMConfigInstanceappKey @"57972e9be0f55a9560001055"

//友盟分享
#define UmengAppkey @"57972e9be0f55a9560001055"

//用户存储信息
#define AppUser [AppDefaultUtil sharedInstance]

//接口服务器地址
#define NetClient [NetWorkClient sharedClient]


//内网
//#define BaseAPI @"http://192.168.0.116:9001"

//外网
#define BaseAPI @"http://os.mmtvip.com"






//-------------------获取设备大小-------------------------

//NavBar高度
#define NavigationBar_HEIGHT 44

//获取屏幕 宽度、高度
#define SCREENBOUNDS [UIScreen mainScreen].bounds
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


#define Timeout 60

//公用颜色
#define RGBColor(...)  [UIColor colorWithHexString:__VA_ARGS__]
#define MMTGrayColor [UIColor colorWithRed:0.93f green:0.93f blue:0.93f alpha:1.00f]
#define CommonColor [UIColor colorWithRed:0.13f green:0.86f blue:0.90f alpha:1.00f]
#define themeColor [UIColor colorWithRed:0.96f green:0.19f blue:0.46f alpha:1.00f];
//导航栏标题字体大小
#define NavigationFont [UIFont boldSystemFontOfSize:18]

//RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define ItemColor [UIColor colorWithHexString:@"fb80a5"] 


//tishi
#define Wait_Interval 0.3
#define HUDLoding  [[SWProgressHUD defaultView] showLoading];
#define HUDMaskView  [[SWProgressHUD defaultView] showMaskView];
#define HUDLodingHide  [[SWProgressHUD defaultView] hide];

#define HUDShowMessage(...) [[SWProgressHUD defaultView] showTitle:__VA_ARGS__ autoCloseTime:Wait_Interval];
#define HUDNetError  [[SWProgressHUD defaultView] showTitle:@"服务器开小差了,请重试!" autoCloseTime:Wait_Interval];

//宏定义
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#define DLog(format, ...) printf("\n时间:[%s] 方法:%s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
//#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

// 打印方法名字
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]



//判断是否为iPhone5


#define IS_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)
//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#ifdef DEBUG
#define DLOG(...) NSLog(__VA_ARGS__)
#else
#define DLOG(...)
#endif



#endif /* bilibili_h */
