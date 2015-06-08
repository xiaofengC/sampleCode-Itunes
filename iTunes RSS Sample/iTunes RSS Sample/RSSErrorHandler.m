//
//  RSSErrorHandler.m
//  iTunes RSS Sample
//
//  Created by Xiaofeng Chen on 1/4/15.
//  Copyright (c) 2015 Xiaofeng Chen. All rights reserved.
//

#import "RSSErrorHandler.h"
#import <DLAVAlertView.h>
#import "AFHTTPSessionManager.h"
@implementation RSSErrorHandler

+ (void)handleError:(NSError *)error{
    // display user friendly error
    
    if(![AFNetworkReachabilityManager sharedManager].reachable){
        DLAVAlertView *alertView = [[DLAVAlertView alloc] initWithTitle:@"Oops!" message:@"Please make sure you are connecting to a network." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView showWithCompletion:nil];
        
    }else{
        DLAVAlertView *alertView = [[DLAVAlertView alloc] initWithTitle:@"Oops!" message:@"There are something wrong , Please try again latter." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView showWithCompletion:nil];
        
    }
    NSString * message = error.localizedDescription;
    // send error to the server or use some bug tracking tool.
    NSLog(@"Error = %@",message);
   
}

@end
