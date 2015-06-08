//
//  RSSDetailViewController.h
//  iTunes RSS Sample
//
//  Created by Xiaofeng Chen on 1/3/15.
//  Copyright (c) 2015 Xiaofeng Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSSEntry.h"
@interface RSSDetailViewController : UIViewController
@property (nonatomic,strong) RSSEntry * entry;
@end
