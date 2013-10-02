//
//  MainViewController.h
//  Pace Race
//
//  Created by Craig Hewitt on 8/24/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SMLocationManager.h"
#import <MapKit/MapKit.h>


@interface MainViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (strong, nonatomic) IBOutlet UILabel *speed;

@property (strong, nonatomic) IBOutlet UILabel *stopwatchLabel;


//CoreLocation delegate
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end