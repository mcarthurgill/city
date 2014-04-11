//
//  CTFirstTableViewController.m
//  city
//
//  Created by Joseph McArthur Gill on 4/8/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import "CTFirstTableViewController.h"
#import "BTSession.h"

@interface CTFirstTableViewController ()

@end

@implementation CTFirstTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changeNavBarTitle];
    
    CGRect frame = self.tableView.frame;
    frame.size.height = 355;
    self.tableView.frame = frame;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(startChat:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Start Chat" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    button.frame = CGRectMake(0, 365, 280, 40);
    self.tableView.tableFooterView = button;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

#pragma mark - Misc

- (void)changeNavBarTitle {
    BTSession *thisSession = [BTSession thisSession];
    self.tabBarController.navigationItem.title = [[thisSession loggedInUser] currentCity];
}

#pragma mark - Chat

-(void)startChat:(id)sender{
    NSLog(@"button pressed");
    
}


@end
