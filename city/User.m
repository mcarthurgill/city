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
@dynamic notificationsOn; 
@dynamic city;
@dynamic city_id;

-(NSString *)currentCity{
    return [[self city] cityName];
}

-(NSMutableArray *)friendsOnApp
{
    NSMutableArray *arrayOfDicts = [[NSMutableArray alloc] init];
    NSMutableArray *cities = [City allCities];
    
    NSArray *keysArray = [[NSArray alloc] initWithObjects:@"city", @"users", nil];
    for (City *city in cities) {
        NSMutableArray *usersIncludingSelf = [[city.users allObjects] mutableCopy];
        if ([usersIncludingSelf containsObject:self]) {
            [usersIncludingSelf removeObject:self];
        }
        NSArray *objectsArray = [[NSArray alloc] initWithObjects:city.cityName, usersIncludingSelf, nil];
        NSDictionary *temp = [[NSDictionary alloc] initWithObjects:objectsArray forKeys:keysArray];
        [arrayOfDicts addObject:temp];
    }
    return arrayOfDicts;
}

-(NSMutableArray *)friendsInMyCurrentCity {
    NSMutableArray *array = [[[self.city users] allObjects] mutableCopy];
    [array removeObject:self];
    return array;
}

-(NSMutableArray *)arrayOfUsersOnApp {
    CTAppDelegate *appDelegate = (CTAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"User" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    return [[context executeFetchRequest:fetchRequest error:&error] mutableCopy];
}

@end
