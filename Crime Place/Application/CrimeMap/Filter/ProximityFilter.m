//
//  ProximityFilter.m
//  Crime Place
//
//  Created by Samip shah on 9/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import "ProximityFilter.h"
#import "CrimePlace.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation ProximityFilter

/** Returns the first 5 element sortedArray of closest distant place if the places count is greater than equal to 5 else returns the elements of input array*/
- (nonnull NSArray *)filterPlace:(nonnull NSArray *)places
                  aroundLatidude:(double)latitude
                    andLongitude:(double)longitude {
    NSArray *filteredPlaces;
  if(places.count >= 5){
        NSArray *result = [self sortAscendingUsingProximity:places fromLatidude: latitude andLongitude: longitude];
        filteredPlaces = [result subarrayWithRange:NSMakeRange(0, 5)];
    }else{
        filteredPlaces = [places copy];
    }
    return filteredPlaces;
}

/** Sorts the CrimePlace Array as per the closest distance to centre latitude and longitude in ascending order*/
- (NSArray *)sortAscendingUsingProximity:(NSArray *)places
                            fromLatidude:(double)latitude
                            andLongitude:(double)longitude{
    NSArray *sortedPlaces = [places sortedArrayUsingComparator:^NSComparisonResult(CrimePlace *first, CrimePlace *second) {
        CLLocationCoordinate2D centre = CLLocationCoordinate2DMake(latitude, longitude);
        CLLocationCoordinate2D location1 = CLLocationCoordinate2DMake(first.location.latitude, first.location.longitude);
        CLLocationCoordinate2D location2 = CLLocationCoordinate2DMake(second.location.latitude, second.location.longitude);
        
        CLLocationDistance distance1 = GMSGeometryDistance(centre, location1);
        CLLocationDistance distance2 = GMSGeometryDistance(centre, location2);
        
        return distance1 > distance2;
    }];
    return sortedPlaces;
}

- (nonnull NSString *)getName {
    return @"Proximity";
}

@end
