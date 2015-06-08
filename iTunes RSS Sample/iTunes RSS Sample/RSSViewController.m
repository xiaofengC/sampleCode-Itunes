//
//  ViewController.m
//  iTunes RSS Sample
//
//  Created by Xiaofeng Chen on 1/2/15.
//  Copyright (c) 2015 Xiaofeng Chen. All rights reserved.
//

#import "RSSViewController.h"
#import "RSSNetworking.h"
#import "RSSDetailViewController.h"
#import "RSSErrorHandler.h"

@interface RSSViewController ()
@property (strong, nonatomic) RSSTableViewController *rssTableController;
@end

@implementation RSSViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib.
    self.rssTableController = [[RSSTableViewController alloc] init];
    [self.rssTableController setDelegate:self];
    [self.view addSubview:self.rssTableController.view];
    [self addChildViewController:self.rssTableController];
    [self.rssTableController didMoveToParentViewController:self];
    
    [self getRssEntry];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - RSSTableViewControllerDelegate

- (void)rssTableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RSSDetailViewController * rssDetailViewController = [[RSSDetailViewController alloc] init];

    [rssDetailViewController setEntry:[self.rssTableController.dataArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:rssDetailViewController animated:NO];
}

- (void)refreshEntry{
    [self getRssEntry];
}

#pragma mark - Networking

- (void)getRssEntry
{
    [[RSSNetworking sharedClient] getRSSEntry:self.rssTableController.dataArray success:^(NSURLSessionDataTask *task, id responseObject) {
        [self.rssTableController.tableView reloadData];
        [self.rssTableController didEndRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.rssTableController didEndRefreshing];
         [RSSErrorHandler handleError:error];
    }] ;
}


@end
