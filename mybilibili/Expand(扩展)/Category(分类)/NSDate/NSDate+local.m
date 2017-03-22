//
//  NSDate+local.m
//  maimaiti2.0
//
//  Created by zhangsongwei on 16/8/1.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "NSDate+local.h"

@implementation NSDate (local)


+(NSDate *)getLocaleDate
{
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    return  [date  dateByAddingTimeInterval: interval];
    
}

-(NSDate *)getLocaleDate
{
    
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    return  [date  dateByAddingTimeInterval: interval];
    
}

@end
