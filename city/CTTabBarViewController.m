//
//  CTTabBarViewController.m
//  city
//
//  Created by Joseph McArthur Gill on 2/12/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import "CTTabBarViewController.h"

@interface CTTabBarViewController ()

@end

@implementation CTTabBarViewController

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
    [self setSelectedViewController:[self.viewControllers objectAtIndex:0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
