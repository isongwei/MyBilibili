//
//  SW_FenquViewHeaderCell.m
//  mybilibili
//
//  Created by 张松伟 on 2017/3/28.
//  Copyright © 2017年 张松伟. All rights reserved.
//

#import "SW_FenquViewHeaderCell.h"
@interface SW_FenquViewHeaderCell ()

@property (nonatomic,weak) IBOutlet UILabel * itemName;
@property (nonatomic,weak) IBOutlet UIImageView * imageV;

@end

@implementation SW_FenquViewHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    _itemName.text = infoDic[@"name"];
    [_imageV sd_setImageWithURL:[NSURL URLWithString:infoDic[@"logo"]]];
    
    
}
@end
@implementation SW_FenquViewHeaderFlowLayout
-(void)prepareLayout{
    
    self.itemSize = CGSizeMake((SCREEN_WIDTH)/4.0, (SCREEN_WIDTH)/16.0*3.0);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
}
@end
