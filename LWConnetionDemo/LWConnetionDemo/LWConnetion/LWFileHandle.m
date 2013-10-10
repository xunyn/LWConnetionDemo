//
//  LWFileHandle.m
//  LWConnetionDemo
//
//  Created by 寻 亚楠 on 13-9-2.
//  Copyright (c) 2013年 寻 亚楠. All rights reserved.
//

#import "LWFileHandle.h"

@interface LWFileHandle ()
@property (nonatomic,LW_STRONG) NSFileManager *manager;
@property (nonatomic,LW_STRONG) NSFileHandle *writeFileHandle;
@property (nonatomic,LW_STRONG) NSFileHandle *readFileHandle;
@property (nonatomic,LW_STRONG) LWRequest *request;

@end

@implementation LWFileHandle
@synthesize manager;
@synthesize writeFileHandle;
@synthesize readFileHandle;
@synthesize request;
@synthesize doneFilePath;
@synthesize writingFilePath;

- (id)initWithRequest:(LWRequest*)re{
    self = [super init];
    if (self) {        
        self.request = re;
        [self setFilePathWithRequestURL:[request.request.URL absoluteString]];
        self.manager = [NSFileManager defaultManager];
    }
    return self;
}
- (void)dealloc{
    #if !__has_feature(objc_arc)
    [manager release];
    [request release];
    [writeFileHandle release];
    [readFileHandle release];
    [doneFilePath release];
    [writingFilePath release];
    [super dealloc];
    #endif
}

- (void)writeData:(NSData*)data{
    if (writeFileHandle) {
        [writeFileHandle writeData:data];
    }
}

- (void)closeFile{

    [readFileHandle closeFile];
    [writeFileHandle closeFile];
    [self fileDone:writingFilePath];
}


- (void) fileDone:(NSString *)path{

    self.doneFilePath = [path stringByAppendingPathExtension:@"done"];
    NSError *error;
    //file exist or not
    if ([manager fileExistsAtPath:doneFilePath]) {
        [manager removeItemAtPath:doneFilePath error:&error];
    }else{
        NSLog(@"file not exist at path %@",doneFilePath);
    }
    
    if ([manager moveItemAtPath:writingFilePath toPath:doneFilePath error:&error] ){
        
    }else{
        NSLog(@"file manger move error %@",error);
    }


}

- (NSString *)documentPath {
    return  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];;
}

- (void) setFilePathWithRequestURL:(NSString *)url {
    NSArray *urlcomponent = [url componentsSeparatedByString:@"/"];
    NSString *fileName = [urlcomponent lastObject];
    self.writingFilePath = [[self documentPath] stringByAppendingPathComponent:fileName];
    self.writeFileHandle = [NSFileHandle fileHandleForWritingAtPath:writingFilePath];
    [writeFileHandle seekToFileOffset:[self getStartOffSetWithPath]];

}
- (void)createFile{
    if (![[NSFileManager defaultManager] fileExistsAtPath:writingFilePath]) {
        [manager createFileAtPath:writingFilePath contents:nil attributes:nil];
    }
}

- (unsigned long long)getStartOffSetWithPath{
    if(writingFilePath)
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:writingFilePath]) {
            self.readFileHandle = [NSFileHandle fileHandleForReadingAtPath:writingFilePath];
            return [[readFileHandle readDataToEndOfFile] length];
        }
        else{
            //[manager createFileAtPath:_writingFilePath contents:nil attributes:nil];
        }
    }
    return 0;
}


@end
