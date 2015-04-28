//
//  APIHelper.h
//  Movie29
//
//  Created by alan on 2015/4/27.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "ChannelModel.h"

@interface APIHelper : NSObject

+(AFHTTPRequestOperation *)apiGetMovieListWithSuccess:(void (^)(NSMutableArray *list, id responseObject))success
                                              failure:(void (^)(NSError *error))failure;

@end
