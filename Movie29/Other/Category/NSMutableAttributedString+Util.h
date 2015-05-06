//
//  NSMutableAttributedString+Util.h
//  FreePoint
//
//  Created by alan on 2015/3/13.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableAttributedString(Util)

-(void)setText:(NSString *)text font:(UIFont *)font;
-(void)setText:(NSString *)text color:(UIColor *)color;
-(void)setAllTextWithFont:(UIFont *)font;
-(void)setAllTextWithColor:(UIColor *)color;

@end
