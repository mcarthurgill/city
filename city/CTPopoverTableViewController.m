//
//  CTPopoverTableViewController.m
//  city
//
//  Created by Joseph McArthur Gill on 4/13/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import "CTPopoverTableViewController.h"

@interface CTPopoverTableViewController ()

@end

@implementation CTPopoverTableViewController

@synthesize delegate;
@synthesize cities;

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
    self.title = @"Change City";
    cities = [City allCities];
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
    return cities.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [[cities objectAtIndex:indexPath.row] cityName];
    
    return cell;
}


#pragma mark - Table view delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    City *selectedCity = [cities objectAtIndex:indexPath.row];
    if([self.delegate respondsToSelector:@selector(chooseSelectedCity:)])
    {
        [self.delegate chooseSelectedCity:selectedCity];
    }
}

@end
