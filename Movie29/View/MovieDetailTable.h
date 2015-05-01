//
//  MovieDetailTable.h
//  Movie29
//
//  Created by alan on 2015/5/1.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieModel.h"

@interface MovieDetailTable : UIView

@property (nonatomic,strong) UITableView *tableView;

- (instancetype)initWithMovie:(MovieModel *)model;


@end
