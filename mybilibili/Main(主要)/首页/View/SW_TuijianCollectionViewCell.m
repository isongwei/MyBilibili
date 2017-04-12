//
//  SW_TuijianCollectionViewCell.m
//  mybilibili
//
//  Created by 张松伟 on 16/9/15.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "SW_TuijianCollectionViewCell.h"

@interface SW_TuijianCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *title;
@end

@implementation SW_TuijianCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:infoDic[@"cover"]]];
    self.title.text = infoDic[@"title"];
}

@end
