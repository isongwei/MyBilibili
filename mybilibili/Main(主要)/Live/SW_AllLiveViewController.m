//
//  SW_AllLiveViewController.m
//  mybilibili
//
//  Created by 张松伟 on 2016/10/6.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "SW_AllLiveViewController.h"

@interface SW_AllLiveViewController ()

@property (nonatomic,strong) SWTagView * tagView;

@end

@implementation SW_AllLiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"所有直播";

    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)createUI{
    
    _tagView = [SWTagView navWithFrame:(CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49)) withBTNTitleArray:@[@"最热",@"最新"]];
    
    
    
    
    
}





@end
