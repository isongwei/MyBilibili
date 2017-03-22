//
//  SW_videoCell.m
//  mybilibili
//
//  Created by iSongWei on 2017/1/13.
//  Copyright © 2017年 张松伟. All rights reserved.
//

#import "SW_videoCell.h"

@interface SW_videoCell ( )

@property (nonatomic,weak) IBOutlet UIImageView * image_View;
@property (nonatomic,weak) IBOutlet UILabel * titleName;//标题
@property (nonatomic,weak) IBOutlet UILabel * upName;//up主
@property (nonatomic,weak) IBOutlet UILabel * playCount;//播放
@property (nonatomic,weak) IBOutlet UILabel *  barrageCount;//弹幕

@end

@implementation SW_videoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(void)setInfoDic:(NSDictionary *)infoDic{
    
    _infoDic = infoDic;
    [_image_View sd_setImageWithURL:[NSURL URLWithString:(NSString *)infoDic[@"pic"] ]];
    _titleName.text = infoDic[@"title"];
    
    
    _upName.text = [@"UP主:" stringByAppendingString:infoDic[@"owner"][@"name"]];
    _playCount.text = [@"播放:" stringByAppendingString: [infoDic[@"stat"][@"view"]stringValue]];
    _barrageCount.text = [@"弹幕:" stringByAppendingString:[infoDic[@"stat"][@"danmaku"] stringValue]];
    

}

@end
