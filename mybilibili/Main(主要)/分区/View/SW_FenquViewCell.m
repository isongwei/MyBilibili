//
//  SW_FenquViewCell.m
//  mybilibili
//
//  Created by 张松伟 on 2017/3/28.
//  Copyright © 2017年 张松伟. All rights reserved.
//

#import "SW_FenquViewCell.h"

@interface SW_FenquViewCell ()

@property (nonatomic,weak) IBOutlet UIImageView * imageV;
@property (nonatomic,weak) IBOutlet UILabel * subtitle;

@property (nonatomic,weak) IBOutlet UILabel * live_count;
@property (nonatomic,weak) IBOutlet UILabel * danmu_count;

@end

@implementation SW_FenquViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    [_imageV sd_setImageWithURL:[NSURL URLWithString:infoDic[@"cover"]]];
    _subtitle.text = infoDic[@"title"];
    _live_count.text = [infoDic[@"play"] stringValue];
    _danmu_count.text = [infoDic[@"danmaku"] stringValue];

}

@end



@implementation SW_FenquViewFlowLayout
-(void)prepareLayout{

    self.itemSize = CGSizeMake((SCREEN_WIDTH-30)/2, (SCREEN_WIDTH-30)/2*0.9);
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
}
@end
