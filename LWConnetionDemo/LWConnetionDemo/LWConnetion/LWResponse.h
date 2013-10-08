//
//  MyResponse.h
//  MultDownloader
//
//  Created by Marcus on 12/4/12.
//  Copyright (c) 2012 Marcus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LWResponse : NSObject

@property (nonatomic, copy) NSString *responseTarget;
@property (nonatomic, strong) NSData *responseData;
@property (nonatomic, assign) int expectedSize;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, assign) float downloadRate;
@property (nonatomic, strong) NSURLResponse *response;


@end
