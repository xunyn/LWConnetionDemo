//
//  DownladerManager.m
//  MultDownloader
//
//  Created by Marcus on 12/4/12.
//  Copyright (c) 2012 Marcus. All rights reserved.
//

#import "LWConnectionManager.h"
#import "LWConnectionOpertation.h"

@interface LWConnectionManager ()

@end

@implementation LWConnectionManager

static LWConnectionManager *instance;



+ (LWConnectionManager *)defaultManager {
    if (!instance) {
        instance = [[self alloc] init];
    }
 
    return instance;
}

- (id)init {
    if (self = [super init]) {
        downloadQueue = [[NSOperationQueue alloc] init];
        downloadQueue.maxConcurrentOperationCount = MAX_CONCURRENT_OPERATION_COUNT;
        i = 0;
    }
    return self;
}

- (void)dealloc{
#if !__has_feature(objc_arc)
    [downloadQueue release];
    [super dealloc];
#endif
}

- (void)setMaxConcurrentOperationCount:(int)max{
    if (max >0) {
        downloadQueue.maxConcurrentOperationCount = max;
    }
}

- (void)addRequest:(LWRequest *)reqeust {
    LWConnectionOpertation *downloader = LW_AUTORELEASE([[LWConnectionOpertation alloc] initWithRequest:reqeust]);
    [downloadQueue addOperation:downloader];
    i ++;
}

- (LWResponse *)addSynchronizedReqeust:(LWRequest *)request{
    NSError *error;
    NSURLResponse *response;
    NSData *data= [NSURLConnection sendSynchronousRequest:request.request returningResponse:&response error:&error];
    LWResponse *re = [[LWResponse alloc]init];
    re.response = response;
    re.responseData = data;
    re.error = error;
    re.responseTarget = request.requestTarget;
    return re;
}



@end
