//
//  CTCityPickerTableViewController.m
//  city
//
//  Created by Joseph McArthur Gill on 4/12/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import "CTCityPickerTableViewController.h"

@interface CTCityPickerTableViewController ()

@end

@implementation CTCityPickerTableViewController

@synthesize cities;
@synthesize delegate;

-(id)initWithStyle:(UITableViewStyle)style
{
    if ([super initWithStyle:style] != nil) {
        
        //Initialize the array
        cities = [City allCities];
        
        //Make row selections persist.
        self.clearsSelectionOnViewWillAppear = NO;
    }
    
    //Calculate how tall the view should be by multiplying
    //the individual row height by the total number of rows.
    NSInteger rowsCount = [cities count];
    NSInteger singleRowHeight = [self.tableView.delegate tableView:self.tableView
                                           heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSInteger totalRowsHeight = rowsCount * singleRowHeight;
    
    //Calculate how wide the view should be by finding how
    //wide each string is expected to be
    CGFloat largestLabelWidth = 0;
    for (City *city in cities) {
        //Checks size of text using the default font for UITableViewCell's textLabel.
        CGSize labelSize = [city.cityName sizeWithFont:[UIFont boldSystemFontOfSize:20.0f]];
        if (labelSize.width > largestLabelWidth) {
            largestLabelWidth = labelSize.width;
        }
    }
    
    //Add a little padding to the width
    CGFloat popoverWidth = largestLabelWidth + 100;
    
    //Set the property to tell the popover container how big this view will be.
    self.preferredContentSize = CGSizeMake(popoverWidth, totalRowsHeight);
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [cities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [[cities objectAtIndex:indexPath.row] cityName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    City *selectedCity = [cities objectAtIndex:indexPath.row] ;
    
    //Notify the delegate if it exists.
    if (delegate != nil) {
        [delegate selectedCity:selectedCity];
    }
}

@end
