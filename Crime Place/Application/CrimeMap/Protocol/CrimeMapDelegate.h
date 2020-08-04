/**
CrimeMapDelegate is used to create a protocol for binding the View (ViewController) with our View Model (CrimeViewModel).
*/
//  CrimeMapDelegate.h
//  Crime Place
//
//  Created by Samip shah on 8/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CrimeMapDelegate <NSObject>

/**@param markers     NSArray of  GMSMarker. */
- (void)updateMarkers:(NSArray *)markers;
- (void)displayMarkerDetails:(NSString *)details;
- (void)displayAPIError:(NSString *)error;

/**  @param radius       Double value in Meters */
- (void)updateCircleRadius:(double)radius
                atLatitude:(double)latitude
              andLongitude:(double)longitude;
- (void)displayActivityIndicator:(BOOL)value;

@end

NS_ASSUME_NONNULL_END
