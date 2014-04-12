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

@interface CTFirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *friendsToChat;
@property (strong, nonatomic) NSMutableArray *friendsInCity;

@end
