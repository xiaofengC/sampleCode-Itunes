//
//  RSSTableViewCell.m
//  iTunes RSS Sample
//
//  Created by Xiaofeng Chen on 1/3/15.
//  Copyright (c) 2015 Xiaofeng Chen. All rights reserved.
//

#import "RSSTableViewCell.h"
#import "UIFont+RSSFont.h"
@implementation RSSTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.thumbNailImageView = [[UIImageView alloc] init];
        [self.thumbNailImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.thumbNailImageView];
        
        NSArray *constraints_height = [NSLayoutConstraint
                                constraintsWithVisualFormat:
                                    @"V:[thumbNailImageView(85)]"
                                options:0
                                metrics:nil
                                views:@{@"thumbNailImageView":self.thumbNailImageView}];
        
        NSArray *constraints_width = [NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:[thumbNailImageView(85)]"
                                     options:0
                                     metrics:nil
                                     views:@{@"thumbNailImageView":self.thumbNailImageView}];
        
        
        
        [self.thumbNailImageView addConstraints:constraints_height];
        [self.thumbNailImageView addConstraints:constraints_width];
        
        self.titleLabel = [[UILabel alloc] init];
        [self.titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.titleLabel setBackgroundColor:[UIColor clearColor]];
        [self.titleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]];
        [self.titleLabel setNumberOfLines:0];
        [self.contentView addSubview:self.titleLabel];
        
        [self.contentView addConstraint:[NSLayoutConstraint
                                    constraintWithItem:self.thumbNailImageView
                                    attribute:NSLayoutAttributeTop
                                    relatedBy:NSLayoutRelationEqual
                                    toItem:self.titleLabel
                                    attribute:NSLayoutAttributeTop
                                    multiplier:1.0
                                    constant:0.0]];
        
        
        NSArray *paddingConstrain_H = [NSLayoutConstraint
                                     constraintsWithVisualFormat:
                                     @"H:|-20-[thumbNailImageView]-20-[title]-20-|"
                                     options:0
                                     metrics:nil
                                     views:@{@"title":self.titleLabel,@"thumbNailImageView":self.thumbNailImageView}];
        
         constraints_height = [NSLayoutConstraint
                                      constraintsWithVisualFormat:
                                      @"V:[title(45)]"
                                      options:0
                                      metrics:nil
                                      views:@{@"title":self.titleLabel}];
        

        [self.contentView addConstraints:paddingConstrain_H];
        [self.titleLabel addConstraints:constraints_height];
        
        self.subtitleLabel = [[UILabel alloc] init];
        [self.subtitleLabel setBackgroundColor:[UIColor clearColor]];
        [self.subtitleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.subtitleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
        [self.contentView addSubview:self.subtitleLabel];
        
//        NSArray *constraints_V = [NSLayoutConstraint
//                                       constraintsWithVisualFormat:
//                                       @"V:[subtitle(20)]"
//                                       options:0
//                                       metrics:nil
//                                       views:@{@"subtitle":self.subtitleLabel}];
        
        [self.contentView addConstraint:[NSLayoutConstraint
                                  constraintWithItem:self.subtitleLabel
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:self.titleLabel
                                  attribute:NSLayoutAttributeWidth
                                  multiplier:1
                                  constant:0.0]];
        
        [self.contentView addConstraint:[NSLayoutConstraint
                                  constraintWithItem:self.subtitleLabel
                                  attribute:NSLayoutAttributeLeft
                                  relatedBy:NSLayoutRelationEqual
                                  toItem:self.titleLabel
                                  attribute:NSLayoutAttributeLeft
                                  multiplier:1.0
                                  constant:0.0]];
        
        NSArray *paddingConstrain_V = [NSLayoutConstraint
                                       constraintsWithVisualFormat:
                                       @"V:|-[title]-[subtitle]-|"
                                       options:0
                                       metrics:nil
                                        views:@{@"subtitle":self.subtitleLabel,@"title":self.titleLabel}];
        

        
        [self.contentView addConstraints:paddingConstrain_V];
//        
    }
    return self;
}


//- (void)awakeFromNib {
//    // Initialization code
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
