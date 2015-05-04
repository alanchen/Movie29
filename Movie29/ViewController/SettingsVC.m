//
//  SettingsVC.m
//  Movie29
//
//  Created by alan on 2015/4/30.
//  Copyright (c) 2015年 alan. All rights reserved.
//

#import "SettingsVC.h"
#import "ACConstraintHelper.h"
#import "TableModel.h"

#import "GlobalVar.h"
#import "UserSettings.h"
#import "CTFeedbackViewController.h"


@interface SettingsVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) TableModel *tableModel;
@property (nonatomic,strong) UISwitch *only9Switcher;

@end

@implementation SettingsVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"設定";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.tableView setFrame:self.view.frame];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = ColorSettingBg;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.view addSubview:self.tableView];
    
    self.only9Switcher = [[UISwitch alloc] initWithFrame:CGRectZero];
    self.only9Switcher.onTintColor = ColorRed;
    [self.only9Switcher setOn:[UserSettings isShowNineOnly] animated:NO];
    [self.only9Switcher addTarget:self action:@selector(switcherChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    NSString *verStr= [NSString stringWithFormat:@"目前版本：%@",kAppVersion];
    self.tableModel =[TableModel tableModelWithGroupTitles:[@[@"設定",@"其他"] mutableCopy]
                                                      rows:[@[ @[@"只顯示九點電影"],
                                                               @[@"回報與建議",verStr] ] mutableCopy]];
    
    
    [self addConstraint];
}

#pragma mark -  Private

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
    
    [self.view addConstraints:myConstraints];
    
}

-(void)switcherChanged:(UISwitch *)switcher
{
    [UserSettings setIsShowNineOnly:switcher.isOn];
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([[self.tableModel objectAtIndexPath:indexPath] isEqualToString:@"回報與建議"])
    {
        CTFeedbackViewController *feedbackViewController = [CTFeedbackViewController controllerWithTopics:CTFeedbackViewController.defaultTopics
                                                                                          localizedTopics:CTFeedbackViewController.defaultLocalizedTopics];
        feedbackViewController.toRecipients = @[@"ctfeedback@example.com"];
        feedbackViewController.useHTML = NO;
        [self.navigationController pushViewController:feedbackViewController animated:YES];
    }
}

#pragma mark - UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.tableModel.titles count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.tableModel titleAtSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
   return  [[self.tableModel rowsAtSection:sectionIndex] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.tableModel objectAtIndexPath:indexPath]];
    
    if(indexPath.section == 0 && indexPath.row==0)
    {
        cell.accessoryView  = self.only9Switcher;
    }
    
    return cell;
}


@end
