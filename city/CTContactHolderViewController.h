//
//  CTContactHolderViewController.h
//  city
//
//  Created by Joseph McArthur Gill on 2/13/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "BTSession.h"
#import "CTAppDelegate.h"

@interface CTContactHolderViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, UISearchBarDelegate>
@property (strong, nonatomic) IBOutlet UIButton *friendsOnAppButton;
@property (strong, nonatomic) IBOutlet UIButton *inviteButton;
@property (strong, nonatomic) IBOutlet UIButton *sendInvitationsButton;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSMutableArray *searchResults;
@property (strong, nonatomic) NSMutableDictionary *contactsByLetter;

- (IBAction)friendsOnAppAction:(id)sender;
- (IBAction)invite:(id)sender;
- (IBAction)sendInvitationsAction:(id)sender;

@property (strong, nonatomic) NSMutableArray *allContacts;
@property (strong, nonatomic) NSMutableArray *friendsOnApp;
@property (strong, nonatomic) NSMutableArray* selectedContacts;
@property (strong, nonatomic) NSString *selectedButton;
@property (strong, nonatomic) IBOutlet UIView *buttonView;

@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property (strong, nonatomic) BTSession *thisSession;

@end
