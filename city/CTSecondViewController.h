//
//  CTSecondViewController.h
//  city
//
//  Created by Joseph McArthur Gill on 2/11/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTSecondViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) IBOutlet UIPickerView *cityPicker;
@property (strong, nonatomic) IBOutlet UILabel *currentCity;
- (IBAction)chooseCityButton:(id)sender;
@property (strong, nonatomic) NSArray *cities;

@property (strong, nonatomic) NSArray *venues;
@property (strong, nonatomic) IBOutlet UIPickerView *venuePicker;
- (IBAction)chooseVenueButton:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *currentVenue;


@property (strong, nonatomic) IBOutlet UILabel *currentType;
- (IBAction)chooseTypeButton:(id)sender;

@property (strong, nonatomic) NSArray *barType;
@property (strong, nonatomic) IBOutlet UIPickerView *barTypePicker;

@property (strong, nonatomic) IBOutlet UIPickerView *restaurantTypePicker;
@property (strong, nonatomic) NSArray *restaurantType;
@end
