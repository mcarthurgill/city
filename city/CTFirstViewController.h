//
//  CTFirstViewController.h
//  city
//
//  Created by Joseph McArthur Gill on 4/15/14.
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

@interface CTFirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, FPPopoverControllerDelegate, MFMessageComposeViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) FPPopoverController *popover;
@property (strong, nonatomic) BTSession *thisSession;
@property (strong, nonatomic) IBOutlet UIButton *startChatButton;
@property (strong, nonatomic) IBOutlet UIView *buttonView;

-(IBAction)chooseCityButtonTapped:(id)sender;
-(void)chooseSelectedCity:(City *)city;
- (IBAction)startChat:(id)sender;

@end
