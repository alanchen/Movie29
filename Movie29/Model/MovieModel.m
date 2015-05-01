//
//  MovieModel.m
//  Movie29
//
//  Created by alan on 2015/4/27.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "MovieModel.h"

@implementation MovieModel

-(NSString *)imdbString
{
    if([self.imdb integerValue]==0)
        return [NSString stringWithFormat:@"IMDB : 無"];
    
    return [NSString stringWithFormat:@"IMDB : %.1f",[self.imdb floatValue]];
}

-(NSString *)duratioinString
{
    if([self.duration length]==0)
        return [NSString stringWithFormat:@"片長 : 無"];
    
    return [NSString stringWithFormat:@"片長 : %@",self.duration];
}

@end
