//
//  City.m
//  city
//
//  Created by Joseph McArthur Gill on 4/8/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import "City.h"
#import "User.h"
#import "CTAppDelegate.h"


@implementation City

@dynamic latitude;
@dynamic longitude;
@dynamic cityName;
@dynamic users;

+ (NSMutableArray *)allUsers {
    
    CTAppDelegate *appDelegate = (CTAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSError *error;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"City" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *cities = [[NSMutableArray alloc] init];
    for (NSManagedObject *city in fetchedObjects) {
        [cities addObject:city];
    }
    return cities;
}

@end
