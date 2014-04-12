//
//  City.h
//  city
//
//  Created by Joseph McArthur Gill on 4/8/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface City : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * cityName;
@property (nonatomic, retain) NSSet *users;
@end

@interface City (CoreDataGeneratedAccessors)

- (void)addUsersObject:(User *)value;
- (void)removeUsersObject:(User *)value;
- (void)addUsers:(NSSet *)values;
- (void)removeUsers:(NSSet *)values;
+ (NSMutableArray *)allCities;

@end
