//
//  AppDelegate+Map.m
//  Crime Place
//
//  Created by Samip shah on 6/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;

#import "AppDelegate+Map.h"
#import "Constants.h"



@implementation AppDelegate (Map)

- (void) setupMap {
     [GMSServices provideAPIKey: MAP_API_KEY];
}

@end
