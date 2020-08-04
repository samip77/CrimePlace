/**
   A Concrete Class implementing the @code LocationFilterProtocol.h @endCode for filtering the  top 5 indexed @code CrimePlace.h @endCode from    from  @code ServiceAPI.h @endCode
*/
//  IndexBasedFilter.h
//  Crime Place
//
//  Created by Samip shah on 9/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationFilterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface IndexBasedFilter : NSObject <LocationFilterProtocol>

@end

NS_ASSUME_NONNULL_END
