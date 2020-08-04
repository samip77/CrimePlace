//
//  CrimeMapViewModel.m
//  Crime Place
//
//  Created by Samip shah on 6/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import "CrimeMapViewModel.h"
#import "APIService.h"
#import "LocationFilterProtocol.h"
#import "CrimePlace.h"
#import "Location.h"
#import "Street.h"

@implementation CrimeMapViewModel {
  APIService *apiService;
  double lat,lng;
  NSArray *crimePlaces;
  NSArray *filteredCrimePlaces;
}

/* Initializer with dependency of LocationFilterProtocol injected for initial filer logic.*/
- (instancetype)init:(id<LocationFilterProtocol>)filter {
  self = [super init];
  if (self) {
    _locationFilter = filter;
    apiService = [APIService sharedInstance];
  }
  return self;
}

/**Setter for LocationFilter when updated calls method to update the the filtered crimePlaces */
- (void)setLocationFilter:(id<LocationFilterProtocol>)locationFilter {
  _locationFilter  = locationFilter;
  [self setCrimePlaces:crimePlaces];
}

- (Boolean)checkIfCoordinateOne:(double)item1
      isAlmostNearToCoordinate2:(double)item2 {
  NSInteger value1 = (NSInteger)(item1 * MAP_DEGREE_TO_METER);
  NSInteger value2 = (NSInteger)(item2 * MAP_DEGREE_TO_METER);
  return (value1 == value2);
}

/**Recieves the centre coordinate of map and updates the lat and lng  and calls method to call API for new lat and lng. Early exit is created if the new location is nearly equal to  previous location and  crime places.*/
- (void)setMapCentreLatitude:(double)latitude
                andLongitude:(double)longitude {
  if([self checkIfCoordinateOne:latitude isAlmostNearToCoordinate2:lat] && [self checkIfCoordinateOne:longitude isAlmostNearToCoordinate2:lng]){
    return;
  }
  lat = latitude;
  lng = longitude;
  [self getPlacesFromLatitude:lat andLongitude:lng];
}

/**Decide the detail  information to be shown on the Marker modal dialog and provides to CrimeMapDelegateMethod*/
- (void)markerTapped:(GMSMarker *)marker {
  NSString *details = [marker.userData description];
  [_delegate displayMarkerDetails:details];
}

/**Updates the local crimeplaces from the parameter places and updates the filteredCrimePlaces with the Strategy Pattern using the Protocol method and updates the markers and circular radius of 1 mile around the centre location. */
- (void)setCrimePlaces:(NSArray *)places {
  crimePlaces = places;
  filteredCrimePlaces = [_locationFilter filterPlace:places aroundLatidude:lat andLongitude:lng];
  [self setMarkersFromCrimePlaces:filteredCrimePlaces];
  [self.delegate updateCircleRadius:(MAP_RADIUS_IN_MILE * MILE_TO_METERS) atLatitude:lat andLongitude:lng];
}

/**
 Used to get Crime places from APIService  near the input coordinate  and delegate inform the View using this View Model class to update its activity indicator correspondingly. Also, delegates the task of displaying API error to the CrimeMapDelegate.
 */
- (void)getPlacesFromLatitude:(double)latitude
                 andLongitude:(double)longitude {
  [_delegate displayActivityIndicator:YES];
  CrimeMapViewModel * __weak weakSelf = self;
  [apiService getCrimePlacesfromLatitute:latitude
                            andLongitude:longitude
                                  atDate:DEFAULT_DATE
                          withCompletion:^(NSArray * _Nonnull places, NSString * _Nonnull error) {
    if(error){
      [weakSelf.delegate displayAPIError:error.description];
    }else{
      [weakSelf setCrimePlaces:places];
    }
    [weakSelf.delegate displayActivityIndicator:false];
  }];
}

/**
 Creates GMSMarkers  from location coordinates from CrimePlace array which is later sent to ViewController using delegate  method.
 Multiple Markers could be at Same Coordinate so, the logic is implemented to rotate every other marker in same coordinate by multiple of  72 degree.
 @code marker.userData = place.description; @endCode  is used to pass the information location information that will later used to display crime detail in modal dialog.
 */
- (void)setMarkersFromCrimePlaces:(NSArray *)places {
  NSMutableArray *markers = [NSMutableArray new];
  NSMutableDictionary *markerRotation = [NSMutableDictionary new];
  
  for (CrimePlace *place in places) {
    
    GMSMarker *marker = [self createMarkerWithTitle:place.category andSnippet:place.placeId.stringValue fromLat:place.location.latitude andLng:place.location.longitude];
    marker.userData = place.description;
    marker.snippet = place.location.description;
    [markers addObject:marker];
    
    if([markerRotation.allKeys containsObject:place.location.street.streetId ]){
      NSNumber *count = markerRotation[place.location.street.streetId];
      int repeatCount = [count intValue] + 1 ;
      markerRotation[place.location.street.streetId] = [NSNumber numberWithInt:repeatCount];
      marker.rotation = repeatCount *72;
    }else{
      markerRotation[place.location.street.streetId] = [NSNumber numberWithInt:1];
    }
  }
  [_delegate updateMarkers:markers];
}

/** Creates GMSMarker with input parameters */
- (GMSMarker *)createMarkerWithTitle:(NSString *)title
                          andSnippet:(NSString *)snippet
                             fromLat:(double) lat
                              andLng:(double)lng{
  GMSMarker *marker = [[GMSMarker alloc] init];
  marker.position = CLLocationCoordinate2DMake(lat, lng);
  marker.title = title;
  marker.snippet = snippet;
  return marker;
}

@end
