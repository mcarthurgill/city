//
//  CTContactHolderViewController.m
//  city
//
//  Created by Joseph McArthur Gill on 2/13/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

@import AddressBook;

#import "CTContactHolderViewController.h"

@interface CTContactHolderViewController ()

@end

@implementation CTContactHolderViewController

@synthesize myTable;
@synthesize selectedContacts;
@synthesize selectedButton;
@synthesize friendsOnApp;
@synthesize friendsOnAppButton;
@synthesize inviteButton;
@synthesize thisSession;
@synthesize allContacts;
@synthesize buttonView;
@synthesize sendInvitationsButton;
@synthesize searchBar;
@synthesize searchResults;

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

    thisSession = [BTSession thisSession];

    allContacts = [[NSMutableArray alloc] init];
    selectedContacts = [[NSMutableArray alloc] init];
    friendsOnApp = [[thisSession loggedInUser] friendsOnApp];
    [buttonView addSubview:sendInvitationsButton];
    searchBar.delegate = self;
    
    CTAppDelegate* appDelegate = (CTAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:buttonView];
    [buttonView setHidden:YES];
    
    [self prePermission];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [friendsOnAppButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    [self.tabBarController.navigationController setNavigationBarHidden:YES];
    [self shouldShowButtonView];
    [myTable reloadData];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.tabBarController.navigationController setNavigationBarHidden:NO];
    [selectedContacts removeAllObjects];
    [self hideButtonAtBottom];
    [self resetSearchInformation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


# pragma mark - Button View

- (void) shouldShowButtonView
{
    if (selectedContacts.count > 0 && [buttonView isHidden]) {
        [self showButtonAtBottom];
    } else {
        [self shouldHideButtonView];
    }
}

- (void) shouldHideButtonView
{
    if (selectedContacts.count == 0 && ![buttonView isHidden]) {
        [self hideButtonAtBottom];
    }
}

- (void) showButtonAtBottom
{
    [buttonView setHidden:NO];
    [myTable setContentInset:UIEdgeInsetsMake(myTable.contentInset.top, 0, buttonView.frame.size.height, 0)];
    [myTable scrollToRowAtIndexPath:myTable.indexPathsForSelectedRows.lastObject atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void) hideButtonAtBottom
{
    [buttonView setHidden:YES];
    [myTable setContentInset:UIEdgeInsetsMake(myTable.contentInset.top, 0, 0, 0)];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"begin number of sections in tableView");
    if ([selectedButton isEqualToString:@"inviteButton"]) {
        return 1;
    }
    if ([selectedButton isEqualToString:@"friendsOnApp"] && [searchResults count] > 0) {
        return searchResults.count;
    }
    NSLog(@"end number of sections in tableView");

    return friendsOnApp.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"begin number rows in section");
    if ([[self selectedButton] isEqualToString:@"inviteButton"]) {
        if ([searchResults count] > 0) {
            return searchResults.count;
        }
        return allContacts.count;
    }else {
        if ([searchResults count] > 0) {
            return [[[searchResults objectAtIndex:section] valueForKey:@"users"] count];
        }
    }
        NSLog(@"end number rows in section");
    return [[[friendsOnApp objectAtIndex:section] valueForKey:@"users"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"begin cell for row at indexpath");

    NSString *CellIdentifier = @"contactCell";
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    if ([selectedButton isEqualToString:@"friendsOnApp"]) {
        CellIdentifier = @"friendCell";
    }

    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    
    UILabel* contact = (UILabel*) [cell.contentView viewWithTag:1];
    

    if ([selectedButton isEqualToString:@"inviteButton"]) {
        if ([searchResults count] > 0) {
            NSLog(@"search results count > 0");
            [contact setText:[[searchResults objectAtIndex:indexPath.row] valueForKey:@"name"]];
        } else {
            [contact setText:[[allContacts objectAtIndex:indexPath.row] valueForKey:@"name"]];
        }
        [self setCheckMarkImageForCell:cell AtIndexPath:indexPath];
    } else if ([selectedButton isEqualToString:@"friendsOnApp"]) {
        if ([searchResults count] > 0) {
            [contact setText:[[[[searchResults objectAtIndex:indexPath.section] valueForKey:@"users"] objectAtIndex:indexPath.row] name]];
        }else {
            [contact setText:[[[[friendsOnApp objectAtIndex:indexPath.section] valueForKey:@"users"] objectAtIndex:indexPath.row] name]];
        }
    }
    NSLog(@"end cell for row at indexpath");
    return cell;
}
         
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
         NSLog(@"begin title for header in section");
     if ([[self selectedButton] isEqualToString:@"friendsOnApp"]) {
         if ([searchResults count] > 0) {
             return [[searchResults objectAtIndex:section] valueForKey:@"city"];
         } else {
             return [[friendsOnApp objectAtIndex:section] valueForKey:@"city"];
         }
     }
         NSLog(@"end title for header in section");
     return @"Invite More Friends";
 }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
        NSLog(@"begin selectrowatindexpath");
    NSDictionary *contact = [allContacts objectAtIndex:indexPath.row];
    if (searchResults.count > 0) {
        contact = [searchResults objectAtIndex:indexPath.row];
    }
    if ([selectedButton isEqualToString:@"inviteButton"]) {
        if (![selectedContacts containsObject:contact]) {
            [selectedContacts addObject:contact];
            [self shouldShowButtonView];
            [self setCheckMarkImageForCell:[tableView cellForRowAtIndexPath:indexPath] AtIndexPath:indexPath];
        }
    }
            NSLog(@"end selectrowatindexpath");
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
            NSLog(@"begin deselectrowatindexpath");
    NSDictionary *contact = [allContacts objectAtIndex:indexPath.row];
    if (searchResults.count > 0) {
        contact = [searchResults objectAtIndex:indexPath.row];
    }
    if ([selectedContacts containsObject:contact]) {
        [selectedContacts removeObject:contact];
        [self setCheckMarkImageForCell:[tableView cellForRowAtIndexPath:indexPath] AtIndexPath:indexPath];
        if (selectedContacts.count == 0) {
            [self hideButtonAtBottom];
        }
    }
            NSLog(@"end selectrowatindexpath");
}

