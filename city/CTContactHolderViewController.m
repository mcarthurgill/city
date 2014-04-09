//
//  CTContactHolderViewController.m
//  city
//
//  Created by Joseph McArthur Gill on 2/13/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import "CTContactHolderViewController.h"

@interface CTContactHolderViewController ()

@end

@implementation CTContactHolderViewController

@synthesize myTable;
@synthesize selectedContacts;
@synthesize selectedButton;
//make 3 uiTableViews that have their own data
//then inside the table view controller i wanna set the datasource depending on which button was clicked
//but first just try to get some seed data showing up for add contacts

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    myTable.delegate = self;
    myTable.dataSource = self;
    self.selectedButton = @"addContacts";
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addContact:(id)sender {
    self.selectedButton = @"addContacts";
    [[self myTable] reloadData];
}

- (IBAction)addedMe:(id)sender {
    self.selectedButton = @"addedMe";
    [[self myTable] reloadData];
}

- (IBAction)searchButton:(id)sender {
    self.selectedButton = @"search";
    [[self myTable] reloadData];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"number of sections in tableView");
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"number of rows in section");
    if ([[self selectedButton] isEqualToString:@"addContacts"]) {
        return 1;
    }else if ([[self selectedButton] isEqualToString:@"addedMe"]) {
        return 2;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"contactCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel* contactName = (UILabel*) [cell.contentView viewWithTag:1];
    
    [contactName setText:@"McArthur"];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unchecked.png"]];
    cell.accessoryView = imageView;
    
    return cell;
}



@end
