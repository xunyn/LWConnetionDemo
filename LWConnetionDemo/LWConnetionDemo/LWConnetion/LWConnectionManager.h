//
//  LWConnectionManager.h
//  LWConnection
//
//  Created by 寻 亚楠 on 13-8-28.
//  Copyright (c) 2013年 寻 亚楠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWRequest.h"
#import "LWResponse.h"
#import "LWConnectionOpertation.h"


#define MAX_CONCURRENT_OPERATION_COUNT 3

@interface LWConnectionManager : NSObject {
    NSOperationQueue *downloadQueue;
    int i;
}

+ (LWConnectionManager *)defaultManager;

- (void)addRequest:(LWRequest *)reqeust;

- (LWResponse *)addSynchronizedReqeust:(LWRequest *)request;
@end