- (void) setCheckMarkImageForCell:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"begin setcheckmark");
    if ([[self selectedButton] isEqualToString:@"inviteButton"]) {
        UIImageView* cellCheckmark = (UIImageView*) [cell.contentView viewWithTag:2];
        
        NSString *imageName = @"unchecked.png";
        if (searchResults.count > 0 && [selectedContacts containsObject:[searchResults objectAtIndex:indexPath.row]]) {
            NSLog(@"****setting because of searchResults %ld", (long)indexPath.row);
            imageName = @"checked.png";
        } else if (allContacts.count > 0 && [selectedContacts containsObject:[allContacts objectAtIndex:indexPath.row]]) {
                        NSLog(@"****setting because of allcontacts");
            imageName = @"checked.png";
        }
        NSLog(@"searchResults : %@", searchResults);
        NSLog(@"selectedContacts : %@", selectedContacts);
        
        UIImage* image = [UIImage imageNamed:imageName];
        [cellCheckmark setImage:image];
    }
    NSLog(@"*****ending setcheckmarkforcell");
}

# pragma mark - permissions

- (void)prePermission {
    if (ABAddressBookGetAuthorizationStatus() != kABAuthorizationStatusAuthorized) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Find your friends" message:@"In order to find your friends who have City, we need permission to load your contacts" delegate:self cancelButtonTitle:@"Not now" otherButtonTitles:@"Show my friends", nil];
        
        [alert show];
    } else {
        [self obtainContactList];
        [myTable reloadData]; 
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) { // and they clicked OK.
        NSLog(@"accepted initial alert");
        [self contactsPermissions];
    }else {
        NSLog(@"rejected initial alert");
        //show search with bottom table result as button that shows results from iphone contacts
    }
}

- (void)contactsPermissions {
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
        UIAlertView *cantAddContactAlert = [[UIAlertView alloc] initWithTitle: @"Cannot Add Contact" message: @"You must give the app permission to add the contact first. Go to Settings -> Privacy -> Contacts -> change the switch on City" delegate:nil cancelButtonTitle: @"OK" otherButtonTitles: nil];
        [cantAddContactAlert show];
        NSLog(@"Denied");
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        NSLog(@"Authorized");
        [self obtainContactList];
        [myTable reloadData];
    } else{ //ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined
        NSLog(@"Not determined");
        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
            if (!granted){
                NSLog(@"Just denied");
                return;
            } else {
                NSLog(@"Just authorized");
                [self obtainContactList];
                [myTable performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
            }
        });
    }
}

# pragma mark - Populate Contacts

