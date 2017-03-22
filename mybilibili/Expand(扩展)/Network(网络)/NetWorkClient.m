//
//  NetWorkClient.m
//  MyFrame
//
//  Created by 张松伟 on 16/4/17.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "NetWorkClient.h"
static BOOL _isNetWorking;


@interface NetWorkClient ()

@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end


@implementation NetWorkClient



static NetWorkClient *sharedAccountManagerInstance = nil;

+(NetWorkClient *)sharedClient
{
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[NetWorkClient alloc] init];
    });
    return sharedAccountManagerInstance;
    
    
}
#pragma mark - get

-(NSURLSessionDataTask *)GET:(NSString *)urlString
                   parameter:(id)parameter
                startRequest:(void(^)(void))start
                     success:(void(^)(MainModel * MainModel))succedBlock
                     failure:(void(^)(NSError * error))failedBlock{
    
    return [self GET:urlString Cache:NO parameter:parameter startRequest:start success:succedBlock failure:failedBlock];
}




#pragma mark - get 缓存

-(NSURLSessionDataTask *)GET:(NSString *)urlString
                       Cache:(BOOL)isCache
                   parameter:(id)parameter
                startRequest:(void(^)(void))start
                     success:(void(^)(MainModel * MainModel))succedBlock
                     failure:(void(^)(NSError * error))failedBlock{
    
    
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/javascript",@"text/plain",@"text/json",@"application/json",nil];
    
    
    [self.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    self.requestSerializer.timeoutInterval = TimeoutInterval;
    [self.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    if (isCache) {
        //取数据
        return nil;
    }
    {
        //开始请求
        
        if (start == nil) {
            HUDLoding
        }else{
            start();
        }
        
        // 网络指示器开始显示
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        
        _dataTask = [self GET:urlString parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            //存数据

            // 网络指示器结束显示
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            DLog(@"responseObject----->>>\n%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
            MainModel * model = [MainModel mj_objectWithKeyValues:dic];
            succedBlock(model);
            HUDShowMessage(@"~~OK~~")
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            // 网络指示器结束显示
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            failedBlock(error);
            HUDShowMessage(error.description)
        }];
        
        
        
        
        return _dataTask;
    }
    
    
}









//#pragma mark - post
//
//-(NSURLSessionDataTask *)POST:(NSString *)urlString
//                    parameter:(id)parameter
//                 networkError:(void(^)(void))netError
//                 startRequest:(void(^)(void))start
//                      success:(void(^)(MainModel * MainModel))succedBlock
//                      failure:(void(^)(NSError * error))failedBlock{
//    
//    return [self POST:urlString Cache:NO parameter:parameter networkError:netError startRequest:start success:succedBlock failure:failedBlock];
//    
//}
//
//
//
//
//#pragma mark - post 缓存
//
//-(NSURLSessionDataTask *)POST:(NSString *)urlString
//                        Cache:(BOOL)isCache
//                    parameter:(id)parameter
//                 networkError:(void(^)(void))netError
//                 startRequest:(void(^)(void))start
//                      success:(void(^)(MainModel * MainModel))succedBlock
//                      failure:(void(^)(NSError * error))failedBlock{
//    
//    
//    self.responseSerializer = [AFHTTPResponseSerializer serializer];
//    self.requestSerializer = [AFHTTPRequestSerializer serializer];
//    
//    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/javascript",@"text/plain",@"text/json",@"application/json",nil];
//    
//    
//    [self.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    self.requestSerializer.timeoutInterval = TimeoutInterval;
//    [self.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    
//    
//    
//    
//    if (isCache) {
//        //取数据
//        return nil;
//    }
//    
//    
//    
//    if (![self isNetworkEnabled]) {
//        //网络出错
//        if (netError == nil) {
//            
//            HUDShowMessage(@"网络异常")
//            
//        }else{
//            
//            HUDShowMessage(@"网络异常")
//            netError();
//        }
//        
//        return nil;
//    }else{
//        //开始请求
//        
//        if (start == nil) {
//        }else{
//            start();
//        }
//        
//        
//
//        
//        
//        
//        
//        // 网络指示器开始显示
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//        _dataTask = [self POST:urlString parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
//            
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            
//            //存数据
//
//            // 网络指示器结束显示
//            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//            DLog(@"responseObject----->>>\n%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
//            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
//            MMTMainModel * model = [MMTMainModel mj_objectWithKeyValues:dic];
//            
//            
//            
//            succedBlock(model);
//            
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            // 网络指示器结束显示
//            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//            failedBlock(error);
//        }];
//        
//        
//        return _dataTask;
//    }
//    
//    
//}
//
//
//
//
//
//
//#pragma mark - upload
//
//
//
//
//-(NSURLSessionDataTask *)upload:(NSString *)urlString
//                    parameter:(NSDictionary *)parameter
//                 startRequest:(void(^)(void))start
//                      success:(void(^)(MMTMainModel * MainModel))succedBlock
//                      failure:(void(^)(NSError * error))failedBlock{
//    
//
//    //开始请求
//    if (start) {
//        start();
//    }
//    if (parameter == nil) {
//        parameter = @{};
//    }
//    
//    NSData * data = [NSJSONSerialization dataWithJSONObject:parameter options:NSJSONWritingPrettyPrinted error:nil];
//    NSString * upstr = [NSString encrypt3DES:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] key:DESAPIKEY];
//    NSData * postData = [upstr dataUsingEncoding:NSUTF8StringEncoding];
//    
//    self.responseSerializer = [AFHTTPResponseSerializer serializer];
//    self.requestSerializer = [AFHTTPRequestSerializer serializer];
//
//    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/javascript",@"text/plain",@"text/json",@"application/json",nil];
//    
//    
//    [self.requestSerializer willChangeValueForKey:@"timeoutInterval"];
//    self.requestSerializer.timeoutInterval = TimeoutInterval;
//    [self.requestSerializer didChangeValueForKey:@"timeoutInterval"];
//    
//
//    {
//
//
//        // 网络指示器开始显示
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//        
//        _dataTask = [self POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//            
//            [formData appendPartWithFormData:postData name:@"body"];
//            
//        } progress:^(NSProgress * _Nonnull uploadProgress) {
//            
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            // 网络指示器结束显示
//            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//            DLog(@"responseObject----->>>\n%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
//            NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableContainers) error:nil];
//            MMTMainModel * model = [MMTMainModel mj_objectWithKeyValues:dic];
//            succedBlock(model);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            // 网络指示器结束显示
//            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//            failedBlock(error);
//            
//        }];
//        return _dataTask;
//    }
//    
//}


#pragma mark - 判断当前网络是否可用
-(BOOL)isNetworkEnabled
{
    BOOL bEnabled = FALSE;
    NSString *url = @"www.baidu.com";
    SCNetworkReachabilityRef ref = SCNetworkReachabilityCreateWithName(NULL, [url UTF8String]);
    SCNetworkReachabilityFlags flags;
    bEnabled = SCNetworkReachabilityGetFlags(ref, &flags);
    
    CFRelease(ref);
    if (bEnabled) {
        BOOL flagsReachable = ((flags & kSCNetworkFlagsReachable) != 0);
        BOOL connectionRequired = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
        BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
        bEnabled = ((flagsReachable && !connectionRequired) || nonWiFi) ? YES : NO;
    }
    
    return bEnabled;
}


#pragma mark - cancel
-(void)cancel{
    if (_dataTask != nil) {
        [_dataTask cancel];
    }
}





+ (void)networkStatusWithBlock:(void(^)(NetWorkingStatus))networkStatus{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        AFNetworkReachabilityManager * manage = [AFNetworkReachabilityManager manager];
        [manage setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    networkStatus ? networkStatus(NetWorkingStatusUnKnown) : nil;
                    _isNetWorking = NO;
                    NSLog(@"未知网络");
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    networkStatus ? networkStatus(NetWorkingStatusNotReachable) : nil;
                    _isNetWorking = NO;
                    NSLog(@"无网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    networkStatus ? networkStatus(NetWorkingStatusReachableViaWWAN) : nil;
                    _isNetWorking = YES;
                    NSLog(@"手机自带网络");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    networkStatus ? networkStatus(NetWorkingStatusReachableViaWiFi) : nil;
                    _isNetWorking = YES;
                    NSLog(@"WIFI");
                    break;
                default:
                    break;
            }
        }];
        [manage startMonitoring];
    });
}


+(BOOL)currentNetworkStatus
{
    return _isNetWorking;
}

@end
