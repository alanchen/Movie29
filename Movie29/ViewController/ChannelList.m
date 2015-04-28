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

@interface ChannelList ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *channelList;

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
    
    [self getChannelList];
}

#pragma mark - 

-(void)getChannelList
{
    [APIHelper apiGetMovieListWithSuccess:^(NSMutableArray *list, id responseObject) {
        
        self.channelList = ((ChannelModel *)list[0]).list;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 111;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ChannelHeader *header = [ChannelHeader view];
    header.label.text = @"HBO";
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    return [self.channelList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ChannelModel *c = [self.channelList objectAtIndex:indexPath.row];
    
//    ChannelModel *c = [self.channelList objectAtIndex:indexPath.row];
    
   MovieModel *m = [self.channelList objectAtIndex:indexPath.row];
    
    MainMovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainMovieCell"];
    
    cell.titleLabel.text = m.title_cn; //c.name;
    cell.timeLabel.text = m.time; //c.name;
    cell.imdbLabel.text = [m imdbString]; //c.name;
    cell.durationLabel.text = [m duratioinString]; //c.name;
    [cell.posterImageView setImageWithURL:[NSURL URLWithString:m.poster] placeholderImage:[UIImage imageNamed:@"placeholder_1"]];
    
    return cell;
}


@end
