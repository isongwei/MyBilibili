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
#import "SW_FenquHeaderCell.h"



@interface FenquViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,weak) IBOutlet UICollectionView * collectionView;
@property (nonatomic,strong)  SW_FenquHeaderView * headerView;//头
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


-(void)initData{
    
    _dataArray = [NSMutableArray array];
}

-(void)requestData{
    
    
    [NetClient GET:fenquAll_URL parameter:nil startRequest:nil success:^(MainModel *MainModel) {
        NSArray * dataArr = MainModel.data;
        for (NSDictionary * dic in dataArr) {
            [_dataArray addObject:dic];
        }
        [_collectionView reloadData];

    }failure:^(NSError *error) {
        
    }];
    
}
#pragma mark - kaishi

-(void)createUI{

    SW_FenquHeaderView * view = [[[NSBundle mainBundle]loadNibNamed:@"SW_FenquHeaderView" owner:nil options:nil] firstObject];
    
    view.frame = CGRectMake(0, -SCREEN_WIDTH/4.0*3.0, SCREEN_WIDTH, SCREEN_WIDTH/4.0*3.0);
    [_collectionView addSubview:view];
    
    
    _collectionView.contentInset = UIEdgeInsetsMake(SCREEN_WIDTH/4.0*3.0, 0, 0, 0);
    [_collectionView registerNib:[UINib nibWithNibName:@"SW_FenquViewCell" bundle:nil] forCellWithReuseIdentifier:@"SW_FenquViewCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"SW_FenquHeaderCell" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SW_FenquHeaderCell"];
    
    
}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:( UICollectionView *)collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath{
    
    
    if (collectionView == _collectionView) {
        SW_FenquViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SW_FenquViewCell" forIndexPath:indexPath];
        if (_dataArray.count) {
            NSArray * dicArr = _dataArray[indexPath.section][@"body"];
            indexPath.row < dicArr.count?cell.infoDic = dicArr[indexPath.row]:nil;
            return cell;
        }
        

    }
    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    SW_FenquHeaderCell * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SW_FenquHeaderCell" forIndexPath:indexPath];
    if (_dataArray.count && ([kind isEqualToString:UICollectionElementKindSectionHeader])) {
        
        NSDictionary * dic =  _dataArray[indexPath.section];
        header.infoDic = dic;
        
        
    }
    
    return header;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    
    SW_VideoViewController * vc = [[SW_VideoViewController alloc]init];
    NSArray * array = _dataArray[indexPath.section][@"body"];
    vc.paramCode =array[indexPath.row][@"param"];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _dataArray.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
    
    
}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_WIDTH, 30);
}





@end
