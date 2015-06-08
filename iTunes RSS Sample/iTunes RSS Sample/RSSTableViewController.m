//
//  RSSTableViewController.m
//  iTunes RSS Sample
//
//  Created by Xiaofeng Chen on 1/3/15.
//  Copyright (c) 2015 Xiaofeng Chen. All rights reserved.
//

#import "RSSTableViewController.h"
#import "RSSTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RSSEntry.h"

@interface RSSTableViewController ()


@end

NSString * const kRssTableViewCellIdentifier = @"kRSSTableViewCell";
CGFloat  const kRssTableViewCellHeight = 100.0;


@implementation RSSTableViewController

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.dataArray = [NSMutableArray array];
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //pull to refresh
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
//    self.tableView.estimatedRowHeight = 105;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRssTableViewCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    RSSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kRssTableViewCellIdentifier];
    
    if (cell == nil){
        cell = [[RSSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kRssTableViewCellIdentifier];
    }
    
    RSSEntry * entry = [self.dataArray objectAtIndex:indexPath.row];
    [cell.titleLabel setText:entry.entryTitle];
    [cell.thumbNailImageView sd_setImageWithURL:[NSURL URLWithString:entry.entryImageUrl]];
    [cell.subtitleLabel setText:entry.entrySubtitle];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate rssTableViewDidSelectRowAtIndexPath:indexPath];
}

#pragma mark - Actions
- (void)refresh
{
    [self.delegate refreshEntry];
}

- (void)didEndRefreshing
{
    if (self.refreshControl.refreshing) {
        [self.refreshControl endRefreshing];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
