//
//  CTSecondTableViewController.h
//  city
//
//  Created by Joseph McArthur Gill on 4/14/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTSession.h"
#import "User.h"
#import "City.h"
#import "VenueType.h"
#import "Venue.h"
#import "CTAppDelegate.h"

@interface CTSecondTableViewController : UITableViewController

@property (strong, nonatomic) BTSession *thisSession;
@property (strong, nonatomic) NSMutableArray *venues;
@property (strong, nonatomic) NSArray *dataArray; 
@end
