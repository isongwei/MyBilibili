//
//  ZhiboViewController.m
//  mybilibili
//
//  Created by 张松伟 on 16/9/11.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "ZhiboViewController.h"

#import "SW_AllLiveViewController.h"//所有直播

#import "ItemHeaderView.h"
#import "SW_TuijianCollectionViewCell.h"





@interface ZhiboViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,SDCycleScrollViewDelegate>


@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) SDCycleScrollView *cycleScrollView;

@property (nonatomic,strong) NSMutableArray * dataArr;
@property (nonatomic,strong) NSMutableArray * imageArray;
@property (nonatomic,strong) NSMutableArray * urlArray;

@end

@implementation ZhiboViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    [self initData];
    
    [self createUI];
    
    [self requestData];
    
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)initData{
    
    _dataArr = [NSMutableArray array];
    _imageArray = [NSMutableArray array];
    _urlArray = [NSMutableArray array];
}

-(void)createUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    
    
    

    
    [_collectionView registerNib:[UINib nibWithNibName:@"SW_TuijianCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SW_TuijianCollectionViewCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"ItemHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ItemHeaderView"];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    

    
    [self.view addSubview:_collectionView];
    [_collectionView addSubview:_cycleScrollView];
    
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [_imageArray removeAllObjects];
        [_dataArr removeAllObjects];
        [self requestData];
        
    }];
    
    

    
}
#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{

    
    SW_TuijianCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SW_TuijianCollectionViewCell" forIndexPath:indexPath];
    if (_dataArr.count) {
        
        NSDictionary * dic =  _dataArr[indexPath.section];
        NSArray * array = dic[@"lives"];
        NSString * imageName = array[indexPath.row][@"cover"][@"src"];
//        cell.infoDic = 
//        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imageName]];
//        cell.title.text = array[indexPath.row][@"title"];
    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    
    NSDictionary * dic = _dataArr[section];
    
    if (section == 0) {
        return 1;
    }
    
    return [dic[@"lives"] count];
    
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return [_dataArr count];

}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH/3);
    }
    
    return CGSizeMake((SCREEN_WIDTH-30)/2, (SCREEN_WIDTH-30)/2*0.6 + 45);
    
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        ItemHeaderView * header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ItemHeaderView" forIndexPath:indexPath];
        if (_dataArr.count) {
            
            NSDictionary * dic =  _dataArr[indexPath.section];
            
            NSString * title = dic[@"partition"][@"name"];
            
            NSString * imageName = dic[@"partition"][@"sub_icon"][@"src"];
            
            header.title.text = title;
            [header.iconImage sd_setImageWithURL:[NSURL URLWithString:imageName]];
        }
        
        
        return header;
    }else{
        
        if (indexPath.section == _dataArr.count-1) {
            UICollectionReusableView * footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
            footerView.userInteractionEnabled = YES;
            UIButton * btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            btn.frame = CGRectMake(20, 5, SCREEN_WIDTH-40, 35-10);
            btn.backgroundColor = [UIColor lightGrayColor];
            btn.layer.cornerRadius = 3;
            btn.layer.borderWidth = 1;
            btn.layer.borderColor = [UIColor darkGrayColor].CGColor;
            [btn setTitle:@"全部直播" forState:(UIControlStateNormal)];
            [btn setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
            [btn addTarget:self action:@selector(toAllLive) forControlEvents:(UIControlEventTouchUpInside)];
            [footerView addSubview:btn];
            
            
             return footerView;
        }
        
        
        return nil;
        
        
        
       
    }
    

}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={SCREEN_WIDTH ,35};
    
    if (section == 0) {
        return CGSizeZero;
    }
    return size;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    
    if (section == _dataArr.count-1) {
        CGSize size={SCREEN_WIDTH ,55};
        
        return size;
        
    }else{
        
        return CGSizeZero;
    }
    
}

#pragma mark - btn

-(void)toAllLive{
    
    
    SW_AllLiveViewController * vc = [[SW_AllLiveViewController alloc]init];
    [self.navCtrl pushViewController:vc animated:YES];
}


#pragma mark - requestData


-(void)requestData{
    
    
//    [NetClient GET:zhibo_URL parameter:nil networkError:nil startRequest:nil success:^(id responseObject, NSURLSessionDataTask *dataTask, NetWorkClient *client) {
//        
//        
//        if (_collectionView.mj_header) {
//            [_collectionView.mj_header endRefreshing];
//        }
//        NSArray * array = responseObject[@"data"][@"partitions"];
//       
//        NSArray * image = responseObject[@"data"][@"bannerLives"];
//        for (NSDictionary * dic in image) {
//            [_imageArray addObject:dic[@"img"]];
//            [_urlArray addObject:dic[@"link"]];
//        }
//        
//    
//        if (array.count) {
//            [_dataArr addObject:array[0]];
//        }
//        
//        for (NSDictionary  *dic in array) {
//            [_dataArr addObject:dic];
//        }
//        
//        
//        
//        [_collectionView reloadData];
//        _cycleScrollView.imageURLStringsGroup = _imageArray;
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
