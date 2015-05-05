//
//  SearchResultCell.m
//  Movie29
//
//  Created by alan on 2015/5/6.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        self.textLabel.numberOfLines = 2;
        self.textLabel.font = [UIFont systemFontOfSize:14];
        
//        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
//        self.detailTextLabel.textColor  =[UIColor lightTextColor];
        
    }
    
    return self;
}

@end
