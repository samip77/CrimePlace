//
//  IndexBasedFilter.m
//  Crime Place
//
//  Created by Samip shah on 9/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import "IndexBasedFilter.h"

@implementation IndexBasedFilter 

/** @Result NSArray         Returns the first five element of the array if array count is greater than equal 5  else returns all element */
- (nonnull NSArray *)filterPlace:(nonnull NSArray *)places
                  aroundLatidude:(double) latitude
                    andLongitude:(double) longitude {
  NSArray *filteredPlaces = [NSArray new];
  
  if(places.count >= 5){
    filteredPlaces = [places subarrayWithRange:NSMakeRange(0, 5)];
  }else{
    filteredPlaces = [places copy];
  }
  return filteredPlaces;
}

- (nonnull NSString *)getName {
  return @"Index";
}

@end
