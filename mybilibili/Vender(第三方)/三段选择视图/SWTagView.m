//
//  SWTagView.m
//  
//
//  Created by zhangsongwei on 16/5/31.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "SWTagView.h"


#define BTN_H 42 //btn 高度

#define SIZE self.frame.size  //self size

#define line_H 2 //线高

#define BTNcolor [UIColor colorWithHexString:@"eeeeee"]     //btn颜色
#define SBTNcolor [UIColor colorWithHexString:@"ffffff"]    //btn选中颜色
#define LineColor [UIColor colorWithHexString:@"ffffff"]    //xian选中颜色

#define BTNFont [UIFont systemFontOfSize:15] //btn字体
#define SBTNFont [UIFont systemFontOfSize:15]//btn 选中字体



@interface SWTagView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UILabel *line;  //线



@property (nonatomic, assign) NSInteger btnW;

@property (nonatomic, strong) NSArray *BTNTitleArray;

@property (nonatomic, strong) NSArray *viewArray;

@end


@implementation SWTagView



+(SWTagView *)navWithFrame:(CGRect)frame withBTNTitleArray:(NSArray*)BTNTitleArray{
    
    return [[SWTagView alloc]initWithFrame:frame withBTNTitleArray:BTNTitleArray];
    
}

-(instancetype)initWithFrame:(CGRect)frame withBTNTitleArray:(NSArray*)BTNTitleArray{
    
    if (self = [super initWithFrame:frame]) {

        
        self.BTNTitleArray = BTNTitleArray;
        
        self.top_H = BTN_H + line_H+20;

        
        [self createTopView];
        
        [self createScrollView];
        
        
    }
    
    return self;
    
}


-(void)setIsScroll:(BOOL)isScroll{
    
    self.scrollView.scrollEnabled = isScroll;
    
    for (UIButton * btn in self.subviews) {
        if (btn.tag >499) {
            btn.enabled = isScroll;
        }
    }
    
}


-(void)createTopView{
    
    self.backgroundColor = ItemColor;
    _btnW  = self.frame.size.width/_BTNTitleArray.count;
    
    for (int i = 0; i < self.BTNTitleArray.count; i ++) {
        UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame = CGRectMake(i * _btnW, 20, _btnW, BTN_H);
        
        [btn setTitle:_BTNTitleArray[i] forState:(UIControlStateNormal)];
        
        if (i == 0) {
            
            [btn setTitleColor:SBTNcolor forState:(UIControlStateNormal)];
            if (_titleSelectedColor) {
                [btn setTitleColor:_titleSelectedColor forState:(UIControlStateNormal)];
            }
            
        }else{
            [btn setTitleColor:BTNcolor forState:(UIControlStateNormal)];
            if (_titleColor) {
                [btn setTitleColor:_titleColor forState:(UIControlStateNormal)];
            }
            
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        if (self.itemTitleFont) {
            btn.titleLabel.font = self.itemTitleFont;
        }
        btn.tag = 500+i;
        
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [self addSubview:btn];
    }
    
    UILabel * grayLine =[[UILabel alloc]initWithFrame:(CGRectMake(0, self.top_H-0.5, SCREEN_WIDTH, 0.5))];
    grayLine.backgroundColor = [UIColor colorWithHexString:@"999999"];
    [self addSubview:grayLine];
    
    
    _line = [[UILabel alloc]initWithFrame:(CGRectMake(0, self.top_H-line_H, _btnW, line_H))];
    
//    _line.backgroundColor =LineColor;
    if (_itemColor) {
        _line.backgroundColor =_itemColor;
    }
    UIView * line  = [[UIView alloc]initWithFrame:(CGRectMake(_btnW/2-20, -8, 40, 3))];
    line.backgroundColor = [UIColor whiteColor];
    line.layer.masksToBounds = YES;
    line.layer.cornerRadius = 1.5;
    [_line addSubview:line];
    
    [self addSubview:_line];
    
}

-(void)btnClicked:(UIButton *)btn{
    
    
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = _line.frame;
        frame.origin.x = btn.frame.origin.x;
        _line.frame = frame;
        _scrollView.contentOffset = CGPointMake(frame.origin.x/_btnW * SIZE.width, 0);
        
    }];
    self.viewNum = btn.frame.origin.x/_btnW;
    if (self.delegate &&[self.delegate respondsToSelector:@selector(scrollViewNum:)]) {
        [self.delegate scrollViewNum:self.scrollView.contentOffset.x/self.frame.size.width];
    }
    
    
}

-(void)loadViewWithView:(UIView *)view PageNum:(NSInteger )num{
    
    CGRect frame = view.frame;
    frame.origin.x = num * SIZE.width;
    
    frame = CGRectMake(num * SIZE.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height);
    
    view.frame = frame;
    
    [_scrollView addSubview:view];
    
}

#pragma mark -  设置默认选择的View

-(void)setSelectedIndex:(NSInteger )selectedIndex{
    _selectedIndex = selectedIndex;
    [_scrollView setContentOffset:(CGPointMake(SIZE.width*selectedIndex, 0))     animated:NO];
}


-(void)createScrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:(CGRectMake(0, self.top_H, SIZE.width, SIZE.height - self.top_H))];
    }
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(SIZE.width * self.BTNTitleArray.count , SIZE.height - self.top_H);


    
    [self addSubview:_scrollView];
    
    
}


#pragma mark - ScroView



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    self.viewNum = scrollView.contentOffset.x/self.frame.size.width;
    
    if (self.delegate &&[self.delegate respondsToSelector:@selector(scrollViewNum:)]) {
        [self.delegate scrollViewNum:scrollView.contentOffset.x/self.frame.size.width];
    }
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    

    //线的位置移动
    [UIView animateWithDuration:0.2 animations:^{
        CGRect frame = _line.frame;
//        if (scrollView.contentOffset.x >= 0) {
            frame.origin.x = scrollView.contentOffset.x/SIZE.width *_btnW;
//        }
        
        _line.frame = frame;
        
    }];
    //btn颜色
    
    for (UIButton * btn in self.subviews) {
        if (btn.tag >499) {
            [btn setTitleColor:BTNcolor forState:(UIControlStateNormal)];
            if (_titleColor) {
                [btn setTitleColor:_titleColor forState:(UIControlStateNormal)];
            }
            
            if ((btn.frame.origin.x <= _line.frame.origin.x+_btnW/2)&&(btn.frame.origin.x+_btnW >= _line.frame.origin.x+_btnW/2)) {
                [btn setTitleColor:SBTNcolor forState:(UIControlStateNormal)];
                if (_titleSelectedColor) {
                    [btn setTitleColor:_titleSelectedColor forState:(UIControlStateNormal)];
                }
                
            }
        }
    }
    
    

}

@end

