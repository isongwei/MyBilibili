//
//  BaseViewController.m
//  maimaiti2.0
//
//  Created by zhangsongwei on 16/7/25.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

//将要出现
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

//已经出现
-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    
}


//将要消失
-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}
//已经消失
-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
}


@end
