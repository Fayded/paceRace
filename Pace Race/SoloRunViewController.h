//
//  SoloRunViewController.h
//  Pace Race
//
//  Created by Craig Hewitt on 9/28/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SMLocationManager.h"
#import <MapKit/MapKit.h>

@interface SoloRunViewController : UIViewController<MKMapViewDelegate>
{
    double *distanceCalculation;
    
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (strong, nonatomic) IBOutlet UILabel *speed;

@property (strong, nonatomic) IBOutlet UILabel *stopwatchLabel;
@property (strong, nonatomic) IBOutlet UILabel *distanceRun;
- (IBAction)stopRunButton:(id)sender;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;


//CoreLocation delegate
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

@end
