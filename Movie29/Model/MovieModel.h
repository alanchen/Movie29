//
//  MovieModel.h
//  Movie29
//
//  Created by alan on 2015/4/27.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieModel : NSObject

@property (nonatomic,strong) NSString *poster;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *title_cn;
@property (nonatomic,strong) NSString *title_en;
@property (nonatomic,strong) NSString *year;
@property (nonatomic,strong) NSNumber *imdb;
@property (nonatomic,strong) NSString *duration;
@property (nonatomic,strong) NSString *intro;

-(NSString *)imdbString;
-(NSString *)duratioinString;


@end
