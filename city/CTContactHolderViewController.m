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
@synthesize contactsByLetter;

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
    
    [self setupContactsByLetter];
    
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

- (void) setupContactsByLetter {
    contactsByLetter = [[NSMutableDictionary alloc] init];
    NSArray *alphaLetters = [[NSArray alloc] initWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", @"ZZ_OTHER", nil];
    
    for (int i = 0; i < 27; i++) {
        NSMutableArray *empty = [[NSMutableArray alloc] init];
        [contactsByLetter setValue:empty forKey:[alphaLetters objectAtIndex:i]];
    }
}

- (BOOL) searchActivated {
    return (searchResults.count > 0 || searchBar.text.length > 0);
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
    if ([selectedButton isEqualToString:@"inviteButton"]) {
        if ([self searchActivated]) {
            return 1;
        }
        return contactsByLetter.count;
    }
    if ([selectedButton isEqualToString:@"friendsOnApp"] && [self searchActivated]) {
        return searchResults.count;
    }
    return friendsOnApp.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[self selectedButton] isEqualToString:@"inviteButton"]) {
        if ([self searchActivated]) {
            return searchResults.count;
        }
        return [[contactsByLetter objectForKey:[[self getAlphabet] objectAtIndex:section]] count];
    }else {
        if ([self searchActivated]) {
            return [[[searchResults objectAtIndex:section] valueForKey:@"users"] count];
        }
    }
    return [[[friendsOnApp objectAtIndex:section] valueForKey:@"users"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"contactCell";
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    if ([selectedButton isEqualToString:@"friendsOnApp"]) {
        CellIdentifier = @"friendCell";
    }

    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    
    UILabel* contact = (UILabel*) [cell.contentView viewWithTag:1];
    

    if ([selectedButton isEqualToString:@"inviteButton"]) {
        if ([self searchActivated]) {
            NSLog(@"search results count > 0");
            [contact setText:[[searchResults objectAtIndex:indexPath.row] valueForKey:@"name"]];
        } else {
            [contact setText:[[[contactsByLetter objectForKey:[[self getAlphabet] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row] valueForKey:@"name"]];
        }
        [self setCheckMarkImageForCell:cell AtIndexPath:indexPath];
    } else if ([selectedButton isEqualToString:@"friendsOnApp"]) {
        if ([self searchActivated]) {
            [contact setText:[[[[searchResults objectAtIndex:indexPath.section] valueForKey:@"users"] objectAtIndex:indexPath.row] name]];
        }else {
            [contact setText:[[[[friendsOnApp objectAtIndex:indexPath.section] valueForKey:@"users"] objectAtIndex:indexPath.row] name]];
        }
    }
    return cell;
}
         
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
     if ([self searchActivated]) {
         return @"Friends";
     }
     if ([[self selectedButton] isEqualToString:@"friendsOnApp"]) {
         return [[friendsOnApp objectAtIndex:section] valueForKey:@"city"];
     }
    return [[self getAlphabet] objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *contact = [[contactsByLetter objectForKey:[[self getAlphabet] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    if ([self searchActivated]) {
        contact = [searchResults objectAtIndex:indexPath.row];
    }
    if ([selectedButton isEqualToString:@"inviteButton"]) {
        if (![selectedContacts containsObject:contact]) {
            [selectedContacts addObject:contact];
            [self shouldShowButtonView];
            [self setCheckMarkImageForCell:[tableView cellForRowAtIndexPath:indexPath] AtIndexPath:indexPath];
        }
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *contact = [[contactsByLetter objectForKey:[[self getAlphabet] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    if ([self searchActivated]) {
        contact = [searchResults objectAtIndex:indexPath.row];
    }
    if ([selectedContacts containsObject:contact]) {
        [selectedContacts removeObject:contact];
        [self setCheckMarkImageForCell:[tableView cellForRowAtIndexPath:indexPath] AtIndexPath:indexPath];
        if (selectedContacts.count == 0) {
            [self hideButtonAtBottom];
        }
    }
}

- (void) setCheckMarkImageForCell:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath {
    if ([[self selectedButton] isEqualToString:@"inviteButton"]) {
        UIImageView* cellCheckmark = (UIImageView*) [cell.contentView viewWithTag:2];
        
        NSString *imageName = @"unchecked.png";
        if ([self searchActivated] && [selectedContacts containsObject:[searchResults objectAtIndex:indexPath.row]]) {
            imageName = @"checked.png";
        } else if (contactsByLetter.count > 0 && [selectedContacts containsObject:[[contactsByLetter objectForKey:[[self getAlphabet] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row]]) {
            imageName = @"checked.png";
        }
        
        UIImage* image = [UIImage imageNamed:imageName];
        [cellCheckmark setImage:image];
    }
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (![self searchActivated]) {
        myTable.sectionIndexBackgroundColor = [UIColor clearColor];
        return [self getAlphabet];
    }
    return [[NSArray alloc] init]; 
}

- (NSArray *)getAlphabet {
    NSArray *keysForNullValues = [contactsByLetter allKeysForObject:[[NSMutableArray alloc] init]];
    [contactsByLetter removeObjectsForKeys:keysForNullValues];
    return [[contactsByLetter allKeys] sortedArrayUsingSelector:@selector(compare:)];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString
                                                                             *)title atIndex:(NSInteger)index {
    if (index == 0) {
        [tableView setContentOffset:CGPointMake(0.0, -tableView.contentInset.top)];
        return NSNotFound;
    }
    return index;
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
                NSString *firstLetter = [self determineFirstLetterOfName:fullName];
                [allContacts addObject:contactDict];
                [[contactsByLetter valueForKey:firstLetter] addObject:contactDict];
            }
        }
    }
}

- (NSString *)determineFirstLetterOfName:(NSString *)fullName {
    if (fullName.length > 0) {
        return [[fullName substringToIndex:1] uppercaseString];
    } else {
        return @"ZZ_OTHER";
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
    if ([selectedButton isEqualToString:@"inviteButton"] && [self searchActivated]) {
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
        searchResults = [[allContacts filteredArrayUsingPredicate:resultPredicate] mutableCopy];
    } else if ([selectedButton isEqualToString:@"friendsOnApp"]) {
        NSMutableArray *users = [User arrayOfUsersOnApp];
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@", searchText];
        [users filterUsingPredicate:resultPredicate];
        searchResults = [self createHashForUsers:users];
    } else {
        [self resetSearchInformation];
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
    [myTable reloadData];
}

@end
