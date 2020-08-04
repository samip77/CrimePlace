/** Defines the constants used throughout the Application*/

//  Define.h
//  Crime Place
//
//  Created by Samip shah on 6/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const MAP_API_KEY = @"AIzaSyAGDWj5ySMT3ScrdExY_HTHeJtUGHT51xk";

/**
 @define MAP_RADIUS_IN_MILE
 @define MILE_TO_METERS
 Default value multiplied create the 1 Mile distance for creating the Circle Overlay on Map
 */
static const double MAP_RADIUS_IN_MILE = 1.0;
static const double MILE_TO_METERS = 1609.34;

static NSString * const BASE_URL = @"https://data.police.uk/api/crimes-street/all-crime";

/** default location as the the example for London */
static const double  DEFAULT_LATITUDE = 52.629729;
static const double  DEFAULT_LONGITUDE = -1.131592;
static NSString * const DEFAULT_DATE = @"2019-05";

/** Multiplier to used to multiply coordinate and convert them to interger inorder to check proximity. MAP_DEGREE_TO_METER  multiple is approximate only*/
static const int MAP_DEGREE_TO_METER  = 100000;
/**
 @see Accuracy versus decimal places at the equator
 decimal  degrees    distance
 places
 -------------------------------
 0        1.0        111 km
 1        0.1        11.1 km
 2        0.01       1.11 km
 3        0.001      111 m
 4        0.0001     11.1 m
 5        0.00001    1.11 m
 6        0.000001   0.111 m
 7        0.0000001  1.11 cm
 8        0.00000001 1.11 mm
 */
