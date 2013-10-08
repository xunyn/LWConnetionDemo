//
//  LWFileHandle.h
//  LWConnetionDemo
//
//  Created by 寻 亚楠 on 13-9-2.
//  Copyright (c) 2013年 寻 亚楠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWRequest.h"

@class LWRequest;

@interface LWFileHandle : NSObject{

    NSFileHandle *writeFileHandle;
    NSFileHandle *readFileHandle;
    NSFileManager *manager;
    LWRequest *request;

}
@property (nonatomic,retain) NSString *doneFilePath;
@property (nonatomic,copy) NSString *writingFilePath;


- (unsigned long long)getStartOffSetWithPath;
- (id)initWithRequest:(LWRequest*)re;
- (void)createFile;
- (void)writeData:(NSData*)data;
- (void)closeFile;
@end
