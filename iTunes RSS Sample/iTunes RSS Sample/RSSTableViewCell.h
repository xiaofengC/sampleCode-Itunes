//
//  RSSTableViewCell.h
//  iTunes RSS Sample
//
//  Created by Xiaofeng Chen on 1/3/15.
//  Copyright (c) 2015 Xiaofeng Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSTableViewCell : UITableViewCell

@property(nonatomic,strong) UIImageView * thumbNailImageView;
@property(nonatomic,strong) UILabel * titleLabel;
@property(nonatomic,strong) UILabel * subtitleLabel;
@end
