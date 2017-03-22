//
//  SWProgressHUD.m
//  MMT-Loan
//
//  Created by iSongWei on 2016/11/30.
//  Copyright © 2016年 iSong. All rights reserved.
//
//#define SCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
//#define SCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define MMTColor RGBColor(@"1677cb")
#import "SWProgressHUD.h"



@interface SWProgressHUD()
@property (nonatomic,strong) UILabel * contentLabel;
@property (nonatomic,strong) NSString * title;
@property (nonatomic,strong) UILabel * contentView;
@property (nonatomic,strong) UIImageView * iconImageView;//
@property (nonatomic,strong) NSMutableArray * iconArray;

@property (nonatomic,strong) NSTimer *currentTimer;/// @brief 当前使用的图片帧动画计时器
@property (nonatomic,strong) UIView *maskView;  /// @brief 蒙版view

@property (nonatomic,assign) NSInteger frameAnimationPlayIndex;// 帧动画播放的下标索引
@property (nonatomic,assign) BOOL isRefresh;//是否在刷新

@end

@implementation SWProgressHUD

static SWProgressHUD *defaultView;

+ (SWProgressHUD *)defaultView{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defaultView = [[SWProgressHUD alloc] init];
    });
    return defaultView;
}


- (instancetype)init{
    if (self = [super init]) {
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        self.frame = CGRectMake(keyWindow.center.x, keyWindow.center.y, 0, 0);    
        self.clipsToBounds = YES;
        self.layer.masksToBounds = YES;
        
        
        
        self.iconImageView = [[UIImageView alloc] init];
        self.iconImageView.frame = CGRectMake(0, 0,36, 36);
        self.iconImageView.clipsToBounds = YES;
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.textColor = [UIColor whiteColor];
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        self.contentLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [self.contentLabel setNumberOfLines: 0];
        
        // 初始化蒙版控件
        self.maskView = [[UIView alloc] initWithFrame: [UIScreen mainScreen].bounds];
        [self addSubview: self.iconImageView];
        [self addSubview: self.contentLabel];
    }
    return self;
}


- (void)showWithTitle: (NSString*)title{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    //定时器
    if (_currentTimer) {
        [_currentTimer invalidate];
    }
    // 初始位置

    
    if (title == nil && (_iconArray.count == 0 || _iconArray == nil)) {
        _maskView.backgroundColor = [UIColor colorWithRed: 0.1 green: 0.1 blue:0.1 alpha:0.05];
        [[UIApplication sharedApplication].keyWindow addSubview: _maskView];
        return;
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview: _maskView];
    [[UIApplication sharedApplication].keyWindow addSubview: self];
    
    //调节UI


    if (_iconArray == nil || _iconArray.count == 0) {
        self.backgroundColor = MMTColor;
        //文字
        _iconImageView.hidden = YES;
        _contentLabel.hidden = NO;
        self.title = title;
        self.contentLabel.frame = [self LabelViewFrame];
        self.contentLabel.backgroundColor = MMTColor;
        self.contentLabel.textAlignment = NSTextAlignmentCenter;
        self.contentLabel.text = title;
        self.contentLabel.font = [UIFont systemFontOfSize: 15];
        
        if (title) {
            self.contentLabel.attributedText = [self getAttributedStringWithString:title lineSpace:5];
        }
        //动画开始
//        if (self.isRefresh == YES) {
//            self.frame = CGRectMake((SCREEN_WIDTH - 36)*0.5, SCREEN_HEIGHT*0.85,36, 36);
//        }else
        {
            self.alpha = 0;
            CGRect frame = [self ViewFrame];
            frame.origin.y +=40;
            self.frame = frame;
        }
        _isRefresh = NO;
    }else{
        self.backgroundColor = [UIColor clearColor];
        if (self.isRefresh == YES) {
            self.frame = CGRectMake((SCREEN_WIDTH - 36)*0.5, SCREEN_HEIGHT*0.85,36, 36);
        }else{
            CGRect frame = CGRectMake((SCREEN_WIDTH - 36)*0.5, SCREEN_HEIGHT*0.85,36, 36);
            frame.origin.y +=40;
            self.frame = frame;
        }
        
        

        
        _isRefresh = YES;
        _iconImageView.hidden = NO;
        _contentLabel.hidden = YES;
        // 逐帧连环动画
        // 帧动画播放索引归零
        
        _frameAnimationPlayIndex = 0;
        self.iconImageView.image = _iconArray[0];
        self.currentTimer = [NSTimer scheduledTimerWithTimeInterval: 0.05 target: self selector: @selector(frameAnimationPlayer) userInfo: nil repeats: YES];
        [[NSRunLoop currentRunLoop] addTimer:_currentTimer forMode:NSRunLoopCommonModes];
    }

    //动画

    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1;
        self.frame = [self ViewFrame];
    } completion:^(BOOL finished) {
        
    }];

}



