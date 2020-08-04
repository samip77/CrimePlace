//
//  CrimePlace.m
//  Crime Place
//
//  Created by Samip shah on 6/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface CrimePlace : NSObject

    @property (nonatomic, strong) NSString *category;
    @property (nonatomic, strong) NSString *context;
    @property (nonatomic, strong) NSNumber *placeId;
    @property (nonatomic, strong) Location *location;
    @property (nonatomic, strong) NSString *locationSubtype;
    @property (nonatomic, strong) NSString *locationtype;
    @property (nonatomic, strong) NSString *month;
    @property (nonatomic, strong) NSString *outcomeStatus;
    @property (nonatomic, strong) NSString *persistentId;

@end
