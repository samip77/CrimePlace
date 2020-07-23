//
//  Location.m
//  Crime Place
//
//  Created by Samip shah on 6/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Street.h"

@interface Location : NSObject
    @property (nonatomic) double latitude;
    @property (nonatomic) double longitude;
    @property (nonatomic, strong) Street *street;
@end

