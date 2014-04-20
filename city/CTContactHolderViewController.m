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
@synthesize searchButton;
@synthesize addContactButton;
@synthesize addedMeButton;
@synthesize thisSession;
@synthesize allContacts;

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
    self.selectedButton = @"addContacts";

    allContacts = [[NSMutableArray alloc] init];
    selectedContacts = [[NSMutableArray alloc] init];
    [self prePermission];
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
        return allContacts.count;
    }else if ([[self selectedButton] isEqualToString:@"addedMe"]) {
        return allContacts.count;
    }
    return thisSession.friendsInCity.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"contactCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel* contact = (UILabel*) [cell.contentView viewWithTag:1];
    
    [self setCheckMarkImageForCell:cell AtIndexPath:indexPath];

    [contact setText:[[allContacts objectAtIndex:indexPath.row] valueForKey:@"name"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *contact = [allContacts objectAtIndex:indexPath.row];
    if (![selectedContacts containsObject:contact]) {
        [selectedContacts addObject:contact];
        [self setCheckMarkImageForCell:[tableView cellForRowAtIndexPath:indexPath] AtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *contact = [allContacts objectAtIndex:indexPath.row];
    if ([selectedContacts containsObject:contact]) {
        [selectedContacts removeObject:contact];
         [self setCheckMarkImageForCell:[tableView cellForRowAtIndexPath:indexPath] AtIndexPath:indexPath];
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

- (void) setCheckMarkImageForCell:(UITableViewCell *)cell AtIndexPath:(NSIndexPath *)indexPath {
    UIImageView* cellCheckmark = (UIImageView*) [cell.contentView viewWithTag:2];
    
    NSString *imageName = @"unchecked.png";
    if ([selectedContacts containsObject:[allContacts objectAtIndex:indexPath.row]]) {
        imageName = @"checked.png";
    }
    
    UIImage* image = [UIImage imageNamed:imageName];
    [cellCheckmark setImage:image];
}

# pragma mark - permissions

- (void)prePermission {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Find your friends" message:@"In order to find your friends who have City, we need permission to load your contacts" delegate:self cancelButtonTitle:@"Not now" otherButtonTitles:@"Show my friends", nil];
        
        [alert show];
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
        [self viewWillAppear:YES];
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
            
            if (phoneNumberCount > 0) {
                for (CFIndex j = 0; j < phoneNumberCount; j++) {
                    [numbersToText addObject:(__bridge NSString *)ABMultiValueCopyValueAtIndex(phoneNumbersPerPerson, j)];
                }
            }
            //dictionary has full name pointing to array of phone numbers
            NSDictionary *contactDict = [[NSDictionary alloc] initWithObjectsAndKeys:numbersToText, @"emails", fullName, @"name", nil];
            [allContacts addObject:contactDict];
        }
    }
}

- (NSString *)combineFirstName:(NSString *)firstName AndLastName:(NSString *)lastName
{
    return [NSString stringWithFormat:@"%@ %@", firstName, lastName];
}

@end
