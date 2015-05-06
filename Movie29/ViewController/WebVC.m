//
//  WebVC.m
//  Movie29
//
//  Created by alan on 2015/5/6.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "WebVC.h"
#import "SVProgressHUD.h"
#import "UIView+Position.h"

@interface WebVC () <UIWebViewDelegate>

@end

@implementation WebVC

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.webView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [SVProgressHUD dismiss];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.webView.backgroundColor = [UIColor clearColor];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;

    [self.view addSubview: self.webView];
    
    NSMutableURLRequest *r = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:r];
    
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeNone];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [SVProgressHUD dismiss];
}

@end
