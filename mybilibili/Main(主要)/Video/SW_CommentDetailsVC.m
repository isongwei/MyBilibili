//
//  SW_CommentDetailsVC.m
//  mybilibili
//
//  Created by iSongWei on 2017/1/24.
//  Copyright © 2017年 张松伟. All rights reserved.
//

#import "SW_CommentDetailsVC.h"

@interface SW_CommentDetailsVC ()

@end

@implementation SW_CommentDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论详情";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}



@end
