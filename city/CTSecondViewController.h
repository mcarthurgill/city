//
//  CTSecondViewController.h
//  city
//
//  Created by Joseph McArthur Gill on 4/15/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTSession.h"
#import "User.h"
#import "City.h"
#import "VenueType.h"
#import "Venue.h"
#import "FPPopoverController.h"
#import "CTAppDelegate.h"
#import "CTSecondPopoverTableViewController.h"

@interface CTSecondViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, FPPopoverControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) BTSession *thisSession;
@property (strong, nonatomic) FPPopoverController *popover;

-(IBAction)chooseSelectedCity:(City *)city;

@end
