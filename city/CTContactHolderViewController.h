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

@interface CTContactHolderViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UIButton *addContactButton;
@property (strong, nonatomic) IBOutlet UIButton *addedMeButton;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;

- (IBAction)addContact:(id)sender;
- (IBAction)addedMe:(id)sender;
- (IBAction)search:(id)sender;

@property (strong, nonatomic) NSMutableArray *allContacts; 
@property (strong, nonatomic) NSMutableArray* selectedContacts;
@property (strong, nonatomic) NSString *selectedButton;
@property (strong, nonatomic) IBOutlet UITableView *myTable;
@property (strong, nonatomic) BTSession *thisSession;


@end
