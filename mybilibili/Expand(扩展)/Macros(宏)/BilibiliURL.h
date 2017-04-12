//
//  BilibiliURL.h
//  mybilibili
//
//  Created by 张松伟 on 16/9/15.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#ifndef BilibiliURL_h
#define BilibiliURL_h


//分区上部

#define fenquHeader_URL @"https://app.bilibili.com/x/v2/region?access_key=37200d3f391844f1fed489c5c2747fa2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=4250&device=phone&mobi_app=iphone&platform=ios&sign=913fde4bc3d1fafcf6eb2b9341cb85ea&ts=1490713051"

//分区所有

#define fenquAll_URL @"https://app.bilibili.com/x/v2/show/region?access_key=37200d3f391844f1fed489c5c2747fa2&actionKey=appkey&appkey=27eb53fc9058f8c3&build=4250&channel=appstore&device=phone&mobi_app=iphone&platform=ios&sign=a3283bf1166d340ccc3f9fe4fe473f40&ts=1490429540&warm=0"





#pragma mark - ================================


//直播
#define zhibo_URL @"https://live.bilibili.com/mobile/home?actionKey=appkey&appkey=27eb53fc9058f8c3&build=2310&device=phone&platform=ios&scale=3&sign=ee8feee672ee037e2994adb9faa2f77e&ts=1466676873"

//分区
#define fenqu_URL @"https://app.bilibili.com/x/v2/region?access_key=a7fbf749c09fd896569e471df24e6da3&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3710&device=phone&mobi_app=iphone&platform=ios&sign=907b16949701790cd21839656428b0d5&ts=1473946384"
//推荐
#define tuijian_URL @"https://app.bilibili.com/x/v2/show?access_key=a7fbf749c09fd896569e471df24e6da3&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3710&channel=appstore&device=phone&mobi_app=iphone&plat=1&platform=ios&sign=ee7fe4c9af9e6a2e521d8c7b72c75d9f&ts=1473950924&warm=0"
//推荐评论
#define tuijian_comments_URL @"https://api.bilibili.com/x/v2/reply?_device=iphone&_hwid=9f89c84a559f5736&_ulv=10000&access_key=9d966b86c5703f21ea8bc458e06a1261&appkey=27eb53fc9058f8c3&appver=4140&build=4140&nohot=0&oid=%@&plat=3&platform=ios&pn=1&ps=20&sign=adf63252b6dce0266d1d30dba4cbcafa&sort=0&type=1"



//番剧
#define fanju_URL @"http://bangumi.bilibili.com/api/app_index_page_v4?build=3710&device=phone&mobi_app=iphone&platform=ios"


//番剧2
#define fanju2_URL @"https://bangumi.bilibili.com/api/bangumi_recommend?access_key=cc12a26e91bb11a19b5a52e3c3ac762c&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3710&cursor=0&device=phone&mobi_app=iphone&pagesize=10&platform=ios&sign=9a5ffe2ff7b0ad29ce9744b8609b222e&ts=1474764852"


//番剧2
#define fanju3_URL @"https://bangumi.bilibili.com/api/bangumi_recommend?access_key=cc12a26e91bb11a19b5a52e3c3ac762c&actionKey=appkey&appkey=27eb53fc9058f8c3&build=3710&cursor=1473933600240&device=phone&mobi_app=iphone&pagesize=10&platform=ios&sign=5da2c099ad45e7c122c6ab4c84d38e80&ts=1474764957"


//某个频道

#define video_URL @"http://app.bilibili.com/x/view?access_key=5b65015c833a54fcb6543f5ab579cff9&actionKey=appkey&aid=%@&appkey=27eb53fc9058f8c3&build=3060&device=phone&plat=0&platform=ios&sign=80950c02804851e278aa56e94d06dc01&ts=1458631180"

//#define video_URL @"https://app.bilibili.com/x/v2/view?access_key=9d966b86c5703f21ea8bc458e06a1261&actionKey=appkey&aid=%@&appkey=27eb53fc9058f8c3&build=4140&device=phone&from=1&mobi_app=iphone&platform=ios&sign=8c94e4d103561b20ee37e52c6821e1c6&ts=1484287933"


//#define video_URL @"https://app.bilibili.com/x/v2/view?access_key=9d966b86c5703f21ea8bc458e06a1261&actionKey=appkey&aid=7983108&appkey=27eb53fc9058f8c3&build=4140&device=phone&from=1&mobi_app=iphone&platform=ios&sign=8c94e4d103561b20ee37e52c6821e1c6&ts=1484644245"
#endif /* BilibiliURL_h */
