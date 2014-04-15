//
//  CTSecondTableViewController.m
//  city
//
//  Created by Joseph McArthur Gill on 4/14/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import "CTSecondTableViewController.h"

@interface CTSecondTableViewController ()

@end

@implementation CTSecondTableViewController

@synthesize thisSession;
@synthesize venues;
@synthesize dataArray;

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
    thisSession = [BTSession thisSession];
    
    venues = [[[[thisSession loggedInUser] city] venues] mutableCopy];
    NSMutableArray *bars = [[NSMutableArray alloc] init];
    NSMutableArray *restaurants = [[NSMutableArray alloc] init];
    for (Venue *venue in venues) {
        if ([[[venue venueType] typeName] isEqualToString:@"Bar"]) {
            [bars addObject:venue];
        }else {
            [restaurants addObject:venue];
        }
    }
    
    NSDictionary *barDict = [NSDictionary dictionaryWithObject:bars forKey:@"Bars"];
    NSDictionary *restDict = [NSDictionary dictionaryWithObject:restaurants forKey:@"Restaurants"];
    dataArray = [[NSArray alloc] initWithObjects:barDict, restDict, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *venueDict = [dataArray objectAtIndex:section];
    NSMutableArray *venueArray = [[NSMutableArray alloc] init];
    if ([[venueDict allKeys] containsObject:@"Bars"]) {
        [venueArray addObject:[venueDict objectForKey:@"Bars"]];
    }else {
        [venueArray addObject:[venueDict objectForKey:@"Restaurants"]];
    }
    return [[venueArray firstObject] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[dataArray objectAtIndex:section] allKeys] firstObject];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellWithSwitch"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }

    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.section];
    NSMutableArray *venueArray = [[NSMutableArray alloc] init];
    if ([[dictionary allKeys] containsObject:@"Bars"]) {
        [venueArray addObject:[dictionary objectForKey:@"Bars"]];
    }else {
        [venueArray addObject:[dictionary objectForKey:@"Restaurants"]];
    }
    NSLog(@"stuff = %@", [[[venueArray firstObject] objectAtIndex:indexPath.row] venueName]);
    NSString *cellValue = [[[venueArray firstObject] objectAtIndex:indexPath.row] venueName];
    cell.textLabel.text = cellValue;
    
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
