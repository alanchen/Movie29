//
//  GoogleSearchParser.h
//  Movie29
//
//  Created by alan on 2015/5/5.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTMLParser.h"

@interface GoogleSearchParser : NSObject

+(void)searchPttMovieWithTerm:(NSString *)term
                         page:(NSInteger)page
            completionHandler:(void (^)(NSMutableArray *res)) handler; //GModel array

@end

@interface GModel : NSObject

@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *subtitle;
@property (nonatomic,strong)NSString *link;
@property (nonatomic,strong)NSString *desc;

@end

