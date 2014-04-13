//
//  CTCityPickerTableViewController.h
//  city
//
//  Created by Joseph McArthur Gill on 4/12/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@protocol CityPickerDelegate <NSObject>
@required
-(void)selectedCity:(City *)city;
@end


@interface CTCityPickerTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *cities;
@property (nonatomic, weak) id<CityPickerDelegate> delegate;

@end
