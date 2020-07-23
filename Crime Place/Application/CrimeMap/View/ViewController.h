//
//  ViewController.h
//  Crime Place
//
//  Created by Samip shah on 6/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//

@import GoogleMaps;
#import <UIKit/UIKit.h>
#import "CrimeMapDelegate.h"

@interface ViewController : UIViewController <GMSMapViewDelegate,CrimeMapDelegate>


@end

