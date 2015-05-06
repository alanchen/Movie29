//
//  VideoPlayerView.m
//  Movie29
//
//  Created by alan on 2015/5/3.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "VideoPlayerView.h"

@interface VideoPlayerView()<YTPlayerViewDelegate,ACYTPlayerViewDelegate>

@end

@implementation VideoPlayerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor blackColor];
        
        self.playerView = [[ACYTPlayerView alloc] initWithFrame:CGRectZero];
        self.playerView.playerViewDelegate = self;
        [self addSubview:self.playerView];
        [self.playerView setWidthAndKeepRatio:frame.size.width];
        
        self.control = [[ACYTControlView alloc] initWithFrame:self.playerView.frame];
        [self.control hideWithAnimation:NO];
        [self.control.nextBtn setHidden:YES];
        [self.control.preBtn setHidden:YES];
        [self addSubview:self.control];
        
        //////////////////////////////////////////////////////////////////////////////
        
        [self.control.playBtn addTarget:self action:@selector(playPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.control.hdBtn addTarget:self action:@selector(hdPressed) forControlEvents:UIControlEventTouchUpInside];
        [self.control.slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.control.slider addTarget:self action:@selector(sliderAction:) forControlEvents:UIControlEventTouchUpOutside];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.playerView.centerY = self.height/2;
    
    self.control.top = 0;
    self.control.left = 0;
    self.control.width = self.width;
    self.control.height = self.height;
}

-(void)clean
{
    [self.playerView stopVideo];
    [self.control.playBtn setSelected:NO];
    [self.control setSliedrValue:0];
}

-(void)showFullScreenControl:(BOOL)show
{
    if(show)
    {
        [self.control.expandBtn setSelected:YES];
        [self.playerView expand];
    }
    else{
        [self.control.expandBtn setSelected:NO];
        [self.playerView compress];
    }
}

-(void)playVideoWithVideoId:(NSString *)vid title:(NSString *)title
{
    [self.playerView playVideoWithVideoId:vid];
    [self.control.playBtn setSelected:YES];
    [self.control.expandBtn setSelected:NO];
     [self.control setSliedrValue:0];
    [self.control.titleLabel setText:title];
}

-(void)layoutToFitWidth:(float)width
{
    [self.playerView setWidthAndKeepRatio:width];
    self.size = self.playerView.size;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

-(void)layoutToFitFullScreenSize:(CGSize)size
{
    [self.playerView setWidthAndKeepRatio:size.width];
    self.size = size;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - Video Delegate

- (void)playerViewDidPlaying:(ACYTPlayerView *)playerView seekTime:(float)time
{
    [self.control setSliedrValue:time];
    
    if([self.playerView playerState] == kYTPlayerStateEnded)
    {
        
    }
}

- (void)playerViewDidEnd:(ACYTPlayerView *)playerView videoId:(NSString *)vid
{
    [self clean];
}

#pragma mark - Video Action

-(void)sliderAction:(UISlider *)s
{
    [self.playerView seekTo:self.control.slider.value];
}

-(void)hdPressed
{
    if(!self.control.hdBtn.isSelected)
    {
        [self.control.hdBtn setSelected:YES];
        [self.playerView changeToQualityMedium];
    }
    else
    {
        [self.control.hdBtn setSelected:NO];
        [self.playerView changeToQualityHD];
    }
}

-(void)playPressed
{
    if(!self.control.playBtn.isSelected)
    {
        [self.control.playBtn setSelected:YES];
        [self.playerView playVideo];
    }
    else
    {
        [self.control.playBtn setSelected:NO];
        [self.playerView pauseVideo];
    }
}

@end
