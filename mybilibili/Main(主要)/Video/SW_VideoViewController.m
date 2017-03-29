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







@interface SW_VideoViewController ()<UITableViewDelegate,UITableViewDataSource>

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
    
    
    [self requestDataWithParamCode:self.paramCode];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
 }
#pragma mark - init

-(void)initData{
    _relatedDataArr = [NSMutableArray array];
    
}
- (IBAction)popView:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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


@end
