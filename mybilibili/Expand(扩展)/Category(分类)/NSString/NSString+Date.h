//
//  NSString+Date.h
//

#import <Foundation/Foundation.h>

@interface NSString (Date)

// 时间转换 @"yyyy-MM-dd hh:mm:ss"
+(NSString *)converDate:(NSString *)value withFormat:(NSString *)format;
+(NSString *)getCurrentDate;//@"yyyy-MM-dd HH:mm:ss"




+(NSString *)getCurrentTime;//@"yyyy-MM-dd"
+(NSString *)getTimeWith:(NSInteger)value;//@"yyyy-MM-dd-HH-mm-ss"

+(NSString *)getCurrentTimewithFormat:(NSString *)format date:(NSDate*)date;
+(NSString *)getCurrentTimewithFormat:(NSString *)format;



//根据传入的时间戳 返回时间差
+(NSString *)getTimeIntervalWithconverDate:(NSString *)value;

@end
