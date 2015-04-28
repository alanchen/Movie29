//
//  MainMovieCell.m
//  Movie29
//
//  Created by alan on 2015/4/28.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "MainMovieCell.h"
#import "ACConstraintHelper.h"

@implementation MainMovieCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self)
    {
        self.posterImageView = [[UIImageView alloc] init];
        self.posterImageView.backgroundColor = [UIColor clearColor];
        [self.posterImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.posterImageView setClipsToBounds:YES];
        [self.contentView addSubview:self.posterImageView];
        
        self.titleLabel = [self addLabel];
        self.titleLabel.font = [UIFont systemFontOfSize:22];
        
        self.timeLabel = [self addLabel];
        self.timeLabel.font = [UIFont systemFontOfSize:18];
        
        self.durationLabel = [self addLabel];
        self.imdbLabel = [self addLabel];
        
        [self addConstraint];
    }
    
    return self;
}

-(UILabel *)addLabel
{
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectZero];
    l.font = [UIFont  systemFontOfSize:14];
    l.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:l];
    
    return l ;
}

-(void)addConstraint
{
    [self.posterImageView   setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.titleLabel        setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.timeLabel         setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.durationLabel     setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.imdbLabel         setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *metrics = @{@"space": @10,
                              @"space2x": @20,
                              @"imgW": @(60),
                              @"imgH": @(90)};
    
    NSDictionary *views = @{@"imgView": self.posterImageView,
                            @"title": self.titleLabel,
                            @"time": self.timeLabel,
                            @"imdb": self.imdbLabel,
                            @"duration": self.durationLabel};
    
    NSMutableArray *myConstraints = [NSMutableArray array];
    
    NSString *fh = @"H:|-(space)-[time(>=20)]-(space)-[imgView(imgW)]-(space)-[title(>=10)]-(space)-|";

    [myConstraints addObjectsFromArray: [ACConstraintHelper constraintWidthFormat:fh
                                                                          metrics:metrics
                                                                            views:views]];
    
//    //////////////////////////////////////////////////

    NSString *fv = @"V:|-(space)-[imgView(>=imgH)]-(space)-|";
    [myConstraints addObjectsFromArray: [ACConstraintHelper constraintWidthFormat:fv
                                                                          metrics:metrics
                                                                            views:views]];
    
    NSString *fv1 = @"V:|-(>=space)-[title(>=10)]-[duration(>=10)]-[imdb(>=10)]-(>=space)-|";
    [myConstraints addObjectsFromArray: [ACConstraintHelper constraintWidthFormat:fv1
                                                                          metrics:metrics
                                                                            views:views]];

    [myConstraints addObject: [ACConstraintHelper constraintCenterY:self.timeLabel with:self.contentView]];
    [myConstraints addObject: [ACConstraintHelper constraintCenterY:self.durationLabel with:self.timeLabel]];
    [myConstraints addObject: [ACConstraintHelper  alignLeft:self.durationLabel with:self.titleLabel]];
    [myConstraints addObject: [ACConstraintHelper  alignLeft:self.imdbLabel with:self.titleLabel]];
    
    [self.contentView addConstraints:myConstraints];
}


@end
