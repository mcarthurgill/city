//
//  SCContactsTableViewController.h
//  practice_scoop
//
//  Created by Joseph McArthur Gill on 11/21/13.
//  Copyright (c) 2013 Joseph McArthur Gill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>
//#import "MBProgressHUD.h"

@interface SCContactsTableViewController : UITableViewController <UISearchBarDelegate> //also add delegate , MBProgressHUDDelegate
{
//   MBProgressHUD* HUD;
   BOOL first;
}

@property (strong, nonatomic) id delegateView;

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (nonatomic) NSInteger contactCount;
@property (strong, nonatomic) NSMutableArray *contacts;
@property (strong, nonatomic) NSMutableDictionary *alphabet;
@property (strong, nonatomic) NSMutableArray *sortedKeys;

@property (strong, nonatomic) NSMutableDictionary* contactsArrayDict;
@property (strong, nonatomic) NSMutableDictionary* keysArrayDict;
@property (strong, nonatomic) NSMutableDictionary* selectedContacts;

@property (strong, nonatomic) NSString* cancelButtonText;
@property (strong, nonatomic) NSString* barTitleText;

- (IBAction)doneAction:(id)sender;

@end
