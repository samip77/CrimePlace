/**
    Protocol for defining the filter for crime location in Map. Other class can implement this protocol to implement filter using strategy pattern.
    Concrete class using this protocol is used to create  the segmented control for the filter in ViewController.
 */
//  LocationFilterProtocol.h
//  Crime Place
//
//  Created by Samip shah on 9/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LocationFilterProtocol <NSObject>
/**
 @parameter latitude    Could be used to filter places as per the location.
    @parameter longitude    Could be used to filter places as per the location.
    @parameter places    NSArray  of  @code CrimePlace.h @endCode  which needs to be sorted and filtered.
    @result NSArray     Result of filter from Concrete class using this Protocol.
 */
- (nonnull NSArray *)filterPlace:(nonnull NSArray *)places
                  aroundLatidude:(double)latitude
                    andLongitude:(double)longitude;

/** @parameter  getName         Used in ViewController to give name to filter control segment */
- (NSString *)getName;

@end

NS_ASSUME_NONNULL_END
