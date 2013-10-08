//
//  MyDownloader.h
//  MultDownloader
//
//  Created by Marcus on 12/4/12.
//  Copyright (c) 2012 Marcus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWResponse.h"
#import "LWFileHandle.h"

@protocol LWConnectionDelegate;
@class LWRequest;
@class LWFileHandle;

@protocol LWConnectionDelegate <NSObject>

- (void)downloadFinished:(LWResponse *)response;
- (void)downloadInprogress:(LWResponse *)response;

@end

@interface LWConnectionOpertation : NSOperation {
    
    NSURLConnection *connection;
    NSString *path;
    NSMutableData *responseData;
    BOOL isFinished;
    unsigned long long startOffset;
    LWFileHandle *fileHandle;
    
}

@property (nonatomic, retain) LWRequest *request;
@property (nonatomic, retain) LWResponse *response;
@property (nonatomic, weak) NSObject <LWConnectionDelegate> *delegate;



- (id)initWithRequest:(LWRequest *)request_;

@end


