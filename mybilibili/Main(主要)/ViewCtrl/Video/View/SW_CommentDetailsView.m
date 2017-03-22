//
//  SW_CommentDetailsView.m
//  mybilibili
//
//  Created by iSongWei on 2017/1/19.
//  Copyright © 2017年 张松伟. All rights reserved.
//

#import "SW_CommentDetailsView.h"
#import "SW_CommentDetailsCell.h"
#import "SW_CommentDetailsVC.h"

@interface SW_CommentDetailsView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSMutableArray * dataArray;


@end
@implementation SW_CommentDetailsView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initData];
        [self initView];
    }
    return self;
}

#pragma mark - init

-(void)initData{
    _dataArray = [NSMutableArray array];
}


-(void)initView{
    
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [self addSubview:self.tableView];
    
}
-(void)layoutSubviews{
    self.tableView.frame = self.bounds;
}


-(void)setOid:(NSString *)oid{
    _oid = oid;
    [NetClient GET:[NSString stringWithFormat:tuijian_comments_URL,oid  ] parameter:nil startRequest:nil success:^(MainModel *MainModel) {
        [_dataArray removeAllObjects];
        NSArray * dataArr1 = MainModel.data[@"hots"];
        for (NSDictionary * dic in dataArr1) {
            [_dataArray addObject:dic];
        }
        
        NSArray * dataArr2 = MainModel.data[@"replies"];
        for (NSDictionary * dic in dataArr2) {
            [_dataArray addObject:dic];
        }
        [_tableView reloadData];
    }failure:^(NSError *error) {
        
    }];
}
#pragma mark - UIDelegate
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"SW_CommentDetailsCell" bundle:nil] forCellReuseIdentifier:@"SW_CommentDetailsCell"];
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id model = self.dataArray[indexPath.row];
    // 获取cell高度
    return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"infoDic" cellClass:[SW_CommentDetailsCell class] contentViewWidth:SCREEN_WIDTH];
    return 100;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString * aCell = @"SW_CommentDetailsCell";
    SW_CommentDetailsCell * cell =  [tableView dequeueReusableCellWithIdentifier:aCell];
    cell.infoDic = _dataArray[indexPath.row];
    cell.replyToDetail = ^{
        SW_CommentDetailsVC * vc =[[SW_CommentDetailsVC alloc]init];
        [self.NAV pushViewController:vc animated:YES];
    };
    return cell;
    
}


@end
