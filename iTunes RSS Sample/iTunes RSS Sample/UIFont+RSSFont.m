//
//  UIFont+RSSFont.m
//  iTunes RSS Sample
//
//  Created by Xiaofeng Chen on 1/3/15.
//  Copyright (c) 2015 Xiaofeng Chen. All rights reserved.
//

#import "UIFont+RSSFont.h"

@implementation UIFont (RSSFont)

+ (UIFont*)RSSHelNeueFontWithSize:(NSInteger)inSize
{
    return [UIFont fontWithName:@"Helvetica Neue" size:inSize];
}

+ (UIFont*)RSSHelNeueBoldFontWithSize:(NSInteger)inSize{
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:inSize];
}

@end
