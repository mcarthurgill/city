//
//  CTSecondViewController.m
//  city
//
//  Created by Joseph McArthur Gill on 4/15/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import "CTSecondViewController.h"

@interface CTSecondViewController ()

@end

@implementation CTSecondViewController

@synthesize tableview;
@synthesize thisSession;
@synthesize popover;

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
    tableview.delegate = self;
    tableview.dataSource = self;
    thisSession = [BTSession thisSession];
    [thisSession setupVenueData:[[thisSession loggedInUser] city]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupNavigationBar];
    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Navigation bar

- (void)setupNavigationBar {
    [self.tabBarController setTitle:[[thisSession loggedInUser] currentCity]];
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settings_icon.png"] style:UIBarButtonItemStylePlain target:self action:@selector(chooseCity:)];
    self.tabBarController.navigationItem.rightBarButtonItem = item;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [thisSession.venuesInMyCity count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *venueDict = [thisSession.venuesInMyCity objectAtIndex:section];
    NSMutableArray *venueArray = [[NSMutableArray alloc] init];
    if ([[venueDict allKeys] containsObject:@"Bars"]) {
        [venueArray addObject:[venueDict objectForKey:@"Bars"]];
    }else {
        [venueArray addObject:[venueDict objectForKey:@"Restaurants"]];
    }
    return [[venueArray firstObject] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[[thisSession.venuesInMyCity objectAtIndex:section] allKeys] firstObject];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    CGRect frame = tableView.frame;
//    NSLog(@"frame : %@", NSStringFromCGRect(frame));
//    NSLog(@"size : %@", NSStringFromCGSize(frame.size));
//    NSLog(@"height : %f", frame.size.height);
//    NSLog(@"width : %f", frame.size.width);
//    
//    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width-60, 0, 50, 15)];
//    addButton.titleLabel.text = @"type";
//    addButton.backgroundColor = [UIColor redColor];
//    [button addTarget:self action:@selector(insertParameter:) forControlEvents:UIControlEventTouchDown];

//
//    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 100, 30)];
//    title.text = [[[thisSession.venuesInMyCity objectAtIndex:section] allKeys] firstObject];
//    
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
//    [headerView addSubview:title];
//    [headerView addSubview:addButton];
//    headerView.backgroundColor = [UIColor lightGrayColor];
//    
//    return headerView;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
    }
    
    NSDictionary *dictionary = [thisSession.venuesInMyCity objectAtIndex:indexPath.section];
    NSMutableArray *venueArray = [[NSMutableArray alloc] init];
    if ([[dictionary allKeys] containsObject:@"Bars"]) {
        [venueArray addObject:[dictionary objectForKey:@"Bars"]];
    }else {
        [venueArray addObject:[dictionary objectForKey:@"Restaurants"]];
    }
    NSString *cellValue = [[[venueArray firstObject] objectAtIndex:indexPath.row] venueName];
    cell.textLabel.text = cellValue;
    
    return cell;
}

-(CGFloat)getNavBarHeight {
    UIView *navBar = [self.view viewWithTag:1];
    return navBar.frame.size.height;
}

-(CGFloat)getStatusBarHeight {
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}


#pragma mark - popover delegate
-(void)chooseCity:(id)sender {
    NSLog(@"second chooseCity booooooom");
    CTSecondPopoverTableViewController *controller = [[CTSecondPopoverTableViewController alloc] initWithStyle:UITableViewStylePlain];
    controller.delegate = self;
    
    popover = [[FPPopoverController alloc] initWithViewController:controller];
    
    UIBarButtonItem *buttonItem = sender;
    UIView* btnView = [buttonItem valueForKey:@"view"];
    //On these cases is better to specify the arrow direction
    [popover setArrowDirection:FPPopoverArrowDirectionUp];
    [popover presentPopoverFromView:btnView];
}

#pragma mark - FPPopover delegate method
-(void)chooseSelectedCity:(City *)city
{
    NSLog(@"second!");
    [self changeUserCurrentCity:city];
    
    //Dismiss the popover if it's showing.
    if (popover) {
        [popover dismissPopoverAnimated:YES];
        popover = nil;
    }
    NSLog(@"reload That shit. ");
    [tableview reloadData];
}


-(void)changeUserCurrentCity:(City *)city {
    [[thisSession loggedInUser] setCity:city];
    thisSession.friendsInCity = [[thisSession loggedInUser] friendsInMyCurrentCity];
    [thisSession.friendsToChat removeAllObjects];
    [thisSession setupVenueData:city];
    [self setupNavigationBar];
}

@end
