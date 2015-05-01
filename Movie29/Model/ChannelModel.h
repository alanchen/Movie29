//
//  ChannelModel.h
//  Movie29
//
//  Created by alan on 2015/4/27.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieModel.h"

@interface ChannelModel : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *type; // local foreign
@property (nonatomic,strong) NSMutableArray *list;
@property (nonatomic,strong) NSArray *listAt9;


+(ChannelModel *)modelWithData:(id)data;



@end
