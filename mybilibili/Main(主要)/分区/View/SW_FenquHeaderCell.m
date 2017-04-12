//
//  SW_FenquHeaderCell.m
//  mybilibili
//
//  Created by 张松伟 on 2017/4/10.
//  Copyright © 2017年 张松伟. All rights reserved.
//

#import "SW_FenquHeaderCell.h"

@interface SW_FenquHeaderCell ()
@property (nonatomic,weak) IBOutlet UIImageView * imageV;
@property (nonatomic,weak) IBOutlet UILabel * titleL;


@end

@implementation SW_FenquHeaderCell

-(void)awakeFromNib{
    [super awakeFromNib];
    

}

-(void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    _titleL.text = infoDic[@"title"];

}

@end
