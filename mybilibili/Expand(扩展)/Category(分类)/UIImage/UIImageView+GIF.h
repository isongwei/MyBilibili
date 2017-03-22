//
//  UIImageView+GIF.h
//  mybilibili
//
//  Created by 张松伟 on 2017/2/9.
//  Copyright © 2017年 张松伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>


#if __has_feature(objc_arc)
#define toCF (__bridge CFTypeRef)
#define ARCCompatibleAutorelease(object) object
#else
#define toCF (CFTypeRef)
#define ARCCompatibleAutorelease(object) [object autorelease]
#endif


@interface UIImageView (GIF)
+ (UIImageView *)imageViewWithGIFData:(NSData *)data;
//+ (UIImageView *)imageViewWithGIFURL:(NSURL *)url;

+ (UIImageView *)imageViewWithAnimatedGIFImageSource:(CGImageSourceRef) source andDuration:(NSTimeInterval) duration;

@end
