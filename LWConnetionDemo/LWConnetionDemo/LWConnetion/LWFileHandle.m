//
//  LWFileHandle.m
//  LWConnetionDemo
//
//  Created by 寻 亚楠 on 13-9-2.
//  Copyright (c) 2013年 寻 亚楠. All rights reserved.
//

#import "LWFileHandle.h"

@implementation LWFileHandle

- (id)initWithRequest:(LWRequest*)re{
    self = [super init];
    if (self) {        
        request = re;
        [self setFilePathWithRequestURL:[request.request.URL absoluteString]];
        manager = [NSFileManager defaultManager];
    }
    return self;
}

- (void)writeData:(NSData*)data{
    if (writeFileHandle) {
        [writeFileHandle writeData:data];
    }
}

- (void)closeFile{

    [readFileHandle closeFile];
    [writeFileHandle closeFile];
    [self fileDone:_writingFilePath];
}


- (void) fileDone:(NSString *)path{

    _doneFilePath = [path stringByAppendingPathExtension:@"done"];
    NSError *error;
    //判断是否存在
    if ([manager fileExistsAtPath:_doneFilePath]) {
        [manager removeItemAtPath:_doneFilePath error:&error];
    }else{
        NSLog(@"file not exist at path %@",_doneFilePath);
    }
    
    if ([manager moveItemAtPath:_writingFilePath toPath:_doneFilePath error:&error] ){
        
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
    _writingFilePath = [[self documentPath] stringByAppendingPathComponent:fileName];
    writeFileHandle = [NSFileHandle fileHandleForWritingAtPath:_writingFilePath];
    [writeFileHandle seekToFileOffset:[self getStartOffSetWithPath]];

}
- (void)createFile{
    if (![[NSFileManager defaultManager] fileExistsAtPath:_writingFilePath]) {
        [manager createFileAtPath:_writingFilePath contents:nil attributes:nil];
    }
}

- (unsigned long long)getStartOffSetWithPath{
    if(_writingFilePath)
    {
        if ([[NSFileManager defaultManager] fileExistsAtPath:_writingFilePath]) {
            readFileHandle = [NSFileHandle fileHandleForReadingAtPath:_writingFilePath];
            return [[readFileHandle readDataToEndOfFile] length];
        }
        else{
            //[manager createFileAtPath:_writingFilePath contents:nil attributes:nil];
        }
    }
    return 0;
}


@end
