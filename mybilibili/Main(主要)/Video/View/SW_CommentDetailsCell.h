//
//  SW_CommentDetailsCell.h
//  mybilibili
//
//  Created by iSongWei on 2017/1/19.
//  Copyright © 2017年 张松伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SW_CommentDetailsCell : UITableViewCell
@property (nonatomic,strong) NSDictionary * infoDic;
@property (nonatomic,copy) void (^ replyToDetail)(void);
@end
