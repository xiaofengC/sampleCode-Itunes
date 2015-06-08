//
//  RSSTableViewController.h
//  iTunes RSS Sample
//
//  Created by Xiaofeng Chen on 1/3/15.
//  Copyright (c) 2015 Xiaofeng Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RSSTableViewControllerDelegate;

@interface RSSTableViewController : UITableViewController

@property (nonatomic, weak) id<RSSTableViewControllerDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *dataArray;

- (void)didEndRefreshing;

@end

@protocol RSSTableViewControllerDelegate <NSObject>
- (void)rssTableViewDidSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)refreshEntry;
@end
