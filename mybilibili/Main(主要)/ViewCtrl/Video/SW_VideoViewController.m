//
//  SW_VideoViewController.m
//  mybilibili
//
//  Created by 张松伟 on 2017/1/12.
//  Copyright © 2017年 张松伟. All rights reserved.
//

#import "SW_VideoViewController.h"
#import "SW_videoCell.h"//cell
#import "SW_CommentDetailsVC.h"//评论详情
#import "SW_CommentDetailsView.h"

#import "WMPlayer.h"





@interface SW_VideoViewController ()<UITableViewDelegate,UITableViewDataSource,WMPlayerDelegate>
{
    WMPlayer *wmPlayer;
    

}
@property (nonatomic,weak) IBOutlet UIView * contentView;
@property (nonatomic,weak) IBOutlet UIScrollView * scrollView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentView_Y;
@property (nonatomic,weak) IBOutlet UIImageView * TVImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TVImage_L;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TVImage_B;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TVImage_W;
/*==========*/

@property (nonatomic,weak)IBOutlet UIImageView * videoImage;

@property (nonatomic,strong) UITableView * tableView_related;
@property (nonatomic,strong) NSMutableArray * relatedDataArr;

@property (nonatomic,strong) SW_CommentDetailsView * commentDetailsView;


@end
@implementation SW_VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"sda";
    
    [self initData];
    
    [self createUI];
    [self createPlayer];
    
    [self requestDataWithParamCode:self.paramCode];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
    //旋转屏幕通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onDeviceOrientationChange)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil
     ];
}
#pragma mark - init

-(void)initData{
    _relatedDataArr = [NSMutableArray array];
    
}
- (IBAction)popView:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 全屏转换/*-------------------------------*/
/**
 *  旋转屏幕通知
 */
- (void)onDeviceOrientationChange{
    if (wmPlayer==nil||wmPlayer.superview==nil){
        return;
    }
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)orientation;
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortraitUpsideDown:{
            NSLog(@"第3个旋转方向---电池栏在下");
        }
            break;
        case UIInterfaceOrientationPortrait:{
            NSLog(@"第0个旋转方向---电池栏在上");
            if (wmPlayer.isFullscreen) {
                //全屏
            }
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:{
            NSLog(@"第2个旋转方向---电池栏在左");
            wmPlayer.isFullscreen = YES;
            [self setNeedsStatusBarAppearanceUpdate];
            [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        case UIInterfaceOrientationLandscapeRight:{
            NSLog(@"第1个旋转方向---电池栏在右");
            wmPlayer.isFullscreen = YES;
            [self setNeedsStatusBarAppearanceUpdate];
            [self toFullScreenWithInterfaceOrientation:interfaceOrientation];
        }
            break;
        default:
            break;
    }
}


-(void)toFullScreenWithInterfaceOrientation:(UIInterfaceOrientation )interfaceOrientation{
    [wmPlayer removeFromSuperview];
    wmPlayer.dragEnable = NO;
    wmPlayer.transform = CGAffineTransformIdentity;
    if (interfaceOrientation==UIInterfaceOrientationLandscapeLeft) {
        wmPlayer.transform = CGAffineTransformMakeRotation(-M_PI_2);
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        wmPlayer.transform = CGAffineTransformMakeRotation(M_PI_2);
    }
    wmPlayer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    wmPlayer.playerLayer.frame =  CGRectMake(0,0, [UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width);
    
    [wmPlayer.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.height);
        make.height.mas_equalTo([UIScreen mainScreen].bounds.size.width);
        make.left.equalTo(wmPlayer).with.offset(0);
        make.top.equalTo(wmPlayer).with.offset(0);
    }];
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        wmPlayer.effectView.frame = CGRectMake([UIScreen mainScreen].bounds.size.height/2-155/2, [UIScreen mainScreen].bounds.size.width/2-155/2, 155, 155);
    }else{
        //        wmPlayer.lightView.frame = CGRectMake(kScreenHeight/2-155/2, kScreenWidth/2-155/2, 155, 155);
    }
    [wmPlayer.FF_View  mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wmPlayer).with.offset([UIScreen mainScreen].bounds.size.height/2-120/2);
        make.top.equalTo(wmPlayer).with.offset([UIScreen mainScreen].bounds.size.width/2-60/2);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(120);
    }];
    [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.height);
        make.bottom.equalTo(wmPlayer.contentView).with.offset(0);
    }];
    
    [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(70);
        make.left.equalTo(wmPlayer).with.offset(0);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.height);
    }];
    
    [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wmPlayer.topView).with.offset(5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.top.equalTo(wmPlayer).with.offset(20);
        
    }];
    
    [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wmPlayer.topView).with.offset(45);
        make.right.equalTo(wmPlayer.topView).with.offset(-45);
        make.center.equalTo(wmPlayer.topView);
        make.top.equalTo(wmPlayer.topView).with.offset(0);
    }];
    
    [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wmPlayer).with.offset(0);
        make.top.equalTo(wmPlayer).with.offset([UIScreen mainScreen].bounds.size.width/2-30/2);
        make.height.equalTo(@30);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.height);
    }];
    
    [wmPlayer.loadingView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wmPlayer).with.offset([UIScreen mainScreen].bounds.size.height/2-22/2);
        make.top.equalTo(wmPlayer).with.offset([UIScreen mainScreen].bounds.size.width/2-22/2);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(22);
    }];
    
    [self.view addSubview:wmPlayer];
    [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
    wmPlayer.fullScreenBtn.selected = YES;
    wmPlayer.isFullscreen = YES;
    wmPlayer.FF_View.hidden = YES;
}

