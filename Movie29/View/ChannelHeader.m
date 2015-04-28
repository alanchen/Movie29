//
//  ChannelHeader.m
//  Movie29
//
//  Created by alan on 2015/4/28.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "ChannelHeader.h"

@implementation ChannelHeader

+(ChannelHeader *)view
{
    ChannelHeader *v = [[ChannelHeader alloc] initWithFrame:CGRectZero];
    
    return v;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.label = [self addLabel];
    }
    
    return self;
}

-(UILabel *)addLabel
{
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectZero];
    l.font = [UIFont  systemFontOfSize:14];
    l.backgroundColor = [UIColor clearColor];
    [self addSubview:l];
    
    return l ;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.label.frame = CGRectMake(10, 10, self.frame.size.width - 20, self.frame.size.height - 20);
}


@end
