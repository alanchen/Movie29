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

@end
