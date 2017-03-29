//
//  FenquViewController.m
//  mybilibili
//
//  Created by 张松伟 on 16/9/11.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "FenquViewController.h"
#import "SW_FenquViewCell.h"
#import "SW_FenquHeaderView.h"

@interface FenquViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,weak) IBOutlet UICollectionView * collectionView;
@property (nonatomic,weak) IBOutlet UIView * headerView;
@property (nonatomic,strong) NSMutableArray * dataArray;



@end

@implementation FenquViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分区";
    self.tabBarItem.title = @"";
    
    [self initData];
    
    [self createUI];
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void)initData{
    
    _dataArray = [NSMutableArray array];
}

-(void)requestData{
    
//    [NetClient GET:fenqu_URL parameter:nil networkError:nil startRequest:nil success:^(id responseObject, NSURLSessionDataTask *dataTask, NetWorkClient *client) {
//        
//        
//        
//        NSArray * array = responseObject[@"data"];
//        for (NSDictionary  *dic in array) {
//            [_dataArray addObject:dic];
//        }
//        NSLog(@"%@",_dataArray);
//        [_collectionView reloadData];
//        
//    } failure:^(NSError *error, NSURLSessionDataTask *dataTask, NetWorkClient *client) {
//        
//    }];
    
}
#pragma mark - kaishi 

-(void)createUI{
    _headerView.frame = CGRectMake(0, -SCREEN_WIDTH, SCREEN_WIDTH, SCREEN_WIDTH);
    [_collectionView addSubview:_headerView];
    _collectionView.contentInset = UIEdgeInsetsMake(SCREEN_WIDTH, 0, 0, 0);
    [_collectionView registerNib:[UINib nibWithNibName:@"SW_FenquViewCell" bundle:nil] forCellWithReuseIdentifier:@"SW_FenquViewCell"];
    
    
}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    
    
    SW_FenquViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SW_FenquViewCell" forIndexPath:indexPath];
    if (_dataArray.count) {
        
        NSDictionary * dic =  _dataArray[indexPath.row];
        
//        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:(NSString *)dic[@"logo"]]];
//        cell.title.text = (NSString *)dic[@"name"];

    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 6;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
    
    
}





@end
