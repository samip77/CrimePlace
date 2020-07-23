//
//  AppDelegate+Map.m
//  Crime Place
//
//  Created by Samip shah on 6/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

#import "AppDelegate+Map.h"
#import <UIKit/UIKit.h>
#import "Define.h"
@import GoogleMaps;


@implementation AppDelegate (Map)

-(void) setupMap{
     [GMSServices provideAPIKey: MAP_API_KEY];
}

@end
