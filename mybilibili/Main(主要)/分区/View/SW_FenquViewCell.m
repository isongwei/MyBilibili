//
//  SW_FenquViewCell.m
//  mybilibili
//
//  Created by 张松伟 on 2017/3/28.
//  Copyright © 2017年 张松伟. All rights reserved.
//

#import "SW_FenquViewCell.h"

@implementation SW_FenquViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

@end



@implementation SW_FenquViewFlowLayout
-(void)prepareLayout{

    self.itemSize = CGSizeMake((SCREEN_WIDTH-30)/2, (SCREEN_WIDTH-30)/2*0.75);
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
}
@end
