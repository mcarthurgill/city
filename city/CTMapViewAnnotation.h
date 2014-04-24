//
//  CTMapViewAnnotation.h
//  city
//
//  Created by Joseph McArthur Gill on 4/24/14.
//  Copyright (c) 2014 Joseph McArthur Gill. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"

@interface CTMapViewAnnotation : NSObject <MKAnnotation>

@property (nonatomic,copy) NSString *title;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

-(id) initWithTitle:(NSString *)title AndCoordinate:(CLLocationCoordinate2D)coordinate;

@end