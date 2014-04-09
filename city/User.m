//
//  User.m
//  city
//
//  Created by Joseph McArthur Gill on 4/8/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import "User.h"


@implementation User

@dynamic email;
@dynamic name;
@dynamic city;
@dynamic city_id;

-(NSString *)currentCity{
    return [[self city] cityName];
}

@end
