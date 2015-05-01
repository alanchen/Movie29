//
//  BaseVC.m
//  Movie29
//
//  Created by alan on 2015/4/28.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "BaseVC.h"
#import "ACConstraintHelper.h"

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

    self.msgLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.msgLabel.backgroundColor =[UIColor clearColor];
    self.msgLabel.font = [UIFont systemFontOfSize:14];
    self.msgLabel.textColor = ColorRed;
    self.msgLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.msgLabel];
    [self showMsgLabel:nil show:NO];
    
    [self addBaseVCConstraint];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if([self isRoot])
        [self disableBackGesture];
    else
        [self enableBackGesture];

}

#pragma mark - Private

-(void)addBaseVCConstraint
{
    [self.msgLabel   setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *metrics = @{@"space": @10,
                              @"space2x": @20};
    
    NSDictionary *views = @{@"label": self.msgLabel};
    
    NSMutableArray *myConstraints = [NSMutableArray array];
    
    
    NSString *fv = @"V:|-(>=space2x)-[label(80)]-(>=space2x)-|";
    [myConstraints addObjectsFromArray: [ACConstraintHelper constraintWidthFormat:fv
                                                                          metrics:metrics
                                                                            views:views]];
    
    NSString *fh1 = @"H:|-(space2x)-[label(>=10)]-(space2x)-|";
    [myConstraints addObjectsFromArray: [ACConstraintHelper constraintWidthFormat:fh1
                                                                          metrics:metrics
                                                                            views:views]];
    
    [self.view addConstraints:myConstraints];
    
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

-(void)showMsgLabel:(NSString *)text show:(BOOL)show
{
    self.msgLabel.hidden = !show;
    self.msgLabel.text = text?text:@"沒有內容";
}

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
