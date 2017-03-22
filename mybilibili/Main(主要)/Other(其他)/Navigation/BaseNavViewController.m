//
//  MainNavViewController.m
//  MyFrameWork
//
//  Created by 张松伟 on 16/4/13.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "BaseNavViewController.h"
#define BACK_BTN_FRAME CGRectMake(0.0f, 0.0f, 48.0f, 44.0f)
@interface BaseNavViewController ()

@end

@implementation BaseNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置一张空的图片
    [self.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    //设置一张空的图片
    [self.navigationBar setShadowImage:[[UIImage alloc]init]];
    

}



-(void)popself
{
    [self popViewControllerAnimated:YES];
}
-(UIBarButtonItem*) createBackButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:BACK_BTN_FRAME];
    [button addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:@"nav_w"] forState:UIControlStateNormal];

    UIBarButtonItem *leftitem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    
    
    
    UIBarButtonItem  *item = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"nav_w"] imageWithRenderingMode:(UIImageRenderingModeAlwaysOriginal)]style:(UIBarButtonItemStyleDone) target:self action:@selector(popself)];
    return item;
}

-(instancetype)initWithRootViewController:(UIViewController *)rootViewController{
    
    if ([super initWithRootViewController:rootViewController]) {
        
        //修改导航栏文字字体和颜色

        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Medium" size:15]};

        self.navigationBar.translucent = NO;
        self.navigationBar.barTintColor = ItemColor;
        

        
    }
    return self;
    
}
-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    
    
    return [super popViewControllerAnimated:animated];
    
}







//push进入下一层界面
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action : nil ];
    
    viewController.navigationItem.backBarButtonItem = item;
    // 判断是否为栈底控制器
    if (self.viewControllers.count >0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        if (viewController.navigationItem.leftBarButtonItem== nil ) {
            //设置导航子控制器按钮的加载样式
            viewController.navigationItem.leftBarButtonItem =[self createBackButton];
        }
        
        
    }
    
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1) {
        //设置导航子控制器按钮的加载样式
    
    }
    

    
    [super pushViewController:viewController animated:animated];
   
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
