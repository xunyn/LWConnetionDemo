//
//  LWConnectionOperation.h
//  LWConnection
//
//  Created by 寻 亚楠 on 13-8-28.
//  Copyright (c) 2013年 寻 亚楠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWRequest.h"
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
    NSMutableData *responseData;
    BOOL isFinished;
    unsigned long long startOffset;
    LWFileHandle *fileHandle;
    
}

@property (nonatomic, LW_STRONG) LWRequest *request;
@property (nonatomic, LW_STRONG) LWResponse *response;
@property (nonatomic, LW_WEAK) NSObject <LWConnectionDelegate> *delegate;



- (id)initWithRequest:(LWRequest *)request_;

@end


