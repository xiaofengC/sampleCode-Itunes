//
//  RSSDetailViewController.m
//  iTunes RSS Sample
//
//  Created by Xiaofeng Chen on 1/3/15.
//  Copyright (c) 2015 Xiaofeng Chen. All rights reserved.
//

#import "RSSDetailViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVPlayerItem.h>
#import <AVFoundation/AVAsset.h>
#import "RSSErrorHandler.h"
#import "UIButton+RSSButton.h"
#import "UIColor+RSSColor.h"
@interface RSSDetailViewController ()

@property (nonatomic,strong)AVPlayer *audioStreamer;
@end

@implementation RSSDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navigationBarHeight = self.navigationController.navigationBar.frame.size.height;
    
    [self.view setTranslatesAutoresizingMaskIntoConstraints:YES];
//    [self.view addSubview:self.view];
    
    UIView * profileView = [[UIView alloc] init];
    [profileView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [profileView setBackgroundColor:[UIColor RSSWhiteColor]];
    [self.view addSubview:profileView];
    
    UIView * contentView = [[UIView alloc] init];
    [contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [contentView setBackgroundColor:[UIColor RSSBlackColor]];
    [self.view addSubview:contentView];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:profileView
                              attribute:NSLayoutAttributeWidth
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeWidth
                              multiplier:1
                              constant:0.0]];
    
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:contentView
                              attribute:NSLayoutAttributeWidth
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeWidth
                              multiplier:1
                              constant:0.0]];
    
    

    
    UIImageView *profileImageView = [[UIImageView alloc] init];
    [profileImageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [profileImageView sd_setImageWithURL:[NSURL URLWithString:self.entry.entryImageUrl]];
    [profileView addSubview:profileImageView];

    NSArray *constraints_width = [NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"H:[profileImageView(170)]"
                                   options:0
                                   metrics:nil
                                   views:@{@"profileImageView":profileImageView}];
    
    NSArray * constraints_height = [NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"V:[profileImageView(170)]"
                                   options:0
                                   metrics:nil
                                   views:@{@"profileImageView":profileImageView}];
    [profileImageView addConstraints:constraints_height];
    [profileImageView addConstraints:constraints_width];
    
//    CGSize size = [self.entry.entryTitle sizeWithAttributes:
//                   @{NSFontAttributeName:
//                         [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]}];
    UILabel * titleLabel = [[UILabel alloc] init];
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [titleLabel setText:self.entry.entryTitle];
    [titleLabel setTextColor:[UIColor RSSBlackColor]];
    [titleLabel setNumberOfLines:0];
    [titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
//    [titleLabel sizeToFit];
    [titleLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]] ;
    [profileView addSubview:titleLabel];
    
    
    UILabel * authorLabel = [[UILabel alloc] init];
    [authorLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [authorLabel setText:[NSString stringWithFormat:@"by %@",self.entry.entryAuthor]];
    [authorLabel setTextColor:[UIColor RSSBlackColor]];
    [authorLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
    [authorLabel setNumberOfLines:0];
    [authorLabel setLineBreakMode:NSLineBreakByWordWrapping];
//    [authorLabel sizeToFit];
    [profileView addSubview:authorLabel];
    
    UILabel * priceLabel = [[UILabel alloc] init];
    [priceLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [priceLabel setText:self.entry.entryPrice];
    [priceLabel setTextColor:[UIColor RSSOrangeColor]];
    [priceLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]];
//    [priceLabel sizeToFit];
    [profileView addSubview:priceLabel];
    
    UIButton * ituneButton = [UIButton rssButtonWithTitle:@"View in Itunes"];
    [ituneButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [ituneButton addTarget:self action:@selector(doItunes) forControlEvents:UIControlEventTouchUpInside];
    [profileView addSubview:ituneButton];
    
    constraints_height =[NSLayoutConstraint
                         constraintsWithVisualFormat:
                         @"V:[ituneButton(30)]"
                         options:0
                         metrics:nil
                         views:@{@"ituneButton":ituneButton}];
    [ituneButton addConstraints:constraints_height];
    
    
    constraints_height = [NSLayoutConstraint
                          constraintsWithVisualFormat:
                          @"V:[profile(>=200)]"
                          options:0
                          metrics:@{@"height": @(ituneButton.frame.origin.y+ituneButton.frame.size.height+15)}
                          views:@{@"profile":profileView}];
    [profileView addConstraints:constraints_height];
    
    NSArray *paddingConstrain_V = [NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"V:|-padding-[title]-padding-[author]-padding-[price]-padding-[ituneButton]-padding-|"
                                   options:0
                                   metrics:@{@"padding": @10}
                                views:@{@"title":titleLabel,@"author":authorLabel,@"price":priceLabel,@"ituneButton":ituneButton}];
    
    NSArray *paddingConstrain_H = [NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"H:|-padding-[profileImageView]-padding-[title]-padding-|"
                                   options:0
                                   metrics:@{@"padding": @10}
                                   views:@{@"title":titleLabel,@"profileImageView":profileImageView}];
    

    [profileView addConstraints:paddingConstrain_V];
    [profileView addConstraints:paddingConstrain_H];
    
    
    [profileView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:authorLabel
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:titleLabel
                                     attribute:NSLayoutAttributeWidth
                                     multiplier:1
                                     constant:0.0]];
    
    [profileView addConstraint:[NSLayoutConstraint
                                constraintWithItem:profileImageView
                                attribute:NSLayoutAttributeTop
                                relatedBy:NSLayoutRelationEqual
                                toItem:titleLabel
                                attribute:NSLayoutAttributeTop
                                multiplier:1
                                constant:0.0]];
    
    [profileView addConstraint:[NSLayoutConstraint
                                     constraintWithItem:authorLabel
                                     attribute:NSLayoutAttributeLeft
                                     relatedBy:NSLayoutRelationEqual
                                     toItem:titleLabel
                                     attribute:NSLayoutAttributeLeft
                                     multiplier:1.0
                                     constant:0.0]];
    
    [profileView addConstraint:[NSLayoutConstraint
                                constraintWithItem:priceLabel
                                attribute:NSLayoutAttributeLeft
                                relatedBy:NSLayoutRelationEqual
                                toItem:titleLabel
                                attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                constant:0.0]];
    
    [profileView addConstraint:[NSLayoutConstraint
                                constraintWithItem:ituneButton
                                attribute:NSLayoutAttributeLeft
                                relatedBy:NSLayoutRelationEqual
                                toItem:titleLabel
                                attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                constant:0.0]];
    
    [profileView addConstraint:[NSLayoutConstraint
                                constraintWithItem:ituneButton
                                attribute:NSLayoutAttributeWidth
                                relatedBy:NSLayoutRelationEqual
                                toItem:titleLabel
                                attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                constant:0.0]];
    NSLog(@"height = %f",ituneButton.frame.origin.y+ituneButton.frame.size.height);

    
//    if(ituneButton.frame.origin.y+ituneButton.frame.size.height>profileImageView.frame.size.height+10){
//        constraints_height = [NSLayoutConstraint
//                              constraintsWithVisualFormat:
//                              @"V:[profile(280)]"
//                              options:0
//                              metrics:@{@"height": @(ituneButton.frame.origin.y+ituneButton.frame.size.height+15)}
//                              views:@{@"profile":profileView}];
//    }else{
//        constraints_height = [NSLayoutConstraint
//                              constraintsWithVisualFormat:
//                              @"V:[profile(200)]"
//                              options:0
//                              metrics:@{@"height": @(ituneButton.frame.origin.y+ituneButton.frame.size.height+15)}
//                              views:@{@"profile":profileView}];
//    }
//
//    [profileView addConstraints:constraints_height];
    
    NSArray *constraints_Profile = [NSLayoutConstraint
                                    constraintsWithVisualFormat:
                                    @"V:|-paddingTop-[profile]-[content]-|"
                                    options:0
                                    metrics:@{@"paddingTop": @(statusBarHeight+navigationBarHeight)}
                                    views:@{@"profile":profileView,@"content":contentView}];
    [self.view addConstraints:constraints_Profile];
    
//    int paddingY = 15;
//    CGFloat profileViewHeight = (ituneButton.frame.origin.y+ituneButton.frame.size.height>profileImageView.frame.size.height+paddingY)?ituneButton.frame.origin.y+ituneButton.frame.size.height:profileImageView.frame.size.height+2*paddingY;
//    [profileView setFrame:CGRectMake(profileView.frame.origin.x, profileView.frame.origin.y, profileView.frame.size.width, profileViewHeight
//                                     )];

//    paddingX =20;
//    paddingY =20;
//    
    UILabel * contentTypeLabel = [[UILabel alloc] init];
    [contentTypeLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [contentTypeLabel setTextColor:[UIColor RSSWhiteColor]];
    [contentTypeLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [contentTypeLabel setText:[NSString stringWithFormat:@"Content Type: %@",self.entry.entryType]];
    [titleLabel setNumberOfLines:0];
    [titleLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [contentView addSubview:contentTypeLabel];
    
    UILabel * categoryLabel = [[UILabel alloc] init];
    [categoryLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [categoryLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [categoryLabel setTextColor:[UIColor RSSWhiteColor]];
    [categoryLabel setText:[NSString stringWithFormat:@"Category: %@",self.entry.entrySubtitle]];
    [contentView addSubview:categoryLabel];
    
    UILabel * releaseLabel = [[UILabel alloc] init];
    [releaseLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [releaseLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [releaseLabel sizeToFit];
    [releaseLabel setTextColor:[UIColor RSSWhiteColor]];
    [releaseLabel setText:[NSString stringWithFormat:@"Release on: %@",self.entry.entryReleaseDate]];
    [contentView addSubview:releaseLabel];
    
    UILabel * rightsLabel = [[UILabel alloc] init];
    [rightsLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [rightsLabel setText:[NSString stringWithFormat:@"Rights belong to: %@",self.entry.entryRights]];
    [rightsLabel setTextColor:[UIColor RSSWhiteColor]];
    [rightsLabel setNumberOfLines:0];
    [rightsLabel setLineBreakMode:NSLineBreakByWordWrapping] ;
    [rightsLabel setFont:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]];
    [contentView addSubview:rightsLabel];
    
    UIButton * previewButton = [UIButton rssButtonWithTitle:@"Preview this book"];
    [previewButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [previewButton addTarget:self action:@selector(doPreview:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:previewButton];
    
    constraints_height =[NSLayoutConstraint
                         constraintsWithVisualFormat:
                         @"V:[previewButton(30)]"
                         options:0
                         metrics:nil
                         views:@{@"previewButton":previewButton}];
    
    constraints_width =[NSLayoutConstraint
                         constraintsWithVisualFormat:
                         @"H:[previewButton(200)]"
                         options:0
                         metrics:nil
                         views:@{@"previewButton":previewButton}];
    
    [previewButton addConstraints:constraints_height];
    [previewButton addConstraints:constraints_width];
    
    paddingConstrain_V = [NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"V:|-padding-[type]-padding-[category]-padding-[release]-padding-[rights]-padding-[previewButton]"
                                   options:0
                                   metrics:@{@"padding": @20}views:@{@"type":contentTypeLabel,@"category":categoryLabel,@"release":releaseLabel,@"previewButton":previewButton,@"rights":rightsLabel}];
    
    paddingConstrain_H = [NSLayoutConstraint
                                   constraintsWithVisualFormat:
                                   @"H:|-padding-[type]-padding-|"
                                   options:0
                                   metrics:@{@"padding": @20}
                                   views:@{@"type":contentTypeLabel}];
    
    
    [contentView addConstraints:paddingConstrain_V];
    [contentView addConstraints:paddingConstrain_H];
    
    [contentView addConstraint:[NSLayoutConstraint
                                constraintWithItem:categoryLabel
                                attribute:NSLayoutAttributeLeft
                                relatedBy:NSLayoutRelationEqual
                                toItem:contentTypeLabel
                                attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                constant:0.0]];
    
    [contentView addConstraint:[NSLayoutConstraint
                                constraintWithItem:releaseLabel
                                attribute:NSLayoutAttributeLeft
                                relatedBy:NSLayoutRelationEqual
                                toItem:contentTypeLabel
                                attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                constant:0.0]];
    
    [contentView addConstraint:[NSLayoutConstraint
                                constraintWithItem:rightsLabel
                                attribute:NSLayoutAttributeLeft
                                relatedBy:NSLayoutRelationEqual
                                toItem:contentTypeLabel
                                attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                constant:0.0]];
    
    [contentView addConstraint:[NSLayoutConstraint
                                constraintWithItem:rightsLabel
                                attribute:NSLayoutAttributeWidth
                                relatedBy:NSLayoutRelationEqual
                                toItem:contentTypeLabel
                                attribute:NSLayoutAttributeWidth
                                multiplier:1.0
                                constant:0.0]];
    
    
    
    [contentView addConstraint:[NSLayoutConstraint
                                constraintWithItem:previewButton
                                attribute:NSLayoutAttributeLeft
                                relatedBy:NSLayoutRelationEqual
                                toItem:contentTypeLabel
                                attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                constant:0.0]];
    
    
    
    AVPlayerItem *previewItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:self.entry.entryPreviewLink]];
    self.audioStreamer = [[AVPlayer alloc] initWithPlayerItem:previewItem];
    [self.audioStreamer addObserver:self forKeyPath:@"status" options:0 context:nil];
}

#pragma mark - Actions
-(void)doItunes{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.entry.entryItunesLink]];

}

static bool isPreviewOn = false;
-(void)doPreview:(id)sender{
    UIButton * button = (UIButton*)sender;
    if (!isPreviewOn) {

        [self.audioStreamer play];

        [button setTitle:@"Pause previewing" forState:UIControlStateNormal];
    }else{
        [self.audioStreamer pause];
        [button setTitle:@"Preview this book" forState:UIControlStateNormal];
    }

    isPreviewOn = ! isPreviewOn;
 
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (object ==  self.audioStreamer && [keyPath isEqualToString:@"status"]) {
        if ( self.audioStreamer.status == AVPlayerStatusFailed) {
            NSLog(@"AVPlayer Failed");
            [RSSErrorHandler handleError: self.audioStreamer.error];
            
        } else if ( self.audioStreamer.status == AVPlayerStatusReadyToPlay) {
            NSLog(@"AVPlayerStatusReadyToPlay");
            
        } else if ( self.audioStreamer.status == AVPlayerStatusUnknown) {
            NSLog(@"AVPlayer Unknown");
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {

    [self.audioStreamer  removeObserver:self forKeyPath:@"status" context:nil];
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
