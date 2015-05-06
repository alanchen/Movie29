//
//  SearchResultCell.m
//  Movie29
//
//  Created by alan on 2015/5/6.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "SearchResultCell.h"
#import "ACConstraintHelper.h"


@implementation SearchResultCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        self.titleLabel = [self addLabel];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        
        self.subtitleLabel = [self addLabel];
        self.subtitleLabel.font = [UIFont systemFontOfSize:12];
        self.subtitleLabel.textColor = [UIColor lightGrayColor];
        
        [self addConstraint];
    }
    
    return self;
}

-(UILabel *)addLabel
{
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectZero];
    l.font = [UIFont  systemFontOfSize:12];
    l.backgroundColor = [UIColor clearColor];
    l.numberOfLines = 2;
    [self.contentView addSubview:l];
    
    return l ;
}

-(void)addConstraint
{
    [self.titleLabel        setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.subtitleLabel         setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *metrics = @{@"space": @10,
                              @"space2x": @20};
    
    NSDictionary *views = @{@"title": self.titleLabel,
                            @"subtitle": self.subtitleLabel};
    
    NSMutableArray *myConstraints = [NSMutableArray array];
    
    NSString *h1 = @"H:|-(space2x)-[title(>=10)]-(space2x)-|";
    NSString *h2 = @"H:|-(space2x)-[subtitle(>=10)]-(space2x)-|";
    
    [myConstraints addObjectsFromArray: [ACConstraintHelper constraintWidthFormat:h1
                                                                          metrics:metrics
                                                                            views:views]];
    
    [myConstraints addObjectsFromArray: [ACConstraintHelper constraintWidthFormat:h2
                                                                          metrics:metrics
                                                                            views:views]];
    
    NSString *v = @"V:|-(space)-[title(40)]-[subtitle(30)]-(>=space)-|";
    [myConstraints addObjectsFromArray: [ACConstraintHelper constraintWidthFormat:v
                                                                          metrics:metrics
                                                                            views:views]];

    [self.contentView addConstraints:myConstraints];
}

@end
