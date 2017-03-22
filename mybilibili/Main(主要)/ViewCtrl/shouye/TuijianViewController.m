//
//  TuijianViewController.m
//  mybilibili
//
//  Created by 张松伟 on 16/9/11.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "TuijianViewController.h"
#import "SW_TuijianCollectionViewCell.h"
#import "SW_TuijianCollectionReusableView.h"


@interface TuijianViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>

@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;
@property (strong, nonatomic) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) NSMutableArray * imageArray;
@property (nonatomic,strong) NSMutableArray * urlArray;



@end

@implementation TuijianViewController





- (void)viewDidLoad {

    
    [self initData];
    
    [self createUI];
    
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


-(void)initData{
    
    _dataArray = [NSMutableArray array];
    _urlArray = [NSMutableArray array];
    _imageArray = [NSMutableArray array];
}

-(void)requestData{
    
    
    [NetClient GET:tuijian_URL parameter:nil startRequest:nil success:^(MainModel *MainModel) {
        
                if (_collectionView.mj_header) {
                    [_collectionView.mj_header endRefreshing];
                }
        
        NSArray * array = MainModel.data;
                //轮播数据
                NSArray * banner =  array[0][@"banner"][@"top"];
                for (NSDictionary * dic in banner) {
                    [_imageArray addObject:dic[@"image"]];
                    [_urlArray addObject:dic[@"uri"]];
                }
        
                //下面数据
                if (array.count) {
                    [_dataArray addObject:array[0]];
                }
        
                for (NSDictionary * dic in array) {
                    [_dataArray addObject:dic];
                }

                [_collectionView reloadData];
                _cycleScrollView.imageURLStringsGroup = _imageArray;
    } failure:^(NSError *error) {
        
    }];
    
}
#pragma mark - kaishi

-(void)createUI{
    

    
    // 网络加载图片的轮播器
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/3) delegate:self placeholderImage:nil];
    _cycleScrollView.imageURLStringsGroup = @[];
    
    
    self.view.backgroundColor  = [UIColor whiteColor];
    
    //滑动图
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-30)/2, (SCREEN_WIDTH-30)/2);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    
    
    
    
    
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) collectionViewLayout:flowLayout];
    _collectionView.showsHorizontalScrollIndicator = NO;
//    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    
    
    [_collectionView registerNib:[UINib nibWithNibName:@"SW_TuijianCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SW_TuijianCollectionViewCell"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"SW_TuijianCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SW_TuijianCollectionReusableView"];
    
    [self.view addSubview:_collectionView];
    [_collectionView addSubview:_cycleScrollView];
    
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [_imageArray removeAllObjects];
        [_dataArray removeAllObjects];
        [self requestData];
        
    }];
    
    
}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    SW_TuijianCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SW_TuijianCollectionViewCell" forIndexPath:indexPath];
    if (_dataArray.count) {
        NSArray * array = _dataArray[indexPath.section][@"body"];
        if (indexPath.row < array.count) {

            cell.infoDic = array[indexPath.row];
        }
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    SW_VideoViewController * vc = [[SW_VideoViewController alloc]init];
    NSArray * array = _dataArray[indexPath.section][@"body"];
    vc.paramCode =array[indexPath.row][@"param"];
    [self.navCtrl pushViewController:vc animated:YES];
    
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    

    return  [_dataArray count];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    NSArray * array = _dataArray[section][@"body"];
    if (section == 0) {
        return 1;
    }
    return [array count];
    
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/3);
    }
    return CGSizeMake((SCREEN_WIDTH-30)/2, (SCREEN_WIDTH-30)/2);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    SW_TuijianCollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SW_TuijianCollectionReusableView" forIndexPath:indexPath];
    if (_dataArray.count) {
        NSDictionary * dic =  _dataArray[indexPath.section];
        header.title.text = dic[@"title"];
    }
    
    return header;
}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={SCREEN_WIDTH ,35};
    
    if (section == 0) {
        return CGSizeZero;
    }
    return size;
}


/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    SW_H5ViewController  * vc = [[SW_H5ViewController alloc]init];
    vc.url = _urlArray[index];
    [self.navCtrl pushViewController:vc animated:YES];

    
}
@end
