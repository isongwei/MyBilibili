//
//  SW_FenquViewHeaderCell.m
//  mybilibili
//
//  Created by 张松伟 on 2017/3/28.
//  Copyright © 2017年 张松伟. All rights reserved.
//

#import "SW_FenquViewHeaderCell.h"

@implementation SW_FenquViewHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

@end
@implementation SW_FenquViewHeaderFlowLayout
-(void)prepareLayout{
    
    self.itemSize = CGSizeMake((SCREEN_WIDTH)/4, (SCREEN_WIDTH)/4);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
}
@end
