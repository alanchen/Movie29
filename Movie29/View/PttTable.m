//
//  PttTable.m
//  Movie29
//
//  Created by alan on 2015/5/5.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "PttTable.h"
#import "ACConstraintHelper.h"
#import "SearchResultCell.h"

@interface PttTable() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *objects;
@property (nonatomic,strong) NSString *term;


@end

@implementation PttTable

- (instancetype)initWithTerm:(NSString *)term;
{
    self = [super init];
    if (self) {
        
        self.term = term;
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self.tableView setFrame:self.frame];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor clearColor];
        [self.tableView registerClass:[SearchResultCell class] forCellReuseIdentifier:@"SearchResultCell"];
        [self addSubview:self.tableView];
        
        [self addConstraint];
        

        [GoogleSearchParser searchPttMovieWithTerm:term page:0 completionHandler:^(NSMutableArray *res) {
            self.objects = res;
            [self.tableView reloadData];
        }];
        
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

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [self.objects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell"];
    
    GModel *model = [self.objects objectAtIndex:indexPath.row];
    
    cell.textLabel.text = model.title;
    cell.detailTextLabel.text = model.desc;
    
    return cell;
}

@end
