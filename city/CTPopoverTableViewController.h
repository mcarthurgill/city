//
//  CTPopoverTableViewController.h
//  city
//
//  Created by Joseph McArthur Gill on 4/13/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTFirstViewController.h"
#import "City.h"

@class CTFirstViewController;

@interface CTPopoverTableViewController : UITableViewController

@property (nonatomic,assign) CTFirstViewController *delegate;
@property (nonatomic,strong) NSMutableArray *cities;

@end
