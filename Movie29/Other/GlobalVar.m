//
//  GlobalVar.m
//  Movie29
//
//  Created by alan on 2015/4/28.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "GlobalVar.h"


@implementation GlobalVar

+(GlobalVar *)sharedInstance
{
    static GlobalVar *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[GlobalVar alloc] init];
    });
    
    
    
    return sharedInstance;
}

@end
