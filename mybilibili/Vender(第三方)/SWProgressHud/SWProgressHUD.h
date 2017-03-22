//
//  SWProgressHUD.h
//  MMT-Loan
//
//  Created by iSongWei on 2016/11/30.
//  Copyright © 2016年 iSong. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface SWProgressHUD : UIView

+ (SWProgressHUD *)defaultView;
-(void)showTitle: (NSString *)title autoCloseTime: (CGFloat)autoCloseTime;
-(void)showMaskView;
-(void)showLoading;
-(void)hide;

@end
