//
//  CrimePlace.m
//  Crime Place
//
//  Created by Samip shah on 6/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import "CrimePlace.h"

@implementation CrimePlace

/** @parameter description      Used for displaying the Marker Detail */
- (NSString *)description {
    return [NSString stringWithFormat:@"CATEGORY: %@ \nId: %@ \n%@",_category,[_placeId stringValue],_location.description];
}

@end
