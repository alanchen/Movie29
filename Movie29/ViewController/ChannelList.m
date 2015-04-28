//
//  ChannelList.m
//  Movie29
//
//  Created by alan on 2015/4/27.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "ChannelList.h"
#import "APIHelper.h"
#import "MainMovieCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "ChannelHeader.h"
#import "ACConstraintHelper.h"

#import "GlobalVar.h"

#import "DetailVC.h"

@interface ChannelList ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UISegmentedControl *segControl;

@property (nonatomic,strong) NSMutableArray *channelList;
@property (nonatomic,strong) NSMutableArray *localList;
@property (nonatomic,strong) NSMutableArray *westList;

@end

@implementation ChannelList

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setFrame:self.view.frame];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerClass:[MainMovieCell class] forCellReuseIdentifier:@"MainMovieCell"];
    [self.view addSubview:self.tableView];
    
    NSMutableArray *itmes = [NSMutableArray arrayWithObjects:@"西片", @"國片", nil];
    self.segControl =[[UISegmentedControl alloc] initWithItems:itmes];
    self.segControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.segControl.tintColor = ColorRed;
    self.segControl.selectedSegmentIndex = 0;
    [self.segControl addTarget:self action:@selector(segControlChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segControl];
    
    [self getChannelList];
    
    [self addConstraint];
}

#pragma mark -  Private

-(void)addConstraint
{
    [self.tableView   setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.segControl  setTranslatesAutoresizingMaskIntoConstraints:NO];
  
    NSDictionary *metrics = @{@"space": @10,
                              @"space2x": @20};
    
    NSDictionary *views = @{@"tableView": self.tableView,
                            @"segControl": self.segControl};
    
    NSMutableArray *myConstraints = [NSMutableArray array];
    
    NSString *fv = @"V:|-space-[segControl(40)]-space-[tableView(>=space)]-0-|";
    [myConstraints addObjectsFromArray: [ACConstraintHelper constraintWidthFormat:fv
                                                                          metrics:metrics
                                                                            views:views]];
    
    NSString *fh1 = @"H:|-0-[tableView(>=10)]-0-|";
    [myConstraints addObjectsFromArray: [ACConstraintHelper constraintWidthFormat:fh1
                                                                          metrics:metrics
                                                                            views:views]];
    
    NSString *fh2 = @"H:|-[segControl(>=space)]-|";
    [myConstraints addObjectsFromArray: [ACConstraintHelper constraintWidthFormat:fh2
                                                                          metrics:metrics
                                                                            views:views]];
    
    [self.view addConstraints:myConstraints];

}

-(void)getChannelList
{
    [APIHelper apiGetMovieListWithSuccess:^(NSMutableArray *list, id responseObject) {
        
        self.localList = [NSMutableArray array];
        self.westList = [NSMutableArray array];
        
        for(ChannelModel *c in list)
        {
            if([c.type isEqualToString:@"local"])
                [self.localList addObject:c];
            else
                [self.westList addObject:c];
        }
        
        [self reloadTable];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)segControlChanged
{
    [self reloadTable];
}

-(void)reloadTable
{
    if(self.segControl.selectedSegmentIndex == 0)
        self.channelList = self.westList;
    else
        self.channelList = self.localList;
    
    [self.tableView reloadData];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ChannelModel *c = [self.channelList objectAtIndex:indexPath.section];
    MovieModel *m = [c.list objectAtIndex:indexPath.row];
    
    DetailVC *vc= [[DetailVC alloc] init];
    vc.movieModel = m;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.channelList count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ChannelModel *c = [self.channelList objectAtIndex:section];
    ChannelHeader *header = [ChannelHeader view];
    header.label.text =c.name;
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [self.channelList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChannelModel *c = [self.channelList objectAtIndex:indexPath.section];
    MovieModel *m = [c.list objectAtIndex:indexPath.row];
    
    MainMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainMovieCell"];
    
    cell.titleLabel.text = m.title_cn;
    cell.timeLabel.text = m.time;
    cell.imdbLabel.text = [m imdbString];
    cell.durationLabel.text = [m duratioinString];
    [cell.posterImageView setImageWithURL:[NSURL URLWithString:m.poster] placeholderImage:[UIImage imageNamed:@"placeholder_1"]];
    
    if([m.imdb intValue]!=0)
        cell.imdbLabel.textColor = ColorRed;
    else
        cell.imdbLabel.textColor = [UIColor blackColor];
    
    return cell;
}


@end
