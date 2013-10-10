//
//  LWResponse.h
//  LWConnection
//
//  Created by 寻 亚楠 on 13-8-28.
//  Copyright (c) 2013年 寻 亚楠. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWRequest.h"

@interface LWResponse : NSObject

@property (nonatomic, copy) NSString *responseTarget;
@property (nonatomic, LW_STRONG) NSData *responseData;
@property (nonatomic) int expectedSize;
@property (nonatomic, LW_STRONG) NSError *error;
@property (nonatomic) float downloadRate;
@property (nonatomic, LW_STRONG) NSURLResponse *response;


@end
