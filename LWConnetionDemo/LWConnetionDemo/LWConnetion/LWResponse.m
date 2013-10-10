//
//  MyResponse.m
//  MultDownloader
//
//  Created by Marcus on 12/4/12.
//  Copyright (c) 2012 Marcus. All rights reserved.
//

#import "LWResponse.h"

@implementation LWResponse

@synthesize responseTarget;
@synthesize responseData;
@synthesize expectedSize;
@synthesize error;
@synthesize downloadRate;
@synthesize response;


- (id)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc{
    #if !__has_feature(objc_arc)
    [responseTarget release];
    [responseData release];
    [error release];
    [response release];
    [super dealloc];
    #endif
}


@end
