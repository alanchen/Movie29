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
            [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
            [backBtn sizeToFit];
            UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
            self.navigationItem.leftBarButtonItem = backButton;

        }
    }
    
}

#pragma mark -

-(void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
