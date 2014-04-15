//
//  VenueType.h
//  city
//
//  Created by Joseph McArthur Gill on 4/14/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface VenueType : NSManagedObject

@property (nonatomic, retain) NSString * typeName;
@property (nonatomic, retain) NSSet *venues;

@end
