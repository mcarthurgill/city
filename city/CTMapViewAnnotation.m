//
//  CTMapViewAnnotation.m
//  city
//
//  Created by Joseph McArthur Gill on 4/24/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import "CTMapViewAnnotation.h"

@implementation CTMapViewAnnotation

@synthesize coordinate=_coordinate;
@synthesize title=_title;

-(id) initWithTitle:(NSString *) title AndCoordinate:(CLLocationCoordinate2D)coordinate
{
    self = [super init];
    _title = title;
    _coordinate = coordinate;
    return self;
}

@end
