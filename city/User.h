//
//  User.h
//  city
//
//  Created by Joseph McArthur Gill on 4/8/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "City.h"


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * city_id;
@property (nonatomic, assign) BOOL * notificationsOn;
@property (nonatomic, retain) City *city;

-(NSString *)currentCity;

-(NSMutableArray *)friendsOnApp;
+(NSMutableArray *)arrayOfUsersOnApp;
-(NSMutableArray *)friendsInMyCurrentCity; 

@end
