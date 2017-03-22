
//
//  SW_H5ViewController.m
//  mybilibili
//
//  Created by 张松伟 on 2016/9/27.
//  Copyright © 2016年 张松伟. All rights reserved.
//

#import "SW_H5ViewController.h"

@interface SW_H5ViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation SW_H5ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:Timeout];
    [_webView loadRequest:request];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark - UIWebViewDelegate


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
    // 网络指示器结束显示
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    self.title = @"加载中...";
}


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    
    // 网络指示器结束显示
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:( NSError *)error{

    // 网络指示器结束显示
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

}


@end
