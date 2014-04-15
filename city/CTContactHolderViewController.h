//
//  CTContactHolderViewController.h
//  city
//
//  Created by Joseph McArthur Gill on 2/13/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTContactHolderViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

- (IBAction)addContact:(id)sender;
- (IBAction)addedMe:(id)sender;
- (IBAction)searchButton:(id)sender;

@property (strong, nonatomic) NSMutableDictionary* selectedContacts;
@property (strong, nonatomic) NSString *selectedButton;
@property (strong, nonatomic) IBOutlet UITableView *myTable;

@end
