//
//  AppDefaultUtil.h
//
//
//
//  
//

#import <Foundation/Foundation.h>

@interface AppDefaultUtil : NSObject

/**
 单例模式，实例化对象
 */
+ (instancetype)sharedInstance;



//移除用户
-(void) removeUser;




// 设置用户是否第一次登陆
-(void) setFirstLancher:(BOOL)value;

// 获取用户是第一次登录
-(BOOL) isLanched;




//保存账户userSign
-(void) setDefaultUserSign:(NSString *)value;

//获取账户userSign
-(NSString *) getDefaultUserSign;








//设置是否开通浙商账户
-(void) setDefaultIsCzbActive:(BOOL )value;

//获取是否开通浙商账户
-(BOOL ) getDefaultIsCzbActive;










// 保存最后一次用户登录的用户昵称
-(void) setDefaultUserName:(NSString *)value;

// 获取最后一次用户登录的用户昵称
-(NSString *) getDefaultUserName;





// 保存最后一次用户登录的用户账号
-(void) setDefaultLastAccount:(NSString *)value;

// 获取最后一次用户的登录账号
-(NSString *) getDefaultLastAccount;






// 保存最后一次登录的用户密码(des加密后)
-(void) setDefaultUserPassword:(NSString *)value;

// 获取最后一次登录的用户密码(des加密后)
-(NSString *) getDefaultUserPassword;







// 设置用户头像链接
-(void) setDefaultHeaderImageUrl:(NSString *)value;

// 获取某用户的头像链接
-(NSString *) getDefaultHeaderImageUrl;






// 设置用户身份证号码
-(void) setDefaultidNumber:(NSString *)value;

// 获取某用户的身份证号码
-(NSString *) getDefaultidNumber;




// 设置用户id
-(void) setDefaultID:(NSString *)value;

// 获取某用户的id
-(NSString *) getDefaultID;





// 设置用户认证姓名
-(void) setDefaultRealName:(NSString *)value;

// 获取某用户的认证姓名
-(NSString *) getDefaultRealName;






// 设置用户认证号码
-(void) setDefaultPhoneNum:(NSString *)value;

// 获取某用户的认证号码
-(NSString *) getDefaultPhoneNum;





// 设置用户认证号码  浙商
-(void) setDefaultczPhoneNum:(NSString *)value;
// 获取某用户的认证号码  浙商
-(NSString *) getDefaultczPhoneNum;







// 设置用户浙商绑定
-(void) setDefaultbindSerNo:(NSString *)value;
// 获取某用户的浙商绑定
-(NSString *) getDefaultbindSerNo;





// 设置某账户用户手势密码
-(void) setGesturesPasswordWithAccount:(NSString *) userAccount gesturesPassword:(NSString *) gestures;

// 移除某账户的手势密码
-(void) removeGesturesPasswordWithAccount:(NSString *) userAccount;

// 获取某账户的手势密码
-(NSString *) getGesturesPasswordWithAccount:(NSString *) userAccount;








// 保存设备型号
-(void) setdeviceType:(NSString *) deviceType;
// 获取设备型号
-(NSString *) getdeviceType;








// 保存最后一次启动网络图片
-(void) setAppImage:(NSString *)value;
// 获取最后一次启动网络图片
-(NSString *) getAppImage;




//分享后回来  无锁
-(void) setAppIsLock:(BOOL )value;
// 分享后回来  是否有所

//yes  有   no   wu
-(BOOL) getAppIsLock;





@end