#pragma mark - 全屏显示/*-------------------------------*/

///播放器事件
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)closeBtn{
    NSLog(@"didClickedCloseButton");

    [self releaseWMPlayer];
    [self setNeedsStatusBarAppearanceUpdate];
    
}
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    if (fullScreenBtn.isSelected) {//全屏显示
        wmPlayer.isFullscreen = YES;
        [self setNeedsStatusBarAppearanceUpdate];
        [self toFullScreenWithInterfaceOrientation:UIInterfaceOrientationLandscapeLeft];
    }else{
        //退出全屏
        [self toSmallScreen];
    }
}
-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    NSLog(@"didSingleTaped");
}
-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    NSLog(@"didDoubleTaped");
}

///播放状态
-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"wmplayerDidFailedPlay");
}
-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    NSLog(@"wmplayerDidReadyToPlay");
}
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{
    NSLog(@"wmplayerDidFinishedPlay");
    [self releaseWMPlayer];
    [self setNeedsStatusBarAppearanceUpdate];
}




#pragma mark - 释放WMPlayer

-(void)releaseWMPlayer{
    //堵塞主线程
    //    [wmPlayer.player.currentItem cancelPendingSeeks];
    //    [wmPlayer.player.currentItem.asset cancelLoading];
    [wmPlayer pause];
    
    
    [wmPlayer removeFromSuperview];
    [wmPlayer.playerLayer removeFromSuperlayer];
    [wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    wmPlayer.player = nil;
    wmPlayer.currentItem = nil;
    //释放定时器，否侧不会调用WMPlayer中的dealloc方法
    [wmPlayer.autoDismissTimer invalidate];
    wmPlayer.autoDismissTimer = nil;
    
    
    wmPlayer.playOrPauseBtn = nil;
    wmPlayer.playerLayer = nil;
    wmPlayer = nil;
}
#pragma mark - 释放Video
-(void)dealloc{
    NSLog(@"%@ dealloc",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self releaseWMPlayer];
}

#pragma mark - video
-(BOOL)prefersStatusBarHidden{
    if (wmPlayer) {
        if (wmPlayer.isFullscreen) {
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}
#pragma mark - video
-(void)createUI{
    
    
    
    //播放视频
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2 , SCREEN_HEIGHT-104);
    //添加左侧
    [_scrollView addSubview:self.tableView_related];
    //添加右侧
    _commentDetailsView = [[SW_CommentDetailsView alloc]initWithFrame:(CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, 200))];
    _commentDetailsView.NAV = self.navigationController;
    _commentDetailsView.oid = self.paramCode;
    [_scrollView addSubview:_commentDetailsView];

}

#pragma mark - createPlayer
-(void)createPlayer{

    if (wmPlayer) {
        [self releaseWMPlayer];
        
        wmPlayer = [[WMPlayer alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/1.8)];
        wmPlayer.delegate = self;
        //关闭音量调节的手势
        wmPlayer.enableVolumeGesture = NO;
        wmPlayer.closeBtnStyle = CloseBtnStyleClose;
        wmPlayer.URLString = @"http://flv2.bn.netease.com/videolib3/1701/24/pOEZG4698/SD/pOEZG4698-mobile.mp4";
        wmPlayer.titleLabel.text = @"bilibili测试";
        //        [wmPlayer play];
    }else{
        wmPlayer = [[WMPlayer alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/1.8)];
        wmPlayer.delegate = self;
        wmPlayer.closeBtnStyle = CloseBtnStyleClose;
        //关闭音量调节的手势
        wmPlayer.enableVolumeGesture = NO;
        wmPlayer.URLString = @"http://flv2.bn.netease.com/videolib3/1701/24/pOEZG4698/SD/pOEZG4698-mobile.mp4";
        wmPlayer.titleLabel.text = @"bilibili测试";
    }
    [self.view addSubview:wmPlayer];
    


}

#pragma mark - requestData

-(void)requestDataWithParamCode:(NSString *)code{
    
    [NetClient GET:[NSString stringWithFormat:video_URL,code] parameter:nil startRequest:nil success:^(MainModel *MainModel) {
        [_videoImage sd_setImageWithURL:[NSURL URLWithString: (NSString *)MainModel.data[@"pic"] ]];
        [_relatedDataArr  removeAllObjects];
        NSArray * relatesArr = (MainModel.data)[@"relates"];
        for (NSDictionary * dic in relatesArr){
            [_relatedDataArr addObject:dic];
        }
 
        [_tableView_related reloadData];
        _commentDetailsView.oid = code;
    } failure:^(NSError *error) {
        
    }];

    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == _tableView_related) {
//        _contentView_Y.constant > 0?(_contentView_Y.constant = 0):(-_contentView_Y.constant > (SCREEN_WIDTH/1.8-64)?(_contentView_Y.constant = -(SCREEN_WIDTH/1.8-64)):(_contentView_Y.constant -= (scrollView.contentOffset.y-m)*0.4));
//        m = scrollView.contentOffset.y;
        
        
//        WMPlayerStateStopped,        //暂停播放
//        WMPlayerStateFinished,        //暂停播放
//        WMPlayerStatePause,       // 暂停播放
        if (wmPlayer.state == WMPlayerStateStopped ||
            wmPlayer.state == WMPlayerStateFinished ||
            wmPlayer.state == WMPlayerStatePause ) {
            if (scrollView.contentOffset.y >= 0) {
                _contentView_Y.constant = -scrollView.contentOffset.y*0.4 > -(SCREEN_WIDTH/1.8-64)? -scrollView.contentOffset.y*0.4: -(SCREEN_WIDTH/1.8-64);
            }else{
                _contentView_Y.constant = 0;
            }
            [self viewDidLayoutSubviews];
        }

    }

}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == _scrollView) {
        UIButton * btn_l = (id)[_contentView viewWithTag:1001];
        UIButton * btn_r = (id)[_contentView viewWithTag:1002];
        if (scrollView.contentOffset.x == 0) {
            btn_l.selected = YES;
            btn_r.selected = NO;
        }else{
            btn_l.selected = NO;
            btn_r.selected = YES;
        }
    }
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.view sendSubviewToBack:_contentView];
    _tableView_related.frame = CGRectMake(0, 0, SCREEN_WIDTH, -_contentView_Y.constant + SCREEN_HEIGHT - SCREEN_WIDTH/1.8-40);
    _commentDetailsView.frame =CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, -_contentView_Y.constant + SCREEN_HEIGHT - SCREEN_WIDTH/1.8-40);
    
    
    if (_scrollView.contentOffset.y >= 0) {
        float m = -_contentView_Y.constant/(SCREEN_WIDTH/1.8-64);//0 - 1
        float n = 1-m*0.35;
        _TVImage_W.constant = 43.0*n;
        _TVImage_B.constant = -15;
        //0.3-   -100
        _TVImage_L.constant = -((SCREEN_WIDTH*(1-0.3)-60)*m +60);
    }
    
    
}

