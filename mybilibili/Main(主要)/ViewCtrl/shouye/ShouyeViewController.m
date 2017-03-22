//
//  ShouyeViewController.m
//  mybilibili
//
//  Created by 张松伟 on 16/9/11.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "ShouyeViewController.h"
#import "SWTagView.h"

#import "ZhiboViewController.h"//zhibo
#import "TuijianViewController.h"
#import "FanjuViewController.h"



@interface ShouyeViewController ()<SWTagViewDelegate>

@property (nonatomic,strong) SWTagView * tagView;


@property (nonatomic,strong) ZhiboViewController * view1;
@property (nonatomic,strong) TuijianViewController * view2;
@property (nonatomic,strong) FanjuViewController * view3;

@end

@implementation ShouyeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    DLOG(@"%@",NSStringFromCGRect(self.view.bounds));
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


#pragma mark - initrr


-(void)createUI{
    
    _tagView = [SWTagView navWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-0) withBTNTitleArray:@[@"直播",@"推荐",@"番剧"]];
    _tagView.delegate  = self;
    _tagView.selectedIndex = 1;
    
    
    _view1 = [[ZhiboViewController alloc]init];
    [_tagView loadViewWithView:_view1.view PageNum:0];
    _view1.navCtrl = self.navigationController;
    
    
    _view2 = [[TuijianViewController alloc]init];
    [_tagView loadViewWithView:_view2.view PageNum:1];
    _view2.navCtrl = self.navigationController;
    
    _view3 = [[FanjuViewController alloc]init];
    [_tagView loadViewWithView:_view3.view PageNum:2];
    _view3.navCtrl = self.navigationController;
    
    [self.view addSubview:_tagView];
    
    
}



-(void)scrollViewNum:(NSInteger)ViewNum{
    
    
    if (ViewNum == 1) {

    }
}



@end
