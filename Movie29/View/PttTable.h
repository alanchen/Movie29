//
//  PttTable.h
//  Movie29
//
//  Created by alan on 2015/5/5.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GoogleSearchParser.h"


@protocol PttTableDelegate <NSObject>

@optional
-(void)pttTableDidSelect:(GModel *)model;

@end


@interface PttTable : UIView

@property (nonatomic,strong) UITableView *tableView;

- (instancetype)initWithTerm:(NSString *)term;

@property (nonatomic,weak)id<PttTableDelegate> delegate;

@end
