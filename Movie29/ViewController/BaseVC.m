//
//  BaseVC.m
//  Movie29
//
//  Created by alan on 2015/4/28.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "BaseVC.h"
#import "ACConstraintHelper.h"
#import "AppDelegate.h"

@interface BaseVC() <UIGestureRecognizerDelegate >

@end

@implementation BaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor= [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    if([self isRoot] == NO)
    {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *backBtnImage = [UIImage imageNamed:@"back_icon"]  ;
        [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
        [backBtn sizeToFit];
        [self addTopLeftButton:backBtn target:self action:@selector(goback)];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if([self isRoot])
        [self disableBackGesture];
    else
        [self enableBackGesture];
    
    [((AppDelegate *)[UIApplication sharedApplication].delegate) loadAdIfNeed];
}

-(void)enableBackGesture
{
    // Enable iOS 7 back gesture
    // http://stackoverflow.com/questions/24710258/no-swipe-back-when-hiding-navigation-bar-in-uinavigationcontroller
    // https://bhaveshdhaduk.wordpress.com/2014/05/17/ios-7-enable-or-disable-back-swipe-gesture-in-uinavigationcontroller/
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

-(void)disableBackGesture
{
    // Disable iOS 7 back gesture
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

-(BOOL)isRoot
{
    id root = [self.navigationController.viewControllers objectAtIndex:0];
    
    if(self==root){
        return YES;
    }
    
    return NO;
}

#pragma mark - Public

-(void)addTopRightButton:(UIButton *) btn target:(id)t action:(SEL)a
{
    [btn addTarget:t action:a forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn] ;
    self.navigationItem.rightBarButtonItem = item;
}

-(void)addTopLeftButton:(UIButton *) btn target:(id)t action:(SEL)a
{
    [btn addTarget:t action:a forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn] ;
    self.navigationItem.leftBarButtonItem = item;
}

#pragma mark -

-(void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
