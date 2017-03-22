//
//  GuanzhuViewController.m
//  mybilibili
//
//  Created by 张松伟 on 16/9/11.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "GuanzhuViewController.h"

#import "SWTagView.h"

#import "ZhuifanViewController.h"
#import "DongtaiViewController.h"
#import "BiaoqianViewController.h"

@interface GuanzhuViewController ()
@property (nonatomic,strong) SWTagView * tagView;
@end

@implementation GuanzhuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
#pragma mark - init


-(void)createUI{
    
    
    _tagView = [SWTagView navWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-0) withBTNTitleArray:@[@"动态",@"标签"]];
    
//    ZhuifanViewController * view1 = [[ZhuifanViewController alloc]init];
//    [_tagView loadViewWithView:view1.view PageNum:0];
    
    DongtaiViewController * view2 = [[DongtaiViewController alloc]init];
    [_tagView loadViewWithView:view2.view PageNum:0];
    
    BiaoqianViewController * view3 = [[BiaoqianViewController alloc]init];
    [_tagView loadViewWithView:view3.view PageNum:1];
    

    
    [self.view addSubview:_tagView];
    
    
    
    
}

@end
