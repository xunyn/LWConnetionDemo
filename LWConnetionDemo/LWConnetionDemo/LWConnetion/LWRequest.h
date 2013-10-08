//
//  MyRequest.h
//  MultDownloader
//
//  Created by Marcus on 12/4/12.
//  Copyright (c) 2012 Marcus. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "LWConnectionOpertation.h"

#define DELEGATE_TYPE 0
#define BLOCK_TYPE 1
#define NOT_SAVE 0
#define SAVE_TO_FILE 1

@protocol LWConnectionDelegate;
typedef void(^didFinishBlock) (LWResponse *re);
typedef void(^inProgressBlock) (LWResponse *re);



@interface LWRequest : NSObject

@property (nonatomic, retain) NSString *requestTarget;
@property (nonatomic, retain) NSString *requestURL;

@property (nonatomic, retain) NSMutableURLRequest*request;

@property (nonatomic,copy) didFinishBlock  finishBlock;
@property (nonatomic,copy) inProgressBlock  inprogressBlock;

@property (nonatomic) int callBackType;
@property (nonatomic) int persistentType;
@property (nonatomic, weak) id<LWConnectionDelegate> delegate;


- (id)initWithTraget:(NSString *)target requestURL:(NSString *)url delegate:(id<LWConnectionDelegate>)delegate_;

- (id)initWithTraget:(NSString *)target requestURL:(NSString *)url isPersistance:(BOOL) isPer delegate:(id<LWConnectionDelegate>)delegate_;

- (id)initWithTarget:(NSString *)target requestURL:(NSString *)url isPersistance:(BOOL) isPer finishHandler:(didFinishBlock)finishBlock_ inProgressHandler:(inProgressBlock)progressBlock_;

- (id)initWithTarget:(NSString *)target requestURL:(NSString *)url isPersistance:(BOOL) isPer  delegate:(id<LWConnectionDelegate>)delegate_ finishHandler:(didFinishBlock)finishBlock_ inProgressHandler:(inProgressBlock)progressBlock_;

- (void)setFileOffSet:(unsigned long long) startOffset;

@end
