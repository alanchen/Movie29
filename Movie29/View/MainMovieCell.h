//
//  MainMovieCell.h
//  Movie29
//
//  Created by alan on 2015/4/28.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMovieCell : UITableViewCell

@property (nonatomic,strong) UIImageView *posterImageView;

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *durationLabel;
@property (nonatomic,strong) UILabel *imdbLabel;

@end
