//
//  GlobalVar.h
//  Movie29
//
//  Created by alan on 2015/4/28.
//  Copyright (c) 2015年 alan. All rights reserved.
//


#define ColorXRGB(r,g,b,a) [UIColor colorWithRed:((float) r/255.0)  green: ((float) g/255.0)  blue:((float) b/255.0)  alpha:a]

#define ColorRed ColorXRGB(216,60,22,1.0)
#define ColorRed_alpha(a) ColorXRGB(216,60,22,a)

#define ColorSettingBg ColorXRGB(239,239,244,1.0)



#import <Foundation/Foundation.h>

@interface GlobalVar : NSObject

+(GlobalVar *)sharedInstance;

@end
