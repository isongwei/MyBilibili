//
//  UIImageView+GIF.m
//  mybilibili
//
//  Created by 张松伟 on 2017/2/9.
//  Copyright © 2017年 张松伟. All rights reserved.
//

#import "UIImageView+GIF.h"


@implementation UIImage (GIF)


+ (UIImageView *)imageViewWithAnimatedGIFImageSource:(CGImageSourceRef) source andDuration:(NSTimeInterval) duration {
    if (!source) return nil;
    size_t count = CGImageSourceGetCount(source);
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:count];
    
    for (size_t i = 0; i < count; ++i) {
        CGImageRef cgImage = CGImageSourceCreateImageAtIndex(source, i, NULL);
        if (!cgImage)
            return nil;
        [images addObject:[UIImage imageWithCGImage:cgImage]];
        CGImageRelease(cgImage);
    }
    UIImageView *imageView = [[UIImageView alloc] init];
    if ([images count] > 0) {
        imageView.image = [images objectAtIndex:0];
    }
    [imageView setAnimationImages:images];
    [imageView setHighlighted:NO];
    //    [imageView setHighlightedAnimationImages:images];
    [imageView setAnimationDuration:duration];
    [imageView sizeToFit];
    //    [imageView startAnimating];
    [imageView performSelector:@selector(startAnimating) withObject:nil afterDelay:0.3f];//tableviewcell中需要延时播放动画, 否则会停住不动
    //    NSLog(@"begin");
    return ARCCompatibleAutorelease(imageView);
}
+ (NSTimeInterval)durationForGifData:(NSData *)data {
    char graphicControlExtensionStartBytes[] = {0x21,0xF9,0x04};
    double duration=0;
    NSRange dataSearchLeftRange = NSMakeRange(0, data.length);
    while(YES){
        NSRange frameDescriptorRange = [data rangeOfData:[NSData dataWithBytes:graphicControlExtensionStartBytes length:3] options:NSDataSearchBackwards range:dataSearchLeftRange];
        if(frameDescriptorRange.location != NSNotFound){
            NSData *durationData = [data subdataWithRange:NSMakeRange(frameDescriptorRange.location+4, 2)];
            unsigned char buffer[2];
            [durationData getBytes:buffer];
            double delay = (buffer[0] | buffer[1] << 8);
            duration += delay;
            dataSearchLeftRange = NSMakeRange(0, frameDescriptorRange.location);
        }else{
            break;
        }
    }
    return duration/100;
}
+ (UIImageView *)imageViewWithGIFData:(NSData *)data{
    NSTimeInterval duration = [self durationForGifData:data];
    CGImageSourceRef source = CGImageSourceCreateWithData(toCF data, NULL);
    UIImageView *imageView = [UIImageView imageViewWithAnimatedGIFImageSource:source andDuration:duration];
    CFRelease(source);
    return imageView;
}

//+ (UIImageView *)imageViewWithGIFURL:(NSURL *)url{
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    return [UIImageView imageViewWithGIFData:data];
//}
@end

//@implementation UIImageView (GIF)
//
//@end
