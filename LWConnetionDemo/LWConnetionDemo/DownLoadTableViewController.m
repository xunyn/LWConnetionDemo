//
//  DownLoadTableViewController.m
//  LWConnetionDemo
//
//  Created by 寻 亚楠 on 13-9-2.
//  Copyright (c) 2013年 寻 亚楠. All rights reserved.
//

#import "DownLoadTableViewController.h"

@interface DownLoadTableViewController ()

@end

@implementation DownLoadTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    connetionManager = [LWConnectionManager defaultManager];
    
    urlArr = [[NSArray alloc] initWithObjects:@"http://www.wallcoo.com/nature/Japan_Hokkaido_Furano_Country_field_1920x1200/wallpapers/1920x1080/Japan-Hokkaido-Landscape-WUXGA_country_field_0149.jpg",
               @"http://www.sodoos.com/cms/uploads/allimg/100224/8-100224215U8.jpg",
               @"http://www.sodoos.com/cms/uploads/allimg/100224/8-100224215I7.jpg",
               @"http://www.sodoos.com/cms/uploads/allimg/100224/8-100224220106.jpg",nil];

    [self startDownload];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startDownload {
    for (int i = 0 ; i <[urlArr count]; i++) {
        LWRequest *request = [[LWRequest alloc] initWithTraget:[NSString stringWithFormat:@"%d",i] requestURL:[urlArr objectAtIndex:i] isPersistance:YES delegate:self];
        [connetionManager addRequest:request];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [urlArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DownLoadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DownLoadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...

    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


#pragma mark -- LW connetion delegate
- (void)downloadFinished:(LWResponse *)response
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[response.responseTarget integerValue] inSection:0];
    DownLoadTableViewCell *cell = (DownLoadTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    if (response.error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[response.error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        NSLog(@"response error %@",response.error);
        [alertView show];
    } else {
        if (response.responseData) {
            UIImage *image = [UIImage imageWithData:response.responseData];
            if (image) {
                if (cell) {
                    [cell.imageView setImage:image];
                    [cell.progressView setHidden:YES];
                }
            }
        }
    }
}

- (void)downloadInprogress:(LWResponse *)response
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[response.responseTarget integerValue] inSection:0];
    DownLoadTableViewCell *cell = (DownLoadTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    if (response.error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[response.error description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    } else {
        if (cell) {
            [cell.progressView setHidden:NO];
            [cell.progressView setProgress:response.downloadRate];
        }
        
    }
}
@end
