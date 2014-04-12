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

@synthesize friendsToChat;
@synthesize friendsInCity;

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
    
    BTSession *thisSession = [BTSession thisSession];
    friendsInCity = [[thisSession loggedInUser] friendsInCurrentCity];

    UITableView *table = [self createTable];
    [self addTableToView:table];
    
    UIButton *startChatButton = [self createChatButton];
    [self.view addSubview:startChatButton];
    
    friendsToChat = [[NSMutableArray alloc] init];
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
    return [friendsInCity count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellWithSwitch"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    [cell.textLabel setText:[[friendsInCity objectAtIndex:indexPath.row] name]];

    if ([friendsToChat containsObject:[friendsInCity objectAtIndex:indexPath.row]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone; 
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    User *friend = [friendsInCity objectAtIndex:indexPath.row];
    if ([friendsToChat containsObject:friend]) {
        [friendsToChat removeObject:friend];
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
    }else {
        [friendsToChat addObject:friend]; 
        [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
}

#pragma mark - Setup

- (void)changeNavBarTitle {
    BTSession *thisSession = [BTSession thisSession];
    self.tabBarController.navigationItem.title = [[thisSession loggedInUser] currentCity];
}

- (UITableView *)createTable {
    CGFloat navBarHeight = [self getNavBarHeight];
    CGFloat statusBarHeight = [self getStatusBarHeight];
    CGFloat buttonAndMargin = [self getButtonHeightAndMargin];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, navBarHeight + statusBarHeight, self.view.frame.size.width, self.view.frame.size.height-navBarHeight - self.tabBarController.tabBar.frame.size.height - statusBarHeight - buttonAndMargin) style:UITableViewStylePlain];
    table.dataSource = self;
    table.delegate = self;
    [table setTag:3];
    
    return table;
}

-(CGFloat)getNavBarHeight {
    UIView *navBar = [self.view viewWithTag:1];
    return navBar.frame.size.height;
}

-(CGFloat)getStatusBarHeight {
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}

-(CGFloat)getButtonHeightAndMargin {
    return 60;
}

-(void)addTableToView:(UITableView *)table {
    [self.view addSubview:table];
}

-(CGFloat)getTableHeight {
    UIView *view = [self.view viewWithTag:3];
    return view.frame.size.height;
}

-(UIButton *)createChatButton {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5, [self getStatusBarHeight] + [self getNavBarHeight] + [self getTableHeight] + 10, self.view.frame.size.width - 10, 55)];
    
    [button addTarget:self
                        action:@selector(startChat:)
              forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Start Chat" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    return button;
}



#pragma mark - Chat

-(void)startChat:(id)sender{
    NSLog(@"friendsToChat : %@", friendsToChat);
    
}

@end
