//
//  SW_FenquHeaderView.m
//  mybilibili
//
//  Created by 张松伟 on 2017/4/4.
//  Copyright © 2017年 张松伟. All rights reserved.
//

#import "SW_FenquHeaderView.h"
#import "SW_FenquViewHeaderCell.h"
@interface SW_FenquHeaderView ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray * dataArray;//数据

@end

@implementation SW_FenquHeaderView


-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self initData];
    
    [self initView];
    
    [self requestData];
    
    
}


#pragma mark - ===============init===============
-(void)initView{
        [_collectionView registerNib:[UINib nibWithNibName:@"SW_FenquViewHeaderCell" bundle:nil] forCellWithReuseIdentifier:@"SW_FenquViewHeaderCell"];
}

-(void)initData{
    _dataArray = [NSMutableArray array];
    
    
    
    
}
#pragma mark - UICollectionViewDelegate





- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    SW_FenquViewHeaderCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SW_FenquViewHeaderCell" forIndexPath:indexPath];
    
    if (_dataArray.count) {
        cell.infoDic = _dataArray[indexPath.row];
    }
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
   
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArray.count;
    
}


#pragma mark - ===============requestData===============
-(void)requestData{
    
    [NetClient GET:fenquHeader_URL parameter:nil startRequest:nil success:^(MainModel *MainModel) {

        
        NSArray * dataArr = MainModel.data;
        for (NSDictionary * dic in dataArr) {
            [_dataArray addObject:dic];
       
        }
    
        
        
        [_collectionView reloadData];
    }failure:^(NSError *error) {
            
        }];
    
    
}
@end
