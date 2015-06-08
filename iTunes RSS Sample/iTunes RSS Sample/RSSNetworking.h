//
//  ITNetworking.h
//  iTunes RSS Sample
//
//  Created by Xiaofeng Chen on 1/3/15.
//  Copyright (c) 2015 Xiaofeng Chen. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface RSSNetworking : AFHTTPSessionManager

+ (RSSNetworking*)sharedClient;

- (void)getRSSEntry:(NSMutableArray*)toArray success:(void(^)(NSURLSessionDataTask *task, id responseObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;


@end
