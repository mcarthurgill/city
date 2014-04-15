//
//  CTSecondPopoverTableViewController.h
//  city
//
//  Created by Joseph McArthur Gill on 4/13/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTSecondViewController.h"
#import "City.h"

@class CTSecondViewController;

@interface CTSecondPopoverTableViewController : UITableViewController

@property (nonatomic,assign) CTSecondViewController *delegate;
@property (nonatomic,strong) NSMutableArray *cities;

@end
