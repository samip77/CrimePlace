/**
    A Concrete Class implementing the @code LocationFilterProtocol.h @endCode for filtering the closest 5 @code CrimePlace.h @endCode from the Map's Centre  got from  @code ServiceAPI.h @endCode 
 */
//  ProximityFilter.h
//  Crime Place
//
//  Created by Samip shah on 9/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationFilterProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProximityFilter : NSObject <LocationFilterProtocol>

@end

NS_ASSUME_NONNULL_END
