//
//  Venue.h
//  city
//
//  Created by Joseph McArthur Gill on 4/14/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class City, VenueType;

@interface Venue : NSManagedObject

@property (nonatomic, retain) NSNumber * city_id;
@property (nonatomic, retain) NSString * venueName;
@property (nonatomic, retain) City *city;
@property (nonatomic, retain) VenueType *venueType;

@end
