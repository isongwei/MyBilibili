//
//  NetWorkClient.h
//  MyFrame
//
//  Created by 张松伟 on 16/4/17.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "MainModel.h"

#define TimeoutInterval 10

@interface NetWorkClient : AFHTTPSessionManager





//网络状态
typedef NS_ENUM(NSUInteger,NetWorkingStatus) {
    /**未知网络 */
    NetWorkingStatusUnKnown,
    /**无网络 */
    NetWorkingStatusNotReachable,
    /**手机网络 */
    NetWorkingStatusReachableViaWWAN,
    /**WIFI网络 */
    NetWorkingStatusReachableViaWiFi
};


/**
 *  实时获取网络状态,通过Block回调实时获取(此方法可多次调用)
 */
+ (void)networkStatusWithBlock:(void(^)(NetWorkingStatus status))networkStatus;

//网络是否可用


-(BOOL)isNetworkEnabled;

+(NetWorkClient *)sharedClient;
/**
 *  GET
 *
 *  @param urlString   请求网址
 *  @param parameter   参数
 *  @param start       请求开始
 *  @param succedBlock 成功回调
 *  @param failedBlock 失败回调
 *
 *  @return task
 */
-(NSURLSessionDataTask *)GET:(NSString *)urlString
                   parameter:(id)parameter
                startRequest:(void(^)(void))start
                     success:(void(^)(MainModel * MainModel))succedBlock
                     failure:(void(^)(NSError * error))failedBlock;

/**
 *  GET 缓存
 *
 *  @param urlString   请求网址
 *  @param isCache     是否缓存
 *  @param parameter   参数
 *  @param start       请求开始
 *  @param succedBlock 成功回调
 *  @param failedBlock 失败回调
 *
 *  @return task
 */
-(NSURLSessionDataTask *)GET:(NSString *)urlString
                       Cache:(BOOL)isCache
                   parameter:(id)parameter
                startRequest:(void(^)(void))start
                     success:(void(^)(MainModel * MainModel))succedBlock
                     failure:(void(^)(NSError * error))failedBlock;






/**
 *  POST
 *
 *  @param urlString   请求网址
 *  @param parameter   参数
 *  @param start       请求开始
 *  @param succedBlock 成功回调
 *  @param failedBlock 失败回调
 *
 *  @return task
 */
-(NSURLSessionDataTask *)POST:(NSString *)urlString
                    parameter:(id)parameter
                 startRequest:(void(^)(void))start
                      success:(void(^)(MainModel * MainModel))succedBlock
                      failure:(void(^)(NSError * error))failedBlock;









/**
 *  POST 缓存
 *
 *  @param urlString   请求网址
 *  @param isCache     是否缓存
 *  @param parameter   参数
 *  @param start       请求开始
 *  @param succedBlock 成功回调
 *  @param failedBlock 失败回调
 *
 *  @return task
 */
-(NSURLSessionDataTask *)POST:(NSString *)urlString
                        Cache:(BOOL)isCache
                    parameter:(id)parameter
                 startRequest:(void(^)(void))start
                      success:(void(^)(MainModel * MainModel))succedBlock
                      failure:(void(^)(NSError * error))failedBlock;





/**
 *  upload数据请求
 *
 *  @param urlString   请求网址
 *  @param parameter   上传参数
 *  @param start       请求开始
 *  @param succedBlock 成功回调
 *  @param failedBlock 失败回调
 *
 *  @return task
 */
-(NSURLSessionDataTask *)upload:(NSString *)urlString
                      parameter:(NSDictionary *)parameter
                   startRequest:(void(^)(void))start
                        success:(void(^)(MainModel * MainModel))succedBlock
                        failure:(void(^)(NSError * error))failedBlock;

/**
 *  取消操作
 */
-(void)cancel;

@end
