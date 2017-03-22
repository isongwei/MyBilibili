//
//  FenquViewController.m
//  mybilibili
//
//  Created by 张松伟 on 16/9/11.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "FenquViewController.h"
#import "SW_FenquCollectionViewCell.h"

@interface FenquViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic) UICollectionView *collectionView;

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
    

    
    //滑动图
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-80)/3, (SCREEN_WIDTH-80)/3);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 20, 0, 20);
    
    
    
    
    

    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49-64) collectionViewLayout:flowLayout];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;

    _collectionView.backgroundColor = [UIColor clearColor];


    
    [_collectionView registerNib:[UINib nibWithNibName:@"SW_FenquCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SW_FenquCollectionViewCell"];
    
    [self.view addSubview:_collectionView];
    
    
}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    SW_FenquCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SW_FenquCollectionViewCell" forIndexPath:indexPath];
    if (_dataArray.count) {
        
        NSDictionary * dic =  _dataArray[indexPath.row];
        
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:(NSString *)dic[@"logo"]]];
        cell.title.text = (NSString *)dic[@"name"];

    }
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  [_dataArray count];
    
    
}





@end
