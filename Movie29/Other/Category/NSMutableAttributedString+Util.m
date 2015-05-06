//
//  NSMutableAttributedString+Util.m
//  FreePoint
//
//  Created by alan on 2015/3/13.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "NSMutableAttributedString+Util.h"

@implementation NSMutableAttributedString(Util)

-(void)setText:(NSString *)text font:(UIFont *)font
{
    NSRange range = [self.string rangeOfString:text];

    [self addAttribute:(NSString *)NSFontAttributeName
                 value:font
                 range:range];
}

-(void)setText:(NSString *)text color:(UIColor *)color
{
    NSRange range = [self.string rangeOfString:text];
    
    [self addAttribute:(NSString *)NSForegroundColorAttributeName
                 value:(id)color
                 range:range];
}

-(void)setAllTextWithFont:(UIFont *)font
{
    NSRange range = [self.string rangeOfString:self.string];
    
    [self addAttribute:(NSString *)NSFontAttributeName
                 value:font
                 range:range];
}

-(void)setAllTextWithColor:(UIColor *)color
{
    NSRange range = [self.string rangeOfString:self.string];
    
    [self addAttribute:(NSString *)NSForegroundColorAttributeName
                 value:(id)color
                 range:range];
}


@end
