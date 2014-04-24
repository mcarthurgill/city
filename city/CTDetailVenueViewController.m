//
//  CTDetailVenueViewController.m
//  city
//
//  Created by Joseph McArthur Gill on 4/24/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import "CTDetailVenueViewController.h"

@interface CTDetailVenueViewController ()

@end

@implementation CTDetailVenueViewController

@synthesize venue;

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
    UILabel *label = (UILabel*)[self.view viewWithTag:1];
    label.text = [venue valueForKey:@"name"]; 
    NSLog(@"venue: %@", self.venue);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
