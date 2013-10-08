//
//  MyTableViewCell.m
//  MultDownloader
//
//  Created by Marcus on 12/4/12.
//  Copyright (c) 2012 Marcus. All rights reserved.
//

#import "DownLoadTableViewCell.h"

@implementation DownLoadTableViewCell

@synthesize imageView;
@synthesize progressView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
        [self addSubview:imageView];
        
        progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(60, 20, 250, 20)];
        progressView.hidden = YES;
        [self addSubview:progressView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
