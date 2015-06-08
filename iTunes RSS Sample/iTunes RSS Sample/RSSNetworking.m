//
//  ITNetworking.m
//  iTunes RSS Sample
//
//  Created by Xiaofeng Chen on 1/3/15.
//  Copyright (c) 2015 Xiaofeng Chen. All rights reserved.
//

#import "RSSNetworking.h"
#import "RSSEntry.h"
@implementation RSSNetworking

NSString * const kRSSURLString = @"https://itunes.apple.com/";

+ (RSSNetworking *)sharedClient {
    static RSSNetworking *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kRSSURLString] sessionConfiguration:configuration];
        
    });
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration*)configuration{
    
    self = [super initWithBaseURL:url sessionConfiguration:configuration];
    if (!self) {
        return nil;
    }
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return self;
}

- (void)getRSSEntry:(NSMutableArray*)toArray success:(void(^)(NSURLSessionDataTask *task, id responseObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure{
    NSString * path = @"https://itunes.apple.com/us/rss/topaudiobooks/limit=10/json" ;
    
    [self GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        if (success) {
            
            
            NSDictionary * responseFeed = responseObject[@"feed"];
            NSArray * responseEntry = responseFeed[@"entry"];
            for (NSDictionary * response in responseEntry) {
                RSSEntry * entry = [[RSSEntry alloc] initWithDictionary:response];

                [toArray addObject:entry];
            }

            success(task, responseObject);
           
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            
            failure(task, error);
        }
    }];
}

@end
