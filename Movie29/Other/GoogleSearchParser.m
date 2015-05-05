//
//  GoogleSearchParser.m
//  Movie29
//
//  Created by alan on 2015/5/5.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "GoogleSearchParser.h"

@implementation GoogleSearchParser

+(void)searchPttMovieWithTerm:(NSString *)term
                         page:(NSInteger)page
            completionHandler:(void (^)(NSMutableArray *res)) handler //GModel array
{
    NSString *googleUrl = @"https://www.google.com.tw/search?oe=UTF-8&ie=UTF-8";
    googleUrl = [googleUrl stringByAppendingString:[NSString stringWithFormat:@"&start=%ld",(long)page]];
    NSString *googleUrlQ = [googleUrl stringByAppendingString:@"&q="];
    
    NSString *pttSite =@"https://www.ptt.cc/bbs/";
    NSString *pttBoard =@"movie/";
    NSString *pttSiteQ = [pttSite stringByAppendingString:pttBoard];
    
    NSString *q1 = term;
    NSString *q2 = [NSString stringWithFormat:@"+site:%@",pttSiteQ];

    NSString *urlStr = [[googleUrlQ stringByAppendingString:q1] stringByAppendingString:q2];
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSLog(@"urlStr = %@",urlStr);
    
    [self requestWithUrl:url completionHandler:^(NSString *res, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableArray * result = [self parseGoogleResultHTMLText:res];
            handler(result);
        });
    }];
}

#pragma  mark - Private

+(void)requestWithUrl:(NSURL *)url completionHandler:(void (^)(NSString *res, NSError* error)) handler
{
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url
                                                cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                            timeoutInterval:30];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSString *res = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if(handler)
            handler(res,error);
    }];
}

+(NSMutableArray *)parseGoogleResultHTMLText:(NSString *)html
{
    NSError *error = nil;
    HTMLParser *parser = [[HTMLParser alloc] initWithString:html error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error);
        return nil ;
    }
    
    NSMutableArray *arr = [NSMutableArray array];
    
    HTMLNode *bodyNode = [parser body];
    NSArray *resultNodes = [bodyNode findChildrenOfClass:@"g"];
    
    for (HTMLNode *itemNode in resultNodes) {

        HTMLNode *titleNode = [itemNode findChildTag:@"h3"];
        
        NSString *title = [titleNode allContents];
        NSString *link = [[titleNode findChildTag:@"a"] getAttributeNamed:@"href"];
        NSString *subtitle = [[itemNode findChildTag:@"cite"] allContents];
        NSString *desc = [[itemNode findChildOfClass:@"st"] allContents];

        GModel *model = [[GModel alloc] init];
        model.title = title;
        model.link = link;
        model.subtitle = subtitle;
        model.desc = desc;

        [arr addObject:model];
    }
    
    return arr;
}

@end

@implementation GModel


-(void)setLink:(NSString *)link
{
    if(link){
        _link= [link stringByReplacingOccurrencesOfString:@"/url?q=" withString:@""];
    }
}


@end