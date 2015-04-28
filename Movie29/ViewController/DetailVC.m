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
#import "GlobalVar.h"

#import "ACConstraintHelper.h"

@interface DetailVC () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UISegmentedControl *segControl;

@property (nonatomic,strong) NSMutableArray *ytList;

@end


@implementation DetailVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor= [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    
    [self setBackButton];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.tableView setFrame:self.view.frame];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerClass:[YouTubeListTableCell class] forCellReuseIdentifier:@"YouTubeListTableCell"];
    [self.view addSubview:self.tableView];
    
    NSMutableArray *itmes = [NSMutableArray arrayWithObjects:@"介紹", @"影片", nil];
    self.segControl =[[UISegmentedControl alloc] initWithItems:itmes];
    self.segControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.segControl.tintColor = ColorRed;
    self.segControl.selectedSegmentIndex = 0;
    [self.segControl addTarget:self action:@selector(segControlChanged) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segControl];
    
    [self getYoutubeVideos];
    
    [self addConstraint];
}

#pragma mark -  Back 

-(void)setBackButton
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backBtnImage = [UIImage imageNamed:@"back_icon"]  ;
    [backBtn setBackgroundImage:backBtnImage forState:UIControlStateNormal];
//    [backBtn.imageView]
    [backBtn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchUpInside];
//    backBtn.frame = CGRectMake(0, 0, 54, 30);
    [backBtn sizeToFit];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backBtn] ;
    self.navigationItem.leftBarButtonItem = backButton;

}
-(void)goback
{
    [self.navigationController popViewControllerAnimated:YES];
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

-(void)getYoutubeVideos
{
    [[YouTubeAPIService sharedInstance] apiSearchVideoDetaiilWithQuery:self.movieModel.title_cn
                                                            maxResults:10
                                                                 order:nil
                                                                params:nil
                                                               success:^(NSMutableArray *results, id responseObject, id info) {
                                                                   
                                                                   self.ytList = results;
                                                                   [self reloadTable];
                                                                   
                                                               } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                                   
                                                               }];
    
}

-(void)segControlChanged
{
    [self reloadTable];
}

-(void)reloadTable
{
    [self.tableView reloadData];
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
