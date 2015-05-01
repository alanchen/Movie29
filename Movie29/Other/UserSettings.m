//
//  UserSettings.m
//  Movie29
//
//  Created by alan on 2015/4/29.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "UserSettings.h"

@implementation UserSettings

+(BOOL)isShowNineOnly
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"isShowNineOnly"];
}

+(void)setIsShowNineOnly:(BOOL)show
{
    [[NSUserDefaults standardUserDefaults] setBool:show forKey:@"isShowNineOnly"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
