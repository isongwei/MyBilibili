//
//  MainTabViewController.m
//  MyFrameWork
//
//  Created by 张松伟 on 16/4/13.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "RootTabViewController.h"
#import "BaseNavViewController.h"




@interface RootTabViewController ()
@property (nonatomic,strong)NSMutableArray *array;
@end

@implementation RootTabViewController


-(instancetype)init{
    
    if (self = [super init]) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _array = [NSMutableArray array];

    [self createUI];

    
    
    [self addViewControllerString:@"ShouyeViewController" Title:@"首页" SelectImagestr:@"home_home_tab_s" imagestr:@"home_home_tab"];
    [self addViewControllerString:@"FenquViewController" Title:@"分区" SelectImagestr:@"home_category_tab_s" imagestr:@"home_category_tab"];
    [self addViewControllerString:@"GuanzhuViewController" Title:@"关注" SelectImagestr:@"home_attention_tab_s" imagestr:@"home_attention_tab"];
    [self addViewControllerString:@"FaxianViewController" Title:@"发现" SelectImagestr:@"home_discovery_tab_s" imagestr:@"home_discovery_tab"];
    [self addViewControllerString:@"WodeViewController" Title:@"我的" SelectImagestr:@"home_mine_tab_s" imagestr:@"home_mine_tab"];
    
 
    
    

}

-(void)createUI{
    
    
    
    //点击颜色
    self.tabBar.tintColor = [UIColor redColor];
    self.tabBar.barTintColor = [UIColor whiteColor];

    
    
    
    
    
}

-(void)addViewControllerString:(NSString *)ctrlName Title:(NSString *)title SelectImagestr:(NSString *)selectImagestr imagestr:(NSString *)imagestr{

    Class class = NSClassFromString(ctrlName);
    UIViewController * VC = [[class alloc]init];
    
    BaseNavViewController * nav = [[BaseNavViewController alloc]initWithRootViewController:VC];
    VC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
    VC.tabBarItem.image = [[UIImage imageNamed:imagestr] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:selectImagestr] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)];
//    VC.title = title;
    
    
    
    
    [_array addObject:nav];
    self.viewControllers = _array;
}- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}





@end
