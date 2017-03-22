//
//  SWTagView.h
//
//
//  Created by zhangsongwei on 16/5/31.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import <UIKit/UIKit.h>





@protocol SWTagViewDelegate <NSObject>

//传出偏移量
-(void)scrollViewNum:(NSInteger)ViewNum;

//-(void)tagViewButtonClicked:(NSInteger)buttonIndex;

@end





@interface SWTagView : UIView


@property (nonatomic, assign) CGFloat top_H;
@property (nonatomic, assign) NSInteger viewNum;//页数
@property (nonatomic, assign) BOOL isScroll;//能否滚动
@property (nonatomic,assign) NSInteger  selectedIndex;//默认选择的View

@property (nonatomic, strong) UIScrollView *scrollView;//滚动视图

@property (nonatomic, strong) UIColor *titleSelectedColor;//标题选中颜色
@property (nonatomic, strong) UIColor *titleColor;//标题颜色
@property (nonatomic, strong) UIColor *itemColor;//主题颜色
@property (nonatomic, strong) UIFont *itemTitleFont;//button  字体大小




@property (nonatomic, assign) id <SWTagViewDelegate> delegate;//代理




+(SWTagView *)navWithFrame:(CGRect)frame withBTNTitleArray:(NSArray*)withBTNTitleArray;//加视图

-(void)loadViewWithView:(UIView *)view PageNum:(NSInteger )num;



@end
