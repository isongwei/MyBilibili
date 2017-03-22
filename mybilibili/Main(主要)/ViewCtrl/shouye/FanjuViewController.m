//
//  FanjuViewController.m
//  mybilibili
//
//  Created by 张松伟 on 16/9/11.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "FanjuViewController.h"







#import "ItemHeaderView.h"
#import "SW_FanjuCollectionViewCell.h"
#import "SW_Fanju2CollectionViewCell.h"





@interface FanjuViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>


@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) NSMutableArray * imageArray;
@property (nonatomic,strong) NSMutableArray * urlArray;

@end

@implementation FanjuViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    [self initData];
    
    [self createUI];
    
    [self requestData];
    
    [self requestData2];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)initData{
    
    _dataArr = [NSMutableArray array];
    _imageArray = [NSMutableArray array];
    
    _urlArray= [NSMutableArray array];
}

-(void)createUI{
    self.view.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    
    
    
    
    // 网络加载图片的轮播器
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/3) delegate:self placeholderImage:nil];
    
    _cycleScrollView.imageURLStringsGroup = @[];
    
    
    
    
    //滑动图
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-30)/2, (SCREEN_WIDTH-30)/2*0.6 + 30);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    
    
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) collectionViewLayout:flowLayout];
    _collectionView.showsHorizontalScrollIndicator = NO;
//    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    
    
    
    
    [_collectionView registerNib:[UINib nibWithNibName:@"SW_FanjuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SW_FanjuCollectionViewCell"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"SW_Fanju2CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SW_Fanju2CollectionViewCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"ItemHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ItemHeaderView"];
    
    
    
    [self.view addSubview:_collectionView];
    [_collectionView addSubview:_cycleScrollView];
    
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [_imageArray removeAllObjects];
        [_dataArr removeAllObjects];
        [self requestData];
        [self requestData2];
        
    }];
    
    
    
    
}
#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    
    SW_FanjuCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SW_FanjuCollectionViewCell" forIndexPath:indexPath];
    SW_Fanju2CollectionViewCell * cell1 = [collectionView dequeueReusableCellWithReuseIdentifier:@"SW_Fanju2CollectionViewCell" forIndexPath:indexPath];
    if (_dataArr.count) {
        
        
        if (indexPath.section == 1 || indexPath.section == 2) {
            NSDictionary * dic =  _dataArr[indexPath.section][indexPath.row];
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"cover"]]];
            cell.title.text = dic[@"title"];
            return cell;
        }else if(indexPath.section == 3){
            
            NSDictionary * dic =  _dataArr[indexPath.section][indexPath.row];
            [cell1.imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"cover"]]];
            cell1.title.text = dic[@"title"];
            return cell1;
            
        }
        
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SW_VideoViewController * vc = [[SW_VideoViewController alloc]init];
    [self.navCtrl pushViewController:vc animated:YES];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    if (section == 0) {
        return 1;
    }
    
    return [_dataArr[section] count];

}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return [_dataArr count];
    
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/3);
    }else if(indexPath.section == 1 || indexPath.section == 2){
        return CGSizeMake((SCREEN_WIDTH-40)/3, (SCREEN_WIDTH-40)/3*5/3 + 75);
    }
    
    return CGSizeMake(SCREEN_WIDTH-20, (SCREEN_WIDTH-20)/3 + 75);
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    ItemHeaderView * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ItemHeaderView" forIndexPath:indexPath];
    
    
    if (_dataArr.count) {
        switch (indexPath.section) {
            case 1:
                header.title.text = @"新番连载";
                break;
            case 2:
                header.title.text = @"4月新番";
                break;
            case 3:
                header.title.text = @"详情";
                break;
                
            default:
                break;
        }
    }
    
    return header;
}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={SCREEN_WIDTH ,35};
    
    if (section == 0) {
        return CGSizeZero;
    }else if(section == 1 || section == 2){
        
        return size;
    }
    return CGSizeZero;
}



#pragma mark - requestData


-(void)requestData{
    
  
    
//    [NetClient GET:fanju_URL parameter:nil startRequest:nil success:^(MainModel *MainModel) {
//        if (_collectionView.mj_header) {
//            [_collectionView.mj_header endRefreshing];
//        }
//        
//        
//        
//        NSArray * image = MainModel.result[@"ad"][@"head"];
//        
//        DLOG(@"%@",image);
//        for (NSDictionary * dic in image) {
//            [_imageArray addObject:dic[@"img"]];
//            [_urlArray addObject:dic[@"link"]];
//        }
//        
//        
//        [_dataArr addObjectsFromArray:MainModel.result[@"serializing"]];
//        [_dataArr addObjectsFromArray:MainModel.result[@"serializing"]];
//        [_dataArr addObjectsFromArray:MainModel.result[@"previous"][@"list"]];
////        [_dataArr addObject:(NSArray *)MainModel.result[@"serializing"]];
////        [_dataArr addObject:(NSArray *)MainModel.result[@"serializing"]];
////        [_dataArr addObject:(NSArray *)MainModel.result[@"previous"][@"list"]];
//        
//        
//        _cycleScrollView.imageURLStringsGroup = _imageArray;
//    } failure:^(NSError *error) {
//        
//    }];
    
    
}

-(void)requestData2{
//    [NetClient GET:fanju2_URL parameter:nil startRequest:nil success:^(MainModel *MainModel) {
//        if (_collectionView.mj_header) {
//            [_collectionView.mj_header endRefreshing];
//        }
//        
//        
//        NSArray * image = MainModel.infoDic[@"ad"][@"head"];
//        for (NSDictionary * dic in image) {
//            [_imageArray addObject:dic[@"img"]];
//            [_urlArray addObject:dic[@"link"]];
//        }
//        
//        
//        [_dataArr addObject:MainModel.infoDic[@"serializing"]];
//        [_dataArr addObject:MainModel.infoDic[@"serializing"]];
//        
//        [_dataArr addObject:MainModel.infoDic[@"previous"][@"list"]];
//        
//        _cycleScrollView.imageURLStringsGroup = _imageArray;
//    } failure:^(NSError *error) {
//        
//    }];
    
    
//    [NetClient GET:fanju2_URL parameter:nil networkError:nil startRequest:nil success:^(id responseObject, NSURLSessionDataTask *dataTask, NetWorkClient *client) {
//        
//
//
//        
//        [_dataArr addObject:responseObject[@"result"]];
//        
//        
//        
//        [_collectionView reloadData];
//        
//        
//        
//    } failure:^(NSError *error, NSURLSessionDataTask *dataTask, NetWorkClient *client) {
//        
//    }];
    
    
    
}

#pragma mark - sd


/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    SW_H5ViewController  * vc = [[SW_H5ViewController alloc]init];
    vc.url = _urlArray[index];
    [self.navCtrl pushViewController:vc animated:YES];
    
}









@end
