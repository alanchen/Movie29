//
//  UIView+Position.h
//  CocoaPodsSample
//
//  Created by alan on 12/10/5.
//  Copyright (c) 2012年 genie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView(Position)

@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat top;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;

@property (nonatomic) CGSize size;
@property (nonatomic) CGPoint point;


-(void)alignSuperViewCenterX;
-(void)alignSuperViewCenterY;


@end
