//
//  MovieDetailTable.m
//  Movie29
//
//  Created by alan on 2015/5/1.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACConstraintHelper.h"

#import "MovieDetailTable.h"

@interface MovieDetailTable() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) MovieModel *model;

@end

@implementation MovieDetailTable

- (instancetype)initWithMovie:(MovieModel *)model
{
    self = [super init];
    if (self) {
        
        self.model = model;
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.tableView setFrame:self.frame];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor clearColor];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [self addSubview:self.tableView];

        [self addConstraint];

    }
    return self;
}

-(void)addConstraint
{
    [self.tableView   setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSDictionary *metrics = @{@"space": @10,
                              @"space2x": @20};
    
    NSDictionary *views = @{@"tableView": self.tableView};
    
    NSMutableArray *myConstraints = [NSMutableArray array];
    
    NSString *fv = @"V:|-0-[tableView(>=space)]-0-|";
    [myConstraints addObjectsFromArray: [ACConstraintHelper constraintWidthFormat:fv
                                                                          metrics:metrics
                                                                            views:views]];
    
    NSString *fh1 = @"H:|-0-[tableView(>=10)]-0-|";
    [myConstraints addObjectsFromArray: [ACConstraintHelper constraintWidthFormat:fh1
                                                                          metrics:metrics
                                                                            views:views]];
    
    [self addConstraints:myConstraints];

}

-(float)introHeight
{
    CGRect textRect = [[self introString] boundingRectWithSize:CGSizeMake(self.tableView.frame.size.width-40, 2000)
                                                       options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                    attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                                       context:nil];
    return textRect.size.height+10;
}

-(NSString *)introString
{
    NSString *title = @"簡介：\n   ";
    NSString *intro = [title stringByAppendingString:self.model.intro];
    return intro;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

#pragma mark - UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==3)
        return [self introHeight];
    
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    if(indexPath.row == 0)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"中文片名：%@",self.model.title_cn];
    }
    else  if(indexPath.row == 1)
    {
        if([self.model.title_en length]>0)
            cell.textLabel.text = [NSString stringWithFormat:@"英文片名：%@",self.model.title_en];
        else
            cell.textLabel.text = [NSString stringWithFormat:@"英文片名："];
    }
    else  if(indexPath.row == 2){
        cell.textLabel.text =self.model.imdbString;
    }
    else  if(indexPath.row == 3){
        cell.textLabel.text = [self introString];
    }
    
    return cell;
}



@end
