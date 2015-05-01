//
//  TableModel.h
//  Movie29
//
//  Created by alan on 2015/4/30.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// this is for group table use
@interface TableModel : NSObject

+(TableModel *) tableModelWithGroup:(NSMutableArray *)array; // [TableModel tableModelWithGroup:[@[@"1",@(11),@"2",@(22)] mutableCopy]];
+(TableModel *) tableModelWithGroupTitles:(NSMutableArray *)titles
                                     rows:(NSMutableArray *)rows;

@property (nonatomic,strong) NSMutableArray *titles;
@property (nonatomic,strong) NSMutableArray *rows;

-(NSString *)titleAtSection:(NSInteger )section;
-(id)objectAtIndexPath:(NSIndexPath *)indexPath;
-(id)rowsAtSection:(NSInteger )section;



@end
