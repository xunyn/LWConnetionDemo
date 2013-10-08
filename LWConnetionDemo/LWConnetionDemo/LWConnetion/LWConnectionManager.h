//
//  DownladerManager.h
//  MultDownloader
//
//  Created by Marcus on 12/4/12.
//  Copyright (c) 2012 Marcus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWRequest.h"
#import "LWResponse.h"

//@class LWRequest;

#define MAX_CONCURRENT_OPERATION_COUNT 3

@interface LWConnectionManager : NSObject {
    NSOperationQueue *downloadQueue;
    int i;
}

+ (LWConnectionManager *)defaultManager;

- (void)addRequest:(LWRequest *)reqeust;

@end
