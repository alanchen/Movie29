//
//  WebVC.h
//  Movie29
//
//  Created by alan on 2015/5/6.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseVC.h"

@interface WebVC : BaseVC

@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)NSString *url;

@end
