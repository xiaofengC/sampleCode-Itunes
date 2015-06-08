//
//  RSSEntry.m
//  iTunes RSS Sample
//
//  Created by Xiaofeng Chen on 1/3/15.
//  Copyright (c) 2015 Xiaofeng Chen. All rights reserved.
//

#import "RSSEntry.h"

@implementation RSSEntry

-(instancetype) initWithDictionary:(NSDictionary*) response{
    
    self = [super init];
    
    if (self) {
        self.entryId = response[@"im:id"][@"attributes"];
        self.entryTitle = response[@"im:name"][@"label"];
        NSArray * imageArray =response[@"im:image"];
        self.entryThumbNailUrl = imageArray[1][@"label"];
        self.entryImageUrl =imageArray[2][@"label"] ;
        self.entrySubtitle = response[@"category"][@"attributes"][@"label"];
        self.entryRights = response[@"rights"][@"label"];
        self.entryPrice = response[@"im:price"][@"label"];
        self.entryAuthor = response[@"im:artist"][@"label"];
        self.entryItunesLink = response[@"id"][@"label"];
        self.entryPreviewLink = response[@"link"][1][@"attributes"][@"href"];
        self.entryType = response[@"im:contentType"][@"attributes"][@"label"];
        self.entryReleaseDate= response[@"im:releaseDate"][@"attributes"][@"label"];
        
    }
    return self;
    
}

@end
