//
//  BaseVC.m
//  Movie29
//
//  Created by alan on 2015/4/28.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "BaseVC.h"

@implementation BaseVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor= [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    if([self.navigationController.viewControllers count]>1)
    {
        id root = [self.navigationController.viewControllers objectAtIndex:0];
        
        if(self!=root)
        {
            UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *backBtnImage = [UIImage imageNamed:@"back_icon"]  ;
            [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
            [backBtn sizeToFit];
            [self addTopLeftButton:backBtn target:self action:@selector(goback)];

        }
    }
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
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
