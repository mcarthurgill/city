//
//  CTFirstViewController.m
//  city
//
//  Created by Joseph McArthur Gill on 4/11/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import "CTFirstViewController.h"
#import "BTSession.h"

@interface CTFirstViewController ()

@end

@implementation CTFirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self changeNavBarTitle];
    UIView *navBar = [self.view viewWithTag:1];
    CGFloat statusBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, navBar.frame.size.height + statusBarHeight, self.view.frame.size.width, self.view.frame.size.height-navBar.frame.size.height - self.tabBarController.tabBar.frame.size.height - statusBarHeight) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    [self.view addSubview:table];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [cell setTag:[indexPath row]*-1];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    [[cell textLabel] setText:@"mcarthur"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Misc

- (void)changeNavBarTitle {
    BTSession *thisSession = [BTSession thisSession];
    self.tabBarController.navigationItem.title = [[thisSession loggedInUser] currentCity];
}

#pragma mark - Chat

-(void)startChat:(id)sender{
    NSLog(@"button pressed: %@", sender);
    
}



@end