-(IBAction)leftOrRight:(UIButton *)sender{
    
    UIButton * btn_l = (id)[_contentView viewWithTag:1001];
    UIButton * btn_r = (id)[_contentView viewWithTag:1002];
    btn_l.selected = NO;
    btn_r.selected = NO;
    sender.selected = YES;
    if (sender.tag == 1001) {
        [_scrollView setContentOffset:(CGPointMake(0, 0)) animated:YES];
    }else{
        [_scrollView setContentOffset:(CGPointMake(SCREEN_WIDTH, 0)) animated:YES];
    }
    
}

#pragma mark - UITableViewDelegate

-(UITableView *)tableView_related{
    
    if (!_tableView_related) {
        _tableView_related = [[UITableView alloc]initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 200)) style:(UITableViewStylePlain)];
        _tableView_related.delegate = self;
        _tableView_related.dataSource = self;
        _tableView_related.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView_related registerNib:[UINib nibWithNibName:@"SW_videoCell" bundle:nil] forCellReuseIdentifier:@"SW_videoCell"];
    }
    return _tableView_related;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _relatedDataArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 85;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * aCell = @"SW_videoCell";
    SW_videoCell * cell =  [tableView dequeueReusableCellWithIdentifier:aCell];
    cell.infoDic  = _relatedDataArr[indexPath.row];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self requestDataWithParamCode:_relatedDataArr[indexPath.row][@"aid"]];
    
}

