//
//  SW_CommentDetailsCell.m
//  mybilibili
//
//  Created by iSongWei on 2017/1/19.
//  Copyright © 2017年 张松伟. All rights reserved.
//

#import "SW_CommentDetailsCell.h"

@interface SW_CommentDetailsCell ()

@property (nonatomic,weak) IBOutlet UIImageView * headerImage;
@property (nonatomic,weak) IBOutlet UIImageView * headerLv;

@property (nonatomic,weak) IBOutlet UILabel * UPzhu;
@property (nonatomic,weak) IBOutlet UILabel * publishedTime;
@property (nonatomic,weak) IBOutlet UILabel * content;
@property (nonatomic,weak) IBOutlet UIButton * publishedCount;

@end

@implementation SW_CommentDetailsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.content.sd_layout
    .leftEqualToView(self.publishedTime)
    .topSpaceToView(self.publishedTime, 5)
    .rightSpaceToView(self.contentView,10)
    .autoHeightRatio(0);
    
    self.publishedCount.sd_layout
    .leftEqualToView(self.publishedTime)
    .topSpaceToView(self.content, 8)
    .rightSpaceToView(self.contentView,10)
    .heightIs(25);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(void)setInfoDic:(NSDictionary *)infoDic{
    _infoDic = infoDic;
    [_headerImage sd_setImageWithURL:[NSURL URLWithString:infoDic[@"member"][@"avatar"]]];
//    _headerLv;

    _UPzhu.text = infoDic[@"member"][@"uname"];
    
    _publishedTime.text = [NSString stringWithFormat:@"#%@   %@",infoDic[@"floor"],[NSString getTimeIntervalWithconverDate:infoDic[@"ctime"]]];
    _content.text = infoDic[@"content"][@"message"];
    [_publishedCount  setTitle:[NSString stringWithFormat:@"共%d条回复 >",(int)[(NSArray*)infoDic[@"replies"] count]] forState:(UIControlStateNormal)];  ;
    [self setupAutoHeightWithBottomView:_publishedCount bottomMargin:8];
    
}

-(IBAction)toDetail:(UIButton *)sender{
    
    if (self.replyToDetail) {
        self.replyToDetail();
    }
}

@end
