//
//  CTSecondViewController.m
//  city
//
//  Created by Joseph McArthur Gill on 2/11/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import "CTSecondViewController.h"

@interface CTSecondViewController ()

@end

@implementation CTSecondViewController

@synthesize currentCity;
@synthesize cities;
@synthesize cityPicker;

@synthesize currentVenue;
@synthesize venues;
@synthesize venuePicker;

@synthesize currentType;

@synthesize barType;
@synthesize barTypePicker;

@synthesize restaurantType;
@synthesize restaurantTypePicker;


- (void)viewDidLoad
{
    [super viewDidLoad];
	[self setupPickers];
}

- (void)setupPickers
{
    [self setupCityPicker];
    [self setupVenuePicker];
    [self setupBarTypePicker];
    [self setupRestaurantTypePicker];
}

- (void) setupCityPicker
{
    cityPicker.delegate = self;
    cityPicker.dataSource = self;
    [cityPicker setHidden:YES];
    cities = [NSArray arrayWithObjects:@"Montgomery", @"Cincinnati", @"Birmingham", @"San Francisco", nil];
}

- (void) setupVenuePicker
{
    venuePicker.delegate = self;
    venuePicker.dataSource = self;
    [venuePicker setHidden:YES];
    venues = [NSArray arrayWithObjects:@"Barz", @"Restaurants", nil];
}


- (void) setupBarTypePicker
{
    barTypePicker.delegate = self;
    barTypePicker.dataSource = self;
    [barTypePicker setHidden:YES];
    barType = [NSArray arrayWithObjects:@"Dive", @"Loud", @"Quiet", @"Dance", @"Lounge", @"Club", @"Post-grad", @"College", nil];
}

- (void) setupRestaurantTypePicker {
    restaurantTypePicker.delegate = self;
    restaurantTypePicker.dataSource = self;
    [restaurantTypePicker setHidden:YES];
     restaurantType = [NSArray arrayWithObjects:@"American", @"Mexican", @"Indian", @"Asian", @"Italian", nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:
(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView.tag == 1) {
        return cities.count;
    } else if (pickerView.tag == 2){
        return venues.count;
    } else if (pickerView.tag == 3) {
        return barType.count;
    }
    return restaurantType.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    if (pickerView.tag == 1) {
        return cities[row];
    } else if (pickerView.tag == 2) {
        return venues[row];
    } else if (pickerView.tag == 3) {
        return barType[row];
    }
    return restaurantType[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    [pickerView setHidden:YES];
    if (pickerView.tag == 1) {
        currentCity.text = cities[row];
    } else if (pickerView.tag == 2) {
        currentVenue.text = venues[row];
        [self checkForChosenType];
    } else if (pickerView.tag == 3) {
        currentType.text = barType[row];
    }else {
        currentType.text = restaurantType[row];
    }
}

- (void)checkForChosenType {
    NSLog(@"outside");
    if ([currentVenue.text isEqualToString:@"Barz"] && ![barType containsObject:currentType.text]) {
        [self removeBarTypeLabel];
    } else if ([currentVenue.text isEqualToString:@"Restaurants"] && ![restaurantType containsObject:currentType.text]) {
        [self removeBarTypeLabel];
    }
}

- (void)removeBarTypeLabel {
    [self.currentType setText:@"Type"];
}


- (IBAction)chooseVenueButton:(id)sender {
    [self setAllPickersToHidden];
    [self.venuePicker setHidden:NO];
    [self.tabBarController.view addSubview:self.venuePicker];
    [self.venuePicker setFrame:CGRectMake(0, self.tabBarController.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - self.venuePicker.frame.size.height, self.venuePicker.bounds.size.width, venuePicker.bounds.size.height)];

}

- (IBAction)chooseCityButton:(id)sender {
    [self setAllPickersToHidden];
    [self.cityPicker setHidden:NO];
    [self.tabBarController.view addSubview:self.cityPicker];
    [self.cityPicker setFrame:CGRectMake(0, self.tabBarController.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - self.cityPicker.frame.size.height, self.cityPicker.bounds.size.width, cityPicker.bounds.size.height)];
}

- (IBAction)chooseTypeButton:(id)sender {
    [self setAllPickersToHidden];

    if ([currentVenue.text isEqualToString:@"Barz"]) {
        [self.barTypePicker setHidden:NO];
        [self.tabBarController.view addSubview:self.barTypePicker];
        [self.barTypePicker setFrame:CGRectMake(0, self.tabBarController.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - self.barTypePicker.frame.size.height, self.barTypePicker.bounds.size.width, barTypePicker.bounds.size.height)];
    } else {
        [self.restaurantTypePicker setHidden:NO];
        [self.tabBarController.view addSubview:self.restaurantTypePicker];
        [self.restaurantTypePicker setFrame:CGRectMake(0, self.tabBarController.view.frame.size.height - self.tabBarController.tabBar.frame.size.height - self.restaurantTypePicker.frame.size.height, self.restaurantTypePicker.bounds.size.width, restaurantTypePicker.bounds.size.height)];

    }
}

- (void) setAllPickersToHidden {
    [self.barTypePicker setHidden:YES];
    [self.restaurantTypePicker setHidden:YES];
    [self.venuePicker setHidden:YES];
    [self.cityPicker setHidden:YES];
}
@end
