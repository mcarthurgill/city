//
//  User.m
//  city
//
//  Created by Joseph McArthur Gill on 4/8/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import "User.h"
#import "CTAppDelegate.h"


@implementation User

@dynamic phone;
@dynamic name;
@dynamic city;
@dynamic city_id;

-(NSString *)currentCity{
    return [[self city] cityName];
}

-(NSMutableArray *)friendsInCurrentCity
{
    NSMutableArray *array = [[[self.city users] allObjects] mutableCopy];
    [array removeObject:self];
<<<<<<< HEAD
    [array addObjectsFromArray:array];
    [array addObjectsFromArray:array];
    [array addObjectsFromArray:array];
=======
>>>>>>> 0819c9c8b92a14a4092897ffb410822a947979f3
    return array; 
}

@end
