//
//  VideoPlayerView.h
//  Movie29
//
//  Created by alan on 2015/5/3.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ACYTPlayerView.h"
#import "ACYTControlView.h"
#import "UIView+Position.h"

@interface VideoPlayerView : UIView

@property (nonatomic,strong) ACYTPlayerView *playerView;
@property (nonatomic,strong) ACYTControlView *control;

-(void)clean;
-(void)showFullScreenControl:(BOOL)show;
-(void)playVideoWithVideoId:(NSString *)vid title:(NSString *)title;

-(void)layoutToFitWidth:(float)width;
-(void)layoutToFitFullScreenSize:(CGSize)size;

@end
