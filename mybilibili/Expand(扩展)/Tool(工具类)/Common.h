//
//  Common.h
//  maimaiti2.0
//
//  Created by zhukeke on 16/6/17.
//  Copyright © 2016年 张松伟. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Common : NSObject

+ (NSMutableAttributedString *)setupAttributeString:(NSString *)text highlightText:(NSString *)highlightText highlightColor:(UIColor *)highlightColor highlightFont:(float)highlightFont;

//富文本
+(NSMutableAttributedString *)setupAttributeString:(NSString *)text highlightText:(NSString *)Text Color:(UIColor *)Color highlightText1:(NSString *)Text1 Color1:(UIColor *)Color1 highlightText2:(NSString *)Text2 Color2:(UIColor *)Color2 highlightText3:(NSString *)Text3 Color3:(UIColor *)Color3;
@end
