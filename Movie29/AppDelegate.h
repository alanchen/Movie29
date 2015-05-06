//
//  AppDelegate.h
//  Movie29
//
//  Created by alan on 2015/4/27.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YouTubeVideoModel.h"
#import "UIView+Position.h"
#import "VideoPlayerView.h"

#import "Constants.h"

@import GoogleMobileAds;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) VideoPlayerView *playerView;
@property (strong, nonatomic) GADBannerView  *bannerView;


-(void)showPlayVideoLayoutDefault;
-(void)showPlayVideoLayoutExtend;
-(void)hidePlayVideoLayout;

-(void)loadAdIfNeed;


@end

