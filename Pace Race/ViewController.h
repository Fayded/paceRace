//
//  ViewController.h
//  Pace Race
//
//  Created by Craig Hewitt on 8/8/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (strong, nonatomic) IBOutlet UILabel *stopwatchLabel;
- (IBAction)onStartPressed:(id)sender;
- (IBAction)onStopPressed:(id)sender;

//CoreLocation delegate
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

//slider menu bar
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end

