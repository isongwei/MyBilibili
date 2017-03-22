//
//  Common.m
//  maimaiti2.0
//
//  Created by zhukeke on 16/6/17.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "Common.h"


@implementation Common

+ (NSMutableAttributedString *)setupAttributeString:(NSString *)text highlightText:(NSString *)highlightText highlightColor:(UIColor *)highlightColor highlightFont:(float)highlightFont
{
    NSRange hightlightTextRange = [text rangeOfString:highlightText];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    if (hightlightTextRange.length > 0) {
        [attributeStr addAttribute:NSForegroundColorAttributeName
                             value:highlightColor
                             range:hightlightTextRange];
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:highlightFont] range:hightlightTextRange];
        return attributeStr;
    }else {
        return [highlightText copy];    }
}

//富文本
+(NSMutableAttributedString *)setupAttributeString:(NSString *)text highlightText:(NSString *)Text Color:(UIColor *)Color highlightText1:(NSString *)Text1 Color1:(UIColor *)Color1 highlightText2:(NSString *)Text2 Color2:(UIColor *)Color2 highlightText3:(NSString *)Text3 Color3:(UIColor *)Color3{
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSRange Range;
    if (Text!=nil) {
        Range = [text rangeOfString:Text];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:Color range:Range];
    }
    NSRange Range1;
    if (Text1!=nil) {
        Range1 = [text rangeOfString:Text1 options:1 range:NSMakeRange(Range.location+Range.length, text.length - (Range.location+Range.length))];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:Color1 range:Range1];
    }
    NSRange Range2;
    if (Text2!=nil) {
        Range2 = [text rangeOfString:Text2 options:1 range:NSMakeRange(Range1.location+Range1.length, text.length - (Range1.location+Range1.length))];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:Color2 range:Range2];
    }
    NSRange Range3;
    if (Text3!=nil) {
        Range3 = [text rangeOfString:Text3 options:1 range:NSMakeRange(Range2.location+Range2.length, text.length - (Range2.location+Range2.length))];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:Color3 range:Range3];
    }
    return attributeStr;
}

@end
