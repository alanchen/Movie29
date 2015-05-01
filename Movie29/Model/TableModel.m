//
//  TableModel.m
//  Movie29
//
//  Created by alan on 2015/4/30.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "TableModel.h"

@implementation TableModel

+(TableModel *) tableModelWithGroupTitles:(NSMutableArray *)titles rows:(NSMutableArray *)rows
{
    TableModel *model = [[TableModel alloc] init];
    model.titles = titles;
    model.rows = rows;
    
    return  model;
}

+(TableModel *) tableModelWithGroup:(NSMutableArray *)array
{
    TableModel *model = [[TableModel alloc] init];
    model.titles = [NSMutableArray array];
    model.rows = [NSMutableArray array];
    
    NSMutableArray *tempArr = [NSMutableArray array];
    
    for(id obj in array)
    {
        if([obj isKindOfClass:[NSString class]])
        {
            tempArr =[NSMutableArray array];
            [model.titles addObject:obj];
            [model.rows addObject:tempArr];
        }
        else
        {
            [tempArr addObject:obj];
        }
    }
    
    return  model;
}

+(TableModel *) tableModelWithRow:(NSMutableArray *)array
{
    TableModel *model = [[TableModel alloc] init];
    model.titles = nil;
    model.rows = [@[array] mutableCopy];
    
    return  model;
}

-(NSString *)titleAtSection:(NSInteger )section
{
    if([self.titles count] <= section)
        return nil;
    
    return [self.titles objectAtIndex:section];
}

-(id)objectAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *sectionObjs = [self rowsAtSection:indexPath.section];
    
    if([sectionObjs count] > indexPath.row){
        return [sectionObjs objectAtIndex:indexPath.row];
    }
    
    return nil;
}

-(id)rowsAtSection:(NSInteger )section
{
    if([self.rows count] > section)
    {
        NSArray *sectionObjs = [self.rows objectAtIndex:section];
        return sectionObjs;
    }
    
    return nil;

}

@end