-(void)hideSelf{
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        if (_isRefresh == YES) {
            self.frame = CGRectMake((SCREEN_WIDTH - 36)*0.5, SCREEN_HEIGHT*0.85+40,36, 36);
        }else{
            CGRect frame = [self ViewFrame];
            frame.origin.y +=40;
            self.frame = frame;
        }
        
        
    } completion:^(BOOL finished) {
        // 从父层控件中移除
        [self removeFromSuperview];
        [self.maskView removeFromSuperview];
        self.isRefresh = NO;
        if (self.currentTimer) {
            [self.currentTimer invalidate];
        }
        
    }];

}


- (void)hide{
    
    [self performSelector:@selector(hideSelf) withObject:nil afterDelay:0];
        // 动画缩放，更改透明度使其动画隐藏
    }

/**
 帧动画播放器 - NSTimer调用
 */

- (void)frameAnimationPlayer{
    if (_iconArray.count) {
        self.iconImageView.image = _iconArray[_frameAnimationPlayIndex];
        _frameAnimationPlayIndex = (_frameAnimationPlayIndex + 1) % _iconArray.count;
    }
}

#pragma mark - 显示
-(void)showTitle: (NSString *)title autoCloseTime: (CGFloat)autoCloseTime{
    [self.iconArray removeAllObjects];
    self.iconArray = nil;
    [[SWProgressHUD defaultView] showWithTitle: title];
    [self performSelector: @selector(hide) withObject: self afterDelay: autoCloseTime + 0.1];
}


-(void)showLoading{
    NSMutableArray *icons = [[NSMutableArray alloc] init];
    for (int i = 1 ; i <= 12; i ++) {
        [icons addObject: [UIImage imageNamed: [NSString stringWithFormat: @"loading_%d.png" , i]]];
    }
    self.iconArray = icons;
    [[SWProgressHUD defaultView] showWithTitle:nil ];
}

-(void)showMaskView{
    [self.iconArray removeAllObjects];
    self.iconArray = nil;
    [[SWProgressHUD defaultView] showWithTitle:nil ];
}

// 调整行间距
-(NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace;
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    return attributedString;
    
}


#pragma mark - frame

//BGView
- (CGRect)ViewFrame{
    if (self.iconArray.count  == 0) {
        CGSize size =  [self LabelViewFrame].size;
        self.layer.cornerRadius = size.height * 0.5;
        return CGRectMake((SCREEN_WIDTH - size.width-size.height)*0.5, SCREEN_HEIGHT*0.85, size.width+size.height, size.height);
    }else{
        self.layer.cornerRadius = 18;
        return CGRectMake((SCREEN_WIDTH - 36)*0.5, SCREEN_HEIGHT*0.85,36, 36);
    }
}

//label
- (CGRect)LabelViewFrame{
    
    CGSize size =  [self boundingRectWithSize:(CGSizeMake(SCREEN_WIDTH*0.8, 0)) string:self.title font:[UIFont systemFontOfSize:15]];
    int n =  size.height/15;
    if (n == 1) {
        return CGRectMake(((n-1) * 20+30)*0.5, 2, size.width, (n-1) * 20+30);
    }else{
        return CGRectMake(((n-1) * 20+30)*0.5, 0, size.width, (n-1) * 20+30);
    }
    
    
}
- (CGSize)boundingRectWithSize:(CGSize)size string:(NSString *)str font:(UIFont *)font{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    
    CGSize retSize = [str boundingRectWithSize:size
                                       options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                    attributes:attribute
                                       context:nil].size;
    return retSize;
}


@end
