//
//  WodeViewController.m
//  mybilibili
//
//  Created by 张松伟 on 16/9/11.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "WodeViewController.h"


#import "SW_WodeCollectionViewCell.h"

@interface WodeViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView * collectionView;
@property (nonatomic,strong) NSMutableArray * imageArray;
@property (nonatomic,strong) NSMutableArray * titleArray;



@property (nonatomic,assign) BOOL  open;

@end

@implementation WodeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = ItemColor;
    
    [self initData];
    
    [self createUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)initData{
    
    _open =  YES;
    
    _imageArray = [NSMutableArray array];
    _imageArray.array = @[
                          @[
                              @"mine_download",
                              @"mine_history",
                              @"mine_favourite",
                              @"mine_follow",
                              @"mine_pocketcenter",
                              @"mine_gamecenter",
                              @"mine_theme"

                              ],
                          @[
                              @"mine_answerMessage",
                              @"mine_shakeMe",
                              @"mine_gotPrise",
                              @"mine_privateMessage",
                              @"mine_systemNotification",                              ]
                          ];
    
    _titleArray = [NSMutableArray array];
    _titleArray.array = @[
                          @[
                              @"离线缓存",
                              @"历史记录",
                              @"我的收藏",
                              @"我的关注",
                              @"我的钱包",
                              @"游戏中心",
                              @"主题选择",
                              ],
                          @[
                              @"回复我的",
                              @"@我",
                              @"收到的赞",
                              @"私信",
                              @"系统通知",
                              
                              ]
                          ];
    
    
    
    
    

    
    
}

-(void)createUI{
    
    


    //滑动图
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH)/4, (SCREEN_WIDTH)/4*1.1);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    
    
    
    
    
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT-64-49-100) collectionViewLayout:flowLayout];
    _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor clearColor];
//    _collectionView.layer.cornerRadius = 5;
//    _collectionView.layer.masksToBounds = YES;
    
    
    
    
    [_collectionView registerNib:[UINib nibWithNibName:@"SW_WodeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SW_WodeCollectionViewCell"];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeader"];
    
    [self.view addSubview:_collectionView];
    
    
    
    UIView * view1 = [[UIView alloc]initWithFrame:(CGRectMake(0, 40+SCREEN_WIDTH/2*1.1, SCREEN_WIDTH, 10))];
    view1.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    [_collectionView addSubview:view1];
    
    UIView * view2 = [[UIView alloc]initWithFrame:(CGRectMake(0, 40*2+SCREEN_WIDTH*1.1+10, SCREEN_WIDTH, SCREEN_HEIGHT))];
    view2.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
    [_collectionView addSubview:view2];
    
    
    
    
    

}

#pragma mark - UICollectionViewDelegate

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    
    SW_WodeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SW_WodeCollectionViewCell" forIndexPath:indexPath];
    
    if (indexPath.row > [_imageArray[indexPath.section]count]-1) {
        
        cell.imageView.image = [[UIImage alloc]init];
        cell.title.text = @"";

    }else if (indexPath.row < 8){
        
        cell.imageView.image = [UIImage imageNamed:_imageArray[indexPath.section][indexPath.row]];
        cell.title.text = _titleArray[indexPath.section][indexPath.row];

    }else{
//        cell.contentView.backgroundColor = [UIColor lightGrayColor];
    }
  
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        _open = !_open;
        
        [collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        
        
    }
    
    
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    
    return  _imageArray.count;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    if (section == 0) {
        if (!_open) {
            return 0;
        }
    }
    
    
    
    return 8;
    return [_imageArray[section] count];
    
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if (indexPath.row < 8) {
//        return CGSizeMake((SCREEN_WIDTH)/4, (SCREEN_WIDTH)/4*1.1);
//    }else{
//        return CGSizeMake(SCREEN_WIDTH, 10);
//    }
//    
//}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    UICollectionReusableView * header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionElementKindSectionHeader" forIndexPath:indexPath];
    header.backgroundColor = [UIColor whiteColor];
    UILabel * label = [[UILabel alloc]initWithFrame:header.bounds];
    label.textColor  = [UIColor colorWithHexString:@"282828"];
    label.font = [UIFont systemFontOfSize:15];
    
    
    [header addSubview:label];
    
    if (indexPath.section == 0) {

        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:header.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = header.bounds;
        maskLayer.path = maskPath.CGPath;
        header.layer.mask = maskLayer;
        
        label.text = @"    个人中心";

    }else{
        label.text = @"    我的消息";
    }
    
    

    return header;
}

//返回头headerView的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={SCREEN_WIDTH ,40};

    return size;
}




@end
