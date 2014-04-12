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

@dynamic email;
@dynamic name;
@dynamic city;
@dynamic city_id;

-(NSString *)currentCity{
    return [[self city] cityName];
}

-(NSMutableArray *)friendsInCurrentCity
{
    NSMutableArray *array = [[[self.city users] allObjects] mutableCopy];
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];

    for (User *user in array) {
        if (user.name != nil) {
            [returnArray addObject:user];
        }
    }

    return returnArray;
}

@end
