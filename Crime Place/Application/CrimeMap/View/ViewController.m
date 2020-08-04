//
//  ViewController.m
//  Crime Place
//
//  Created by Samip shah on 6/5/20.
//  Copyright © 2020 Samip shah. All rights reserved.
//
#import <GoogleMaps/GoogleMaps.h>

#import "ViewController.h"
#import "UIViewController+Alert.h"
#import "CrimeMapViewModel.h"
#import "LocationFilterProtocol.h"
#import "IndexBasedFilter.h"
#import "ProximityFilter.h"
#import "AlertView.h"
#import "Constants.h"


@interface ViewController() {
  /** @code NSTimer *timer @endCode   is used to trigger API call after 3 seconds inactivity by user on Map.
   @code CrimeMapViewModel *viewModel @endCode is used to handle the business logic of the requirements so that ViewController have only the view related functionality and easy to maintain.
   s@code NSArray *filters; @endCode is supposed to be Array  of Filter Classes implementing the LocationFilterProtocol.
   */
  GMSMapView *mapView;
  GMSCircle *centreCircle;
  UIActivityIndicatorView *activityIndicator;
  NSTimer *timer;
  CrimeMapViewModel *viewModel;
  NSArray *filters;
  Boolean mapMovedByGuesture;
}

@end

@implementation ViewController

#pragma mark - ViewController LifeCycle

- (void)viewDidLoad {
  [super viewDidLoad];
  [self setupMapView];
  [self setupSegmentedControl];
  [self setupActivityIndicator];
  [self setupViewModel];
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];
  if(timer.valid){
    [timer invalidate];
  }
}

#pragma mark - Setup

/** Create and Add Map to view with default location of London and assign the delegate of Map to the ViewController*/
- (void)setupMapView {
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:DEFAULT_LATITUDE longitude:DEFAULT_LONGITUDE zoom:13];
  mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
  mapView.delegate = self;
  [self.view addSubview:mapView];
  [viewModel setMapCentreLatitude:camera.target.latitude andLongitude:camera.target.longitude];
  mapMovedByGuesture = YES;
}

- (void)setupActivityIndicator {
  activityIndicator = [[UIActivityIndicatorView alloc ] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
  activityIndicator.hidesWhenStopped = YES;
  activityIndicator.center = self.view.center;
  [self.view addSubview:activityIndicator];
}

/**Creates the segmented control from the filters array. In future if there will be any other type of filter for location, they can be just added to the array and there is no need to edit any code in viewModel*/
- (void)setupSegmentedControl {
  filters = [NSArray arrayWithObjects:[IndexBasedFilter new], [ProximityFilter new], nil];
  
  UISegmentedControl *filterControl = [[UISegmentedControl alloc]init];
  for (int index=0; index<filters.count; index++) {
    NSString *title  = [[filters objectAtIndex:index] getName];
    [filterControl insertSegmentWithTitle:title atIndex:index animated:NO];
  }
  [filterControl setSelectedSegmentIndex:0];
  [filterControl addTarget:self action:@selector(filterControlAction:) forControlEvents:UIControlEventValueChanged];
  [self setupConstraintFor:filterControl];
}

/**Add filterSegmentControl to bottom and centre horizontally*/
- (void)setupConstraintFor:(UISegmentedControl *)filterControl {
  [self.view addSubview:filterControl];
  
  filterControl.translatesAutoresizingMaskIntoConstraints = NO;
  NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:filterControl attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottomMargin multiplier:1 constant:-32];
  
  NSLayoutConstraint *midX = [NSLayoutConstraint constraintWithItem:filterControl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
  
  [self.view addConstraint:bottom];
  [self.view addConstraint:midX];
}

/**
 CrimeMapView model must be initialized with @code [[CrimeMapViewModel alloc] init:filters.firstObject]; @endCode  to setup the initial filter .
 self is assined as delegate to viewModel to update the viewcontroller with changes in data in viewModel.
 */
- (void)setupViewModel {
  viewModel = [[CrimeMapViewModel alloc] init:filters.firstObject];
  viewModel.delegate = self;
  [viewModel setMapCentreLatitude:DEFAULT_LATITUDE andLongitude:DEFAULT_LONGITUDE];
}

#pragma mark - Actions

/**Update viewModel with change in filter so that viewmodel could update its filter strategy and provide filtered data accordingly.*/
- (void)filterControlAction:(UISegmentedControl *) segment {
  [viewModel setLocationFilter:[filters objectAtIndex:segment.selectedSegmentIndex]];
  
}

- (void)createTimerWithUserInfo:(double)latitude and:(double)longitude {
  NSMutableDictionary *userInfo = [NSMutableDictionary new];
  [userInfo setValue:[NSNumber numberWithDouble:latitude] forKey:@"latitude"];
  [userInfo setValue:[NSNumber numberWithDouble:longitude] forKey:@"longitude"];
  
  [timer invalidate];
  timer = nil;
  timer = [NSTimer scheduledTimerWithTimeInterval: 3.0
                                           target: self
                                         selector:@selector(timerFired:)
                                         userInfo: userInfo repeats:NO];
}

- (void)timerFired:(NSTimer *)timer {
  NSDictionary *dict = timer.userInfo;
  double latitude = [[dict valueForKey:@"latitude"] doubleValue];
  double longitude = [[dict valueForKey:@"longitude"] doubleValue];
  [viewModel setMapCentreLatitude:latitude andLongitude:longitude];
}

#pragma mark - GMSMapViewDelegate
/**
 @Below Code displays custom view for marker detail
 @code
 [viewModel markerTapped:marker];
 return YES;
 @endCode
 Replace above code with code below to show  defualt popover dialog.
 @code
 return NO;
 @endCode
 */
- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
  [viewModel markerTapped:marker];
  return YES;
}

