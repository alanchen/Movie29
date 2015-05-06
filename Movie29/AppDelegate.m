//
//  AppDelegate.m
//  Movie29
//
//  Created by alan on 2015/4/27.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "AppDelegate.h"

#import "ChannelList.h"

#import "GlobalVar.h"

#import <GoogleAnalytics-iOS-SDK/GAI.h>


#import <AdSupport/AdSupport.h>

@interface AppDelegate () <GADBannerViewDelegate>

@property (nonatomic)BOOL isAdLoaded;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self initWindow];
    [self initPlayer];
    [self initLayoutConfig];
    [self initAdMob];
    [self initGA];
    
    [self hidePlayVideoLayout];    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Getter

-(UINavigationController *)rootNavi
{
    return (UINavigationController *)self.window.rootViewController;
}


-(UIView *)rootView
{
    return self.rootNavi.view;
}

#pragma  mark - Init

-(void)initWindow
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    ChannelList *vc = [[ChannelList alloc] init];
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navi;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

-(void)initPlayer
{
    self.playerView = [[VideoPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.window.width, self.window.width*0.56)];
    [self.playerView.control.expandBtn addTarget:self action:@selector(expandPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.playerView.control.closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:self.playerView];
}

-(void)initAdMob
{
    self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
    self.bannerView.adUnitID = kAdMobUnitID;
    self.bannerView.rootViewController = [self rootNavi];
    self.bannerView.delegate = self;
    [self.window addSubview:self.bannerView];
}

-(void)initGA
{
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    // Initialize tracker. Replace with your tracking ID.
    [[GAI sharedInstance] trackerWithTrackingId:kGATrackingId];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];

    tracker.allowIDFACollection = YES;
}

-(void)initLayoutConfig
{
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                                                   forState:UIControlStateNormal];
    
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName : ColorRed }];
    
    [[UINavigationBar appearance] setTintColor:ColorRed];
    
}


#pragma  mark - Admob

-(void)loadAdIfNeed
{
    if(!self.isAdLoaded)
        [self.bannerView loadRequest:[GADRequest request]];
}

- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    self.isAdLoaded = YES;
}

#pragma mark - Video

-(void)showPlayVideoLayoutDefault
{
    [[self rootView] setHidden:NO];
    [self.playerView setHidden:NO];
    self.bannerView.hidden = NO;

    [UIView animateWithDuration:0.2 animations:^{
        
        float contentH = self.window.height - self.bannerView.height;

        self.playerView.top = 0;
        [self.playerView layoutToFitWidth:self.window.width];
        [self rootView].top = self.playerView.bottom;
        [self rootView].height = contentH - self.playerView.height;
        [self rootNavi].navigationBar.top = 0;
        self.bannerView.top = [self rootView].bottom;
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)showPlayVideoLayoutExtend
{
    [[self rootView] setHidden:YES];
    [self.playerView setHidden:NO];
    self.bannerView.hidden = YES;

    [UIView animateWithDuration:0.2 animations:^{
        [self.playerView layoutToFitFullScreenSize:self.window.size];
      } completion:^(BOOL finished) {
        
    }];
}

-(void)hidePlayVideoLayout
{
    [[self rootView] setHidden:NO];
    [self.playerView setHidden:YES];
    self.bannerView.hidden = NO;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        float contentH = self.window.height - self.bannerView.height;
        
        self.playerView.top = - self.playerView.height;
        [self rootView].top = IsGreaterThanIOS7?20:0;
        [self rootView].height  = IsGreaterThanIOS7?contentH -20:contentH ;
        self.bannerView.top = [self rootView].bottom;
        
    } completion:^(BOOL finished) {
        
    }];
}

-(void)expandPressed
{
    if(!self.playerView.control.expandBtn.isSelected)
    {
        [self.playerView showFullScreenControl:YES];
        [self showPlayVideoLayoutExtend];
    }
    else
    {
        [self.playerView showFullScreenControl:NO];
        [self showPlayVideoLayoutDefault];
    }
}

-(void)closeAction
{
    [self.playerView clean];
    [self hidePlayVideoLayout];
}


@end
