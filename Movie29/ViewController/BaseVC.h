//
//  BaseVC.h
//  Movie29
//
//  Created by alan on 2015/4/28.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GlobalVar.h"

#import "MovieModel.h"

@interface BaseVC : UIViewController

@property (nonatomic,strong)UILabel *msgLabel;

-(void)addTopRightButton:(UIButton *) btn target:(id)t action:(SEL)a;
-(void)addTopLeftButton:(UIButton *) btn target:(id)t action:(SEL)a;

-(void)showMsgLabel:(NSString *)text show:(BOOL)show;


@end
