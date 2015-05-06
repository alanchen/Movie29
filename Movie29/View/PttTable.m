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
#import "NSMutableAttributedString+Util.h"
#import "GlobalVar.h"
#import "SVPullToRefresh.h"


@interface PttTable() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *objects;
@property (nonatomic,strong) NSString *term;

@property (nonatomic,weak) NSOperationQueue *op;
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic) BOOL canLoadMore;

@end

@implementation PttTable

-(void)dealloc
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
}

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
        
        [self setupPullToRefresh];
        
        [self addConstraint];
        
        [self.tableView triggerPullToRefresh];
        
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

-(void)setupPullToRefresh
{
    __weak __typeof(self)weakSelf = self;
    
    [self.tableView addPullToRefreshWithActionHandler:^{

        [weakSelf.objects removeAllObjects];
        weakSelf.objects = nil;
        weakSelf.currentIndex = 0;
        weakSelf.canLoadMore = YES;
        [weakSelf apiLoadPageAtIndex:0];
    }];
    
    self.tableView.pullToRefreshView.arrowColor = ColorRed;
    self.tableView.pullToRefreshView.textColor = ColorRed;
    [self.tableView.pullToRefreshView setTitle:@"下拉更新" forState:SVPullToRefreshStateStopped];
    [self.tableView.pullToRefreshView setTitle:@"放開開始更新" forState:SVPullToRefreshStateTriggered];
    [self.tableView.pullToRefreshView setTitle:@"更新中 ..." forState:SVPullToRefreshStateLoading];
    self.tableView.pullToRefreshView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;

}

-(void)apiLoadPageAtIndex:(NSInteger)index
{
    [self.op cancelAllOperations];
    
    NSString *searchTerm = [NSString stringWithFormat:@"%@+雷",self.term];
    
    self.op =
    [GoogleSearchParser searchPttMovieWithTerm:searchTerm page:index*10 completionHandler:^(NSMutableArray *res) {
        
        [self handleModelTitleLogic:res];
        
        if(self.currentIndex==0){
            self.objects = [res mutableCopy];
        }
        else{
            [self.objects addObjectsFromArray:res];
        }
        
        [self.tableView reloadData];
        [self.tableView.pullToRefreshView stopAnimating];
        
    }];
}


-(void)handleModelTitleLogic:(NSArray *)res
{
    NSInteger containTermCount = 0;
    
    for(GModel *model in res){
        model.title = [model.title stringByReplacingOccurrencesOfString:@"- 看板movie" withString:@""];
        model.title = [model.title stringByReplacingOccurrencesOfString:@"- 批踢踢實業坊" withString:@""];
        model.title = [model.title stringByReplacingOccurrencesOfString:@"- 批踢踢" withString:@""];
        
        if([model.title containsString:self.term])
            containTermCount++;
        
        NSArray *urlArr = [model.link componentsSeparatedByString:@"&"];
        if([urlArr count]>1)
            model.link = [urlArr objectAtIndex:0];
    }
    
    if(containTermCount<9)
        self.canLoadMore = NO;
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(self.canLoadMore == NO)
        return;
    
    if([[self.op operations] count]>=1)
        return;
    
    if(scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height)
    {
        self.currentIndex++;
        [self apiLoadPageAtIndex:self.currentIndex];
    }
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GModel *model = [self.objects objectAtIndex:indexPath.row];
    
    if([_delegate respondsToSelector:@selector(pttTableDidSelect:)])
    {
        [_delegate pttTableDidSelect:model];
    }
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
    
    if(model)
    {
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:model.title];
        [title setAllTextWithColor:[UIColor blackColor]];
        [title setAllTextWithFont:[UIFont systemFontOfSize:15]];
        [title setText:self.term color:ColorRed];
        
        NSMutableAttributedString *desc = [[NSMutableAttributedString alloc] initWithString:model.desc];
        [desc setAllTextWithColor:[UIColor lightGrayColor]];
        [desc setAllTextWithFont:[UIFont systemFontOfSize:12]];
        [desc setText:self.term color:ColorRed];
        
        cell.titleLabel.attributedText = title;
        cell.subtitleLabel.text = model.desc;
    }
    else{
        cell.titleLabel.attributedText = nil;
        cell.subtitleLabel.text = nil;
    }
    
    return cell;
}

@end
