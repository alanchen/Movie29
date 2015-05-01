//
//  DetailVC.m
//  Movie29
//
//  Created by alan on 2015/4/28.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "DetailVC.h"
#import "YouTubeAPIService.h"
#import "YouTubeListTableCell.h"
#import "SVPullToRefresh.h"

#import "ACConstraintHelper.h"

#import "MovieDetailTable.h"

@interface DetailVC () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) MovieDetailTable *detailView;

@property (nonatomic,strong) UISegmentedControl *segControl;

@property (nonatomic,strong) NSMutableArray *ytList;

@end

@implementation DetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.movieModel.title_cn;

    self.detailView = [[MovieDetailTable alloc] initWithMovie:self.movieModel];
    [self.view addSubview:self.detailView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setFrame:self.view.frame];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerClass:[YouTubeListTableCell class] forCellReuseIdentifier:@"YouTubeListTableCell"];
    [self.view addSubview:self.tableView];
    self.tableView.hidden = YES;
    
    NSMutableArray *itmes = [NSMutableArray arrayWithObjects:@"介紹", @"影片", nil];
    self.segControl =[[UISegmentedControl alloc] initWithItems:itmes];
    self.segControl.tintColor = ColorRed;
    self.segControl.selectedSegmentIndex = 0;
    [self.segControl addTarget:self action:@selector(segControlChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segControl];
    
    [self addConstraint];
    
    [self setupPullToRefresh];
    
    [self.tableView triggerPullToRefresh];

}

#pragma mark -  Private

-(void)addConstraint
{
    [self.tableView   setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.segControl  setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.detailView  setTranslatesAutoresizingMaskIntoConstraints:NO];

    
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
    
    [myConstraints addObjectsFromArray: [ACConstraintHelper constraintFrame:self.detailView with:self.tableView]];


    
    [self.view addConstraints:myConstraints];
    
}

-(void)getYoutubeVideos
{
    [[YouTubeAPIService sharedInstance] apiSearchVideoDetaiilWithQuery:self.movieModel.title_cn
                                                            maxResults:30
                                                                 order:nil
                                                                params:nil
                                                               success:^(NSMutableArray *results, id responseObject, id info) {
                                                                   [self.tableView.pullToRefreshView stopAnimating];

                                                                   self.ytList = results;
                                                                   [self.tableView reloadData];
                                                                   
                                                               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                   [self.tableView.pullToRefreshView stopAnimating];

                                                               }];
    
}

-(void)segControlChanged
{
    if(self.segControl.selectedSegmentIndex == 0)
    {
        self.detailView.hidden = NO;
        self.tableView.hidden = YES;
    }
    else
    {
        self.detailView.hidden = YES;
        self.tableView.hidden = NO;
    }
}

-(void)setupPullToRefresh
{
    __weak __typeof(self)weakSelf = self;
    
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf getYoutubeVideos];
    }];
    
    self.tableView.pullToRefreshView.arrowColor = ColorRed;
    self.tableView.pullToRefreshView.textColor = ColorRed;
    [self.tableView.pullToRefreshView setTitle:@"下拉更新影片" forState:SVPullToRefreshStateStopped];
    [self.tableView.pullToRefreshView setTitle:@"放開更新影片" forState:SVPullToRefreshStateTriggered];
    [self.tableView.pullToRefreshView setTitle:@"更新中 ..." forState:SVPullToRefreshStateLoading];
    self.tableView.pullToRefreshView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    return [self.ytList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YouTubeVideoModel *model = [self.ytList objectAtIndex:indexPath.row];
    
    YouTubeListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YouTubeListTableCell"];
    [cell showData:model];
    
    return cell;
}

@end