#pragma mark - 全屏时
-(void)toSmallScreen{
    //放widow上
    wmPlayer.dragEnable = YES;
    [wmPlayer removeFromSuperview];
    [UIView animateWithDuration:0.7f animations:^{
        wmPlayer.transform = CGAffineTransformIdentity;
        wmPlayer.frame = CGRectMake([UIScreen mainScreen].bounds.size.width/2,[UIScreen mainScreen].bounds.size.height-49-([UIScreen mainScreen].bounds.size.width/2)*0.75, [UIScreen mainScreen].bounds.size.width/2, ([UIScreen mainScreen].bounds.size.width/2)*0.75);
        wmPlayer.freeRect = CGRectMake(0,64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-49);
        wmPlayer.playerLayer.frame =  wmPlayer.bounds;
        [[UIApplication sharedApplication].keyWindow addSubview:wmPlayer];
        
        [wmPlayer.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width/2);
            make.height.mas_equalTo(([UIScreen mainScreen].bounds.size.width/2)*0.75);
            make.left.equalTo(wmPlayer).with.offset(0);
            make.top.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.bottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.bottom.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(0);
            make.right.equalTo(wmPlayer).with.offset(0);
            make.height.mas_equalTo(40);
            make.top.equalTo(wmPlayer).with.offset(0);
        }];
        [wmPlayer.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer.topView).with.offset(45);
            make.right.equalTo(wmPlayer.topView).with.offset(-45);
            make.center.equalTo(wmPlayer.topView);
            make.top.equalTo(wmPlayer.topView).with.offset(0);
        }];
        [wmPlayer.closeBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(wmPlayer).with.offset(5);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(30);
            make.top.equalTo(wmPlayer).with.offset(5);
            
        }];
        [wmPlayer.loadFailedLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(wmPlayer);
            make.width.equalTo(wmPlayer);
            make.height.equalTo(@30);
        }];
        
    }completion:^(BOOL finished) {
        wmPlayer.isFullscreen = NO;
        [self setNeedsStatusBarAppearanceUpdate];
        wmPlayer.fullScreenBtn.selected = NO;
        wmPlayer.FF_View.hidden = YES;
        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:wmPlayer];
    }];
    
}




@end