- (void)obtainContactList {
    CFErrorRef *error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, error);
    ABRecordRef source = ABAddressBookCopyDefaultSource(addressBook);
    NSArray *orderedContacts = (__bridge_transfer NSArray *)ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(addressBook, source, kABPersonSortByFirstName);
    if (orderedContacts.count > 0) {
        for (int i = 0; i < [orderedContacts count]; i++) {
            NSString *firstName = (__bridge NSString *)ABRecordCopyValue((__bridge ABRecordRef)[orderedContacts objectAtIndex:i], kABPersonFirstNameProperty);
            NSString *lastName = (__bridge NSString *)ABRecordCopyValue((__bridge ABRecordRef)[orderedContacts objectAtIndex:i], kABPersonLastNameProperty);
            ABMultiValueRef phoneNumbersPerPerson = ABRecordCopyValue((__bridge ABRecordRef)[orderedContacts objectAtIndex:i], kABPersonPhoneProperty);
            
            NSString *fullName = [self combineFirstName:firstName AndLastName:lastName];
            
            NSMutableArray *numbersToText = [[NSMutableArray alloc] init];
            CFIndex phoneNumberCount = ABMultiValueGetCount(phoneNumbersPerPerson);
            
            if (phoneNumberCount > 0 && fullName.length > 0) {
                for (CFIndex j = 0; j < phoneNumberCount; j++) {
                    [numbersToText addObject:(__bridge NSString *)ABMultiValueCopyValueAtIndex(phoneNumbersPerPerson, j)];
                }
                //dictionary has full name pointing to array of phone numbers
                NSDictionary *contactDict = [[NSDictionary alloc] initWithObjectsAndKeys:numbersToText, @"phone", fullName, @"name", nil];
                [allContacts addObject:contactDict];
            }
        }
    }
}

- (NSString *)combineFirstName:(NSString *)firstName AndLastName:(NSString *)lastName
{
    if (firstName.length > 0 && lastName.length > 0) {
        return [NSString stringWithFormat:@"%@ %@", firstName, lastName];
    } else if (firstName.length == 0 && lastName.length > 0) {
        return lastName;
    }
    return firstName;
}

# pragma mark - Button Actions

- (IBAction)friendsOnAppAction:(id)sender {
    self.selectedButton = @"friendsOnApp";
    [self resetSearchInformation];
    [sender setSelected:YES];
    [inviteButton setSelected:NO];
    [self hideButtonAtBottom];
    [selectedContacts removeAllObjects];
    [[self myTable] reloadData];
}

- (IBAction)invite:(id)sender {
    [self resetSearchInformation];
    self.selectedButton = @"inviteButton";
    [sender setSelected:YES];
    [friendsOnAppButton setSelected:NO]; 
    [[self myTable] reloadData];
}

- (IBAction)sendInvitationsAction:(id)sender {
    [self resetSearchInformation];
    NSLog(@"send invites to : %@", selectedContacts);
}


# pragma mark - Search Bar

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    searchText = [searchText lowercaseString];
    [self filterContentForSearchText:searchText scope:nil];
    [myTable reloadData];
    NSLog(@"%@", searchText);
    
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    if ([selectedButton isEqualToString:@"inviteButton"] && searchText.length > 0) {
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
        searchResults = [[allContacts filteredArrayUsingPredicate:resultPredicate] mutableCopy];
    } else {
        NSMutableArray *users = [User arrayOfUsersOnApp];
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@", searchText];
        [users filterUsingPredicate:resultPredicate];
        searchResults = [self createHashForUsers:users];
    }
    NSLog(@"searchresults: %@", searchResults);
}

- (NSMutableArray *)createHashForUsers:(NSMutableArray *)users {
    NSMutableArray *citiesArr = [[NSMutableArray alloc] init];
    NSMutableArray *usersArr = [[NSMutableArray alloc] init];
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    
    for (User *user in users) {
        [citiesArr addObject:user.city.cityName];
        [usersArr addObject:user.name];
    }
    
    NSMutableArray *noDuplicates = [[[NSSet setWithArray: citiesArr] allObjects] mutableCopy];
    
    for (NSString *name in noDuplicates) {
        NSArray *arrayOfUsers = [self filterUsers:users ByCity:name];
        NSDictionary *tmp = [[NSDictionary alloc] initWithObjectsAndKeys:name, @"city", arrayOfUsers, @"users", nil];
        [returnArray addObject:tmp];
    }
    return returnArray;
}

- (NSArray *) filterUsers:(NSMutableArray *)users ByCity:(NSString *)cityName{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"currentCity = %@", cityName];
    return [users filteredArrayUsingPredicate:resultPredicate];
}

- (void)resetSearchInformation {
    searchBar.text= @"";
    [searchResults removeAllObjects];
}

@end
