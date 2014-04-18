//
//  CTFirstViewController.m
//  city
//
//  Created by Joseph McArthur Gill on 4/15/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import "CTFirstViewController.h"
#import "CTAppDelegate.h"
#import "CTSecondViewController.h"

@interface CTFirstViewController ()

@end

@implementation CTFirstViewController

@synthesize tableview;
@synthesize popover;
@synthesize thisSession;
@synthesize startChatButton;
@synthesize buttonView;

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
    tableview.delegate = self;
    tableview.dataSource = self;
    thisSession = [BTSession thisSession];
    thisSession.friendsInCity = [[thisSession loggedInUser] friendsInCurrentCity];
    thisSession.friendsToChat = [[NSMutableArray alloc] init];
    [buttonView addSubview:startChatButton];
    CTAppDelegate* appDelegate = (CTAppDelegate*)[[UIApplication sharedApplication] delegate];
    [appDelegate.window addSubview:buttonView];
    [buttonView setHidden:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupNavigationBar];
    [self shouldShowButtonView];
    [self.tableview reloadData]; 
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self hideButtonAtBottom];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Navigation bar

- (void)setupNavigationBar {
    [self.tabBarController setTitle:[[thisSession loggedInUser] currentCity]];
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(chooseCityButtonTapped:)];
    self.tabBarController.navigationItem.rightBarButtonItem = item;
}

// button view

- (void) shouldShowButtonView
{
    if (thisSession.friendsToChat.count > 0 && [buttonView isHidden]) {
        [self showButtonAtBottom];
    } else {
        [self shouldHideButtonView];
    }
}

- (void) shouldHideButtonView
{
    if (thisSession.friendsToChat.count == 0 && ![buttonView isHidden]) {
        [self hideButtonAtBottom];
    }
}

- (void) showButtonAtBottom
{
    [buttonView setHidden:NO];
    [self.tableview setContentInset:UIEdgeInsetsMake(self.tableview.contentInset.top, 0, self.navigationController.toolbar.frame.size.height + buttonView.frame.size.height, 0)];
    [self.tableview scrollToRowAtIndexPath:self.tableview.indexPathsForSelectedRows.lastObject atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void) hideButtonAtBottom
{
    [buttonView setHidden:YES];
    [self.tableview setContentInset:UIEdgeInsetsMake(self.tableview.contentInset.top, 0, self.navigationController.toolbar.frame.size.height, 0)];
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
    return [thisSession.friendsInCity count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    [cell.textLabel setText:[[thisSession.friendsInCity objectAtIndex:indexPath.row] name]];
    
    if ([thisSession.friendsToChat containsObject:[thisSession.friendsInCity objectAtIndex:indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    User *friend = [thisSession.friendsInCity objectAtIndex:indexPath.row];
    if ([thisSession.friendsToChat containsObject:friend]) {
        [thisSession.friendsToChat removeObject:friend];
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
    }else {
        [thisSession.friendsToChat addObject:friend];
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    [self shouldShowButtonView];
}

- (void)chooseCityButtonTapped:(id)sender {
    NSLog(@"chooseCity tapped");
    CTPopoverTableViewController *controller = [[CTPopoverTableViewController alloc] initWithStyle:UITableViewStylePlain];
    controller.delegate = self;
    
    popover = [[FPPopoverController alloc] initWithViewController:controller];
    
    UIBarButtonItem *buttonItem = sender;
    UIView* btnView = [buttonItem valueForKey:@"view"];
    //On these cases is better to specify the arrow direction
    [popover setArrowDirection:FPPopoverArrowDirectionUp];
    [popover presentPopoverFromView:btnView];
}

#pragma mark - FPPopover delegate method
-(void)chooseSelectedCity:(City *)city
{
    NSLog(@"selectedCity!");
    [self changeUserCurrentCity:city];
    
    //Dismiss the popover if it's showing.
    if (popover) {
        [popover dismissPopoverAnimated:YES];
        popover = nil;
    }
    [tableview reloadData];
}


-(void)changeUserCurrentCity:(City *)city {
    [[thisSession loggedInUser] setCity:city];
    thisSession.friendsInCity = [[thisSession loggedInUser] friendsInCurrentCity];
    [thisSession.friendsToChat removeAllObjects];
    [thisSession setupVenueData:city];
    [self setupNavigationBar];
}


#pragma mark - Chat

- (IBAction)startChat:(id)sender {
    NSLog(@"friendsToChat : %@", thisSession.friendsToChat);
    NSMutableArray *numbers = [[NSMutableArray alloc] init];
    for (User *user in thisSession.friendsToChat) {
        [numbers addObject:user.phone];
    }
    [self showSMS:[numbers copy]];
}

#pragma mark - Message Delegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send your message!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showSMS:(NSArray *)friendsNumbers {
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device doesn't support SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    User *currentUser = [thisSession loggedInUser];
    NSString *message = [NSString stringWithFormat:@"Hey I'm in %@! We should hang.", [[currentUser city] cityName]];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:friendsNumbers];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [self presentViewController:messageController animated:YES completion:nil];
}

@end
