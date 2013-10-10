//
//  LWFileHandle.h
//  LWConnection
//
//  Created by 寻 亚楠 on 13-9-2.
//  Copyright (c) 2013年 寻 亚楠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWRequest.h"

@class LWRequest;

@interface LWFileHandle : NSObject{
    

}
@property (nonatomic,copy) NSString *doneFilePath;
@property (nonatomic,copy) NSString *writingFilePath;


- (unsigned long long)getStartOffSetWithPath;
- (id)initWithRequest:(LWRequest*)re;
- (void)createFile;
- (void)writeData:(NSData*)data;
- (void)closeFile;
@end
