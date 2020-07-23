//
//  Location.m
//  Crime Place
//
//  Created by Samip shah on 6/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import "Location.h"

@implementation Location

/** @parameter description      Used for displaying the Marker Detail */
-(NSString *)description{
    return [NSString stringWithFormat:@"Latitude: %f \nLongitude: %f \n%@",_latitude,_longitude,_street];
}

@end
