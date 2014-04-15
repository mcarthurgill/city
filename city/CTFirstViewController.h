//
//  CTFirstViewController.h
//  city
//
<<<<<<< HEAD
//  Created by Joseph McArthur Gill on 4/15/14.
=======
//  Created by Joseph McArthur Gill on 4/11/14.
>>>>>>> 0819c9c8b92a14a4092897ffb410822a947979f3
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"
#import "User.h"
#import "FPPopoverController.h"
#import "ARCMacros.h"
#import "CTPopoverTableViewController.h"
#import "BTSession.h"
#import <MessageUI/MessageUI.h>

<<<<<<< HEAD
@interface CTFirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, FPPopoverControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) FPPopoverController *popover;
@property (strong, nonatomic) BTSession *thisSession;
@property (strong, nonatomic) IBOutlet UIButton *startChatButton;
@property (strong, nonatomic) IBOutlet UIView *buttonView;

-(IBAction)chooseCityButtonTapped:(id)sender;
-(void)chooseSelectedCity:(City *)city;
- (IBAction)startChat:(id)sender;
=======
@interface CTFirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, FPPopoverControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *friendsToChat;
@property (strong, nonatomic) NSMutableArray *friendsInCity;
@property (strong, nonatomic) UITableView *table;
@property (strong, nonatomic) FPPopoverController *popover;
@property (strong, nonatomic) BTSession *thisSession;

-(IBAction)chooseCityButtonTapped:(id)sender;
-(void)chooseSelectedCity:(City *)city;
>>>>>>> 0819c9c8b92a14a4092897ffb410822a947979f3

@end
