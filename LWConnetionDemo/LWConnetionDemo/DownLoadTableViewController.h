//
//  DownLoadTableViewController.h
//  LWConnetionDemo
//
//  Created by 寻 亚楠 on 13-9-2.
//  Copyright (c) 2013年 寻 亚楠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWConnectionManager.h"
#import "DownLoadTableViewCell.h"

@interface DownLoadTableViewController : UITableViewController<LWConnectionDelegate>{

    LWConnectionManager *connetionManager;
    NSArray * urlArr;
}
@end
