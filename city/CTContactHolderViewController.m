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
@synthesize searchButton;
@synthesize addContactButton;
@synthesize addedMeButton;
@synthesize thisSession;

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
    thisSession = [BTSession thisSession];
    self.selectedButton = @"addContacts";
    [myTable setContentInset:UIEdgeInsetsMake(myTable.contentInset.top, 0, self.navigationController.toolbar.frame.size.height, 0)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBarController.navigationController setNavigationBarHidden:YES];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.tabBarController.navigationController setNavigationBarHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)addContact:(id)sender {
    self.selectedButton = @"addContacts";
    [[self myTable] reloadData];
}

- (IBAction)addedMe:(id)sender {
    self.selectedButton = @"addedMe";
    [[self myTable] reloadData];
}

- (IBAction)search:(id)sender {
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
    NSLog(@"need to replace these values with contacts who have added them etc.");
    if ([[self selectedButton] isEqualToString:@"addContacts"]) {
        return thisSession.friendsInCity.count;
    }else if ([[self selectedButton] isEqualToString:@"addedMe"]) {
        return thisSession.friendsInCity.count;
    }
    return thisSession.friendsInCity.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if ([thisSession.friendsToChat containsObject:[thisSession.friendsInCity objectAtIndex:indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    cell.textLabel.text = [[thisSession.friendsInCity objectAtIndex:indexPath.row] name];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    User *contact = [thisSession.friendsInCity objectAtIndex:indexPath.row];
    if ([selectedContacts containsObject:contact]) {
        [selectedContacts removeObject:contact];
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
    } else {
        [selectedContacts addObject:contact];
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([[self selectedButton] isEqualToString:@"addContacts"]) {
        return @"Add friends already on City";
    }else if ([[self selectedButton] isEqualToString:@"addedMe"]) {
        return @"My Friends on City";
    }
    return @"this should be a search bar...";
}



@end
