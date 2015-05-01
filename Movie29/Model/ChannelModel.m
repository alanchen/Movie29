//
//  ChannelModel.m
//  Movie29
//
//  Created by alan on 2015/4/27.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "ChannelModel.h"

@implementation ChannelModel

+(ChannelModel *)modelWithData:(id)data
{
    ChannelModel *model = [[ChannelModel alloc] initWithData:data];
    
    return model;
}

- (id)initWithData:(id)data
{
    self = [super init];
    if (self) {
        self.name = [data objectForKey:@"name"];
        self.type = [data objectForKey:@"type"];
        self.list = [NSMutableArray array];
        
        for(id mData in [data objectForKey:@"list"])
        {
            MovieModel *m = [[MovieModel alloc] init];
            m.duration = [mData objectForKey:@"duration"];
            m.imdb = [mData objectForKey:@"imdb"];
            m.intro = [mData objectForKey:@"intro"];
            m.poster = [mData objectForKey:@"poster"];
            m.time = [mData objectForKey:@"time"];
            m.title_cn = [mData objectForKey:@"title_cn"];
            m.title_en = [mData objectForKey:@"title_en"];
            m.year = [mData objectForKey:@"year"];

            [self.list addObject:m];
        }
        
    }
    return self;
}

-(NSArray *)listAt9
{
    if(_listAt9)
        return _listAt9;
    
    _listAt9 = [self nineOnlyList];

    return _listAt9;
}

-(NSArray *)filteredMoviesBy:(NSString *)clock // 00~23
{
    NSPredicate *nineOnly = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        MovieModel *movie = (MovieModel *)evaluatedObject;
        
        if([movie.time hasPrefix:clock])
            return YES;
        
        return NO;
    }];
    
    NSArray *filteredArray = [self.list filteredArrayUsingPredicate:nineOnly];
    
    return filteredArray;
}

-(NSArray *)nineOnlyList
{
    NSArray *filteredArray = [self filteredMoviesBy:@"21"];
    
    if([filteredArray count]>1){
        filteredArray = [NSArray arrayWithObject:[filteredArray lastObject]];
    }
    else if([filteredArray count]==0)
    {
        filteredArray = [self filteredMoviesBy:@"20"];
        
        if([filteredArray count]>1){
            filteredArray = [NSArray arrayWithObject:[filteredArray lastObject]];
        }
        else if([filteredArray count]==0)
        {
            filteredArray = [self filteredMoviesBy:@"19"];
            
            if([filteredArray count]>1){
                filteredArray = [NSArray arrayWithObject:[filteredArray lastObject]];
            }
            else if([filteredArray count]==0){
                filteredArray = [self filteredMoviesBy:@"22"];
            }
        }
    }

    return filteredArray;
    
}

@end
