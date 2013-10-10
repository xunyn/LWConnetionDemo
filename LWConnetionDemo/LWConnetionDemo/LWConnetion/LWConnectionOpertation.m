//
//  MyDownloader.m
//  MultDownloader
//
//  Created by Marcus on 12/4/12.
//  Copyright (c) 2012 Marcus. All rights reserved.
//

#import "LWConnectionOpertation.h"
#import "LWRequest.h"
#import "LWResponse.h"

@interface LWConnectionOpertation ()

@end

@implementation LWConnectionOpertation

@synthesize request;
@synthesize response;
@synthesize delegate;


- (void)main {
    connection = [[NSURLConnection alloc] initWithRequest:request.request delegate:self startImmediately:YES];
    NSLog(@"request is %@",request);
    isFinished = NO;
    response.responseTarget = request.requestTarget;
    if (connection) {
        do {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        } while (!isFinished);
    }
}

- (id)initWithRequest:(LWRequest *)request_ {
    if (self = [super init]) {
        self.request = request_;
        response = [[LWResponse alloc] init];
        self.delegate = self.request.delegate;
        if (request.persistentType == SAVE_TO_FILE){
            fileHandle = [[LWFileHandle alloc] initWithRequest:request];
        }else{
            fileHandle= nil;
        }
        startOffset = [fileHandle getStartOffSetWithPath];
        [self.request setFileOffSet:startOffset];
    }
    return self;
}

- (void)dealloc{
    #if !__has_feature(objc_arc)
    [connection release];
    [fileHandle release];
    [request release];
    [response release];
    [super dealloc];
    #endif
}
#pragma mark -- NS URL Connetion Delegate Protocal
- (void)connection:(NSURLConnection *)connection_ didReceiveResponse:(NSURLResponse *)response_ {
    if ([[((NSHTTPURLResponse *)response_) allHeaderFields] objectForKey:@"Content-Length"]) {
        response.expectedSize = [[[((NSHTTPURLResponse *)response_) allHeaderFields] objectForKey:@"Content-Length"] integerValue];
    }
    response.response = response_;
    [fileHandle createFile];
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection_ didReceiveData:(NSData *)data_{
    [responseData appendData:data_];
    NSLog(@"%@:download complete %f / 100",fileHandle.writingFilePath,([responseData length]+startOffset)/(float)(response.expectedSize+startOffset) *100.0);
    response.downloadRate = ([responseData length]+startOffset)/(float)(response.expectedSize+startOffset);

    if (request.persistentType == SAVE_TO_FILE) {
       [fileHandle writeData:data_];
    }
    
    if (request.callBackType == DELEGATE_TYPE) {
        if (delegate && [delegate respondsToSelector:@selector(downloadInprogress:)]) {
            [delegate performSelectorOnMainThread:@selector(downloadInprogress:) withObject:response waitUntilDone:NO];
        }
    }
    else if(request.callBackType == BLOCK_TYPE) {
        if (request.inprogressBlock) {
           dispatch_async(dispatch_get_main_queue(),^(void){request.inprogressBlock(response);});
        }
    }
    else{
    
    }
    

}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection_{
    
    response.responseData = responseData;
    isFinished = YES;
    
    if (request.callBackType == DELEGATE_TYPE) {
        if (delegate && [delegate respondsToSelector:@selector(downloadFinished:)]) {
            [delegate performSelectorOnMainThread:@selector(downloadFinished:) withObject:response waitUntilDone:NO];

        }
    }
    else if(request.callBackType == BLOCK_TYPE) {
        if (request.finishBlock) {
            dispatch_async(dispatch_get_main_queue(),^(void){request.finishBlock(response);});
        }
    }
    else{
    
    
    }
    //connection = nil;
    [fileHandle closeFile];
}

-(void)connection:(NSURLConnection *)connection_ didFailWithError:(NSError *)error{
    //TDD wap error here
    [response setError:error];
    //connection_ = nil;
    
    if (request.callBackType == DELEGATE_TYPE) {
        if (delegate && [delegate respondsToSelector:@selector(downloadFinished:)]) {
            [delegate performSelectorOnMainThread:@selector(downloadFinished:) withObject:response waitUntilDone:NO];

        }
    }
    else if(request.callBackType == BLOCK_TYPE) {
        if (request.finishBlock) {
            dispatch_async(dispatch_get_main_queue(),^(void){request.finishBlock(response);});
                          
        }
    }
    else{
        
    }
    
    isFinished = YES;

}

@end
