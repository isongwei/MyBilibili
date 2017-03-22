

#import <UIKit/UIKit.h>





@interface UIView (Extension)




/**
 *  可以在xib里面直接设置的:圆角
 */
@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
/**
 *  可以在xib里面直接设置的:边线宽度
 */
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
/**
 *  可以在xib里面直接设置的:边线颜色
 */
@property (nonatomic, assign) IBInspectable UIColor *borderColor;




/*----------------------------------------------------------------------------------------*/
//宽高位置大小
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

//中心点的x与y
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
- (UIImage *)screenshotWithOffset:(CGFloat)deltaY;
- (UIImage *)screenshot;


@end
