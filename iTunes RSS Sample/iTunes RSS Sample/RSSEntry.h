//
//  RSSEntry.h
//  iTunes RSS Sample
//
//  Created by Xiaofeng Chen on 1/3/15.
//  Copyright (c) 2015 Xiaofeng Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSSEntry : NSObject

@property (strong,nonatomic) NSString * entryId;
@property (strong,nonatomic) NSString * entryTitle;
@property (strong,nonatomic) NSString * entryAuthor;
@property (strong,nonatomic) NSString * entrySubtitle;
@property (strong,nonatomic) NSString * entryImageUrl;
@property (strong,nonatomic) NSString * entryThumbNailUrl;
@property (strong,nonatomic) NSString * entryItunesLink;
@property (strong,nonatomic) NSString * entryPreviewLink;
@property (strong,nonatomic) NSString * entryPrice;
@property (strong,nonatomic) NSString * entryType;
@property (strong,nonatomic) NSString * entryReleaseDate;
@property (strong,nonatomic) NSString * entryRights;

-(instancetype) initWithDictionary:(NSDictionary*) response;

@end