/**Track if last movement in map is due to gesture-pan or by system - clicking on marker*/
- (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture {
  mapMovedByGuesture = gesture;
}

/**this method gets called whenever the Map becomes idle after any user input or by system . It is used to get the central map coordinate and then create a timer which would later send the coordinate to view model to call places API for that coordinate, only when the movement in map was due to gesture by user. Benifit of this is when marker is clicked to see the detail info window , map re-centers itself with respect to marker postion which should not cause Place API to call. This if condition helps that way.*/
- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position {
  if (mapMovedByGuesture) {
    CLLocationCoordinate2D location = position.target;
    [self createTimerWithUserInfo:location.latitude and:location.longitude];
  }
}


#pragma mark - CrimeMapDelegate

/**useful to update view with any error revieced from viewModel and Retry setting map central coordinate in view model to recall the places API*/
- (void)displayAPIError:(nonnull NSString *)error {
  __weak typeof(self) weakSelf = self;
  [self displayAlert:error withActionMessage:@"Retry" onActionCompletion:^{
    __strong typeof(self) strongSelf = weakSelf;
    [self->viewModel setMapCentreLatitude:strongSelf->mapView.camera.target.latitude andLongitude:strongSelf->mapView.camera.target.longitude];
  }];
}

/**Display custom Alert Modal Dialog for Marker*/
- (void)displayMarkerDetails:(NSString *)details {
  AlertView *dialog = [AlertView loadFromNib];
  [dialog showAlertwithTitle:@"Crime Place" withSubtitle:details andButtonName:@"Close" onView:self.view];
}

/**This gets updated whenever viewModel  gets its filteredPlaces changed so that  view could update its marker as well. Previous marker are cleared before  putting new markers in map.*/
- (void)updateMarkers:(nonnull NSArray *)markers {
  [mapView clear];
  for (GMSMarker * marker in markers) {
    marker.appearAnimation = YES;
    marker.map = mapView;
  }
}

/**Used to Create a 1 mile GMS circle around the coordinate of the place which was used to call Places API*/
- (void)updateCircleRadius:(double)radius
                atLatitude:(double)latitude
              andLongitude:(double)longitude {
  CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
  centreCircle = [GMSCircle circleWithPosition:coordinate
                                        radius:radius];
  centreCircle.fillColor = [UIColor colorWithRed:0.0 green:0.7 blue:0 alpha:0.1];
  centreCircle.strokeColor = UIColor.redColor;
  centreCircle.strokeWidth = 5;
  centreCircle.map = mapView;
}

/**Used to display activity indicator when API is called and stop Animating the task is done.Its logic is handled by viewModel*/
- (void)displayActivityIndicator:(BOOL)value {
  if(value){
    [activityIndicator startAnimating];
  } else{
    [activityIndicator stopAnimating];
  }
}

@end
