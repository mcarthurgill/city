//
//  CTFirstViewController.h
//  city
//
//  Created by Joseph McArthur Gill on 4/11/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
#import "User.h"
#import "FPPopoverController.h"
#import "ARCMacros.h"
#import "CTPopoverTableViewController.h"
#import "BTSession.h"

@interface CTFirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, FPPopoverControllerDelegate>

@property (strong, nonatomic) NSMutableArray *friendsToChat;
@property (strong, nonatomic) NSMutableArray *friendsInCity;
@property (strong, nonatomic) UITableView *table;
@property (strong, nonatomic) FPPopoverController *popover;
@property (strong, nonatomic) BTSession *thisSession;

-(IBAction)chooseCityButtonTapped:(id)sender;
-(void)chooseSelectedCity:(City *)city;

@end
