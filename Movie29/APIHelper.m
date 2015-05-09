//
//  APIHelper.m
//  Movie29
//
//  Created by alan on 2015/4/27.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "APIHelper.h"

@implementation APIHelper

+(AFHTTPRequestOperation *)apiGetMovieListWithSuccess:(void (^)(NSMutableArray *list, NSString *today ,id responseObject))success
                                              failure:(void (^)(NSError *error))failure

{
    NSString *url = @"http://movie29.azurewebsites.net/api/movies";
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    AFHTTPRequestOperation *op = [manager GET:url
                                   parameters:nil
                                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      
                                          NSMutableArray *list = [NSMutableArray array];
                                          
                                          for(id obj in [responseObject objectForKey:@"channels"])
                                          {
                                              ChannelModel *c = [ChannelModel modelWithData:obj];
                                              [list addObject:c];
                                          }
                                          
//                                          NSTimeInterval time = [[responseObject objectForKey:@"date"] doubleValue];
                                          
                                          if(success)
                                              success(list,[responseObject objectForKey:@"today"],responseObject);
                                      }
                                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                          if(failure)
                                              failure(error);
                                      }];
    
    return op;
}

@end
