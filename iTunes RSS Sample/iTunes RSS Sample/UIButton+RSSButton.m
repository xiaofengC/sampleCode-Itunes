//
//  UIButton+RSSButton.m
//  iTunes RSS Sample
//
//  Created by Xiaofeng Chen on 1/4/15.
//  Copyright (c) 2015 Xiaofeng Chen. All rights reserved.
//

#import "UIButton+RSSButton.h"
#import "UIColor+RSSColor.h"
@implementation UIButton (RSSButton)

+(UIButton *) rssButtonWithTitle :(NSString*)title{
    UIButton *rssButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [rssButton setTitle:title forState:UIControlStateNormal];
   
    [rssButton setTitleColor:[UIColor RSSOrangeColor] forState:UIControlStateNormal];
    [rssButton.layer setBorderWidth:1];
    [rssButton.layer setCornerRadius:8];
    [rssButton.layer setBorderColor:[[UIColor RSSOrangeColor] CGColor]];
    // [theButton set...
    return rssButton;
}

@end
