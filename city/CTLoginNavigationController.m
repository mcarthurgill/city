//
//  CTLoginNavigationController.m
//  city
//
//  Created by Joseph McArthur Gill on 4/7/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import "CTLoginNavigationController.h"
#import "CTLoginViewController.h"
#import "CTTabBarViewController.h"
#import "BTSession.h"

@interface CTLoginNavigationController ()

@end

@implementation CTLoginNavigationController

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
    // Do any additional setup after loading the view.
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    BTSession *thisSession = [BTSession thisSession];
    
    if (![thisSession isLoggedIn]) {
        CTLoginViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [self pushViewController:vc animated:YES];
    } else {
        CTTabBarViewController *tbvc = [storyboard instantiateViewControllerWithIdentifier:@"tabBarController"];
        [self pushViewController:tbvc animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
