/** View Model for doing the business logic for the ViewController using MVVM Architecture.*/

//  CrimeMapViewModel.h
//  Crime Place
//
//  Created by Samip shah on 6/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "CrimeMapDelegate.h"
#import "LocationFilterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface CrimeMapViewModel : NSObject

@property (nonatomic, weak)id <CrimeMapDelegate> delegate;
@property (nonatomic, strong)id <LocationFilterProtocol> locationFilter;

- (void)setMapCentreLatitude:(double)latitude
                andLongitude:(double)longitude;
- (void)markerTapped:(GMSMarker *)marker;
- (instancetype)init:(id <LocationFilterProtocol>)filter;

@end

NS_ASSUME_NONNULL_END
