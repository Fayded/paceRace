//
//  MainViewController.m
//  Pace Race
//
//  Created by Craig Hewitt on 8/24/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import "MainViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"
#import "Todo.h"

@interface MainViewController ()
{
    BOOL running;
    NSTimeInterval secondsAlreadyRun;

}

@property (strong, nonatomic) NSTimer *stopWatchTimer; // Store the timer that fires after a certain time
@property (strong, nonatomic) NSDate *startDate; // Stores the date of the click on the start button *
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation MainViewController


- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    //CL Location Manager
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
    self.locationManager.delegate = self;
    self.location = [[CLLocation alloc] init];
  
    self.title = @"Race";
    
    // Change button color
    _sidebarButton.tintColor = [UIColor greenColor];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
   
    }

- (void) viewWillAppear:(BOOL)animated
{
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"StartRunTimer"];
    [self presentViewController:viewController animated:YES completion:nil];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self setMapView:nil];
    // Release any retained subviews of the main view.
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateTimer
{
    // Create date from the elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.startDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
   
    // Create a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    // Format the elapsed time and set it to the label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.stopwatchLabel.text = timeString;
}



- (void)viewDidAppear:(BOOL)animated  {
    self.startDate = [NSDate date];
    
    // Create the stop watch timer that fires every 10 ms
    self.stopWatchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];

}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if(!newLocation) return;
    
    if ((oldLocation.coordinate.latitude != newLocation.coordinate.latitude) &&
        (oldLocation.coordinate.longitude != newLocation.coordinate.longitude))
    {
        
        
        
        CLLocation *loc1 = [[CLLocation alloc] initWithLatitude:oldLocation.coordinate.latitude longitude:oldLocation.coordinate.longitude];
        CLLocation *loc2 = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];


        
        CLLocationDistance distance = ([loc2 distanceFromLocation:loc1]) * 0.000621371192;
        distanceCalculation = &distance;
        //distance = distance;
        NSLog(@"Total Distance %f in miles",distance);
    }
    
}
//CL updates method
- (void)locationManager:(SMLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // convert speed units - 1 meter per second = 26.8224 minutes per mile
    
    self.location = locations.lastObject;
    self.speed.text = [NSString stringWithFormat:@"%f", self.location.speed];
    self.distanceRun.text = [NSString stringWithFormat:@"%f", distanceCalculation];
    NSLog(@"location is %@", locations);
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MainViewController *transferViewController = segue.destinationViewController;

    if ([segue.identifier isEqualToString:@"soloRunSegue"]) {
       
    }
}
- (IBAction)pauseRunTimer:(id)sender {
    running = false;
    NSDate *pausedDate = [[NSDate alloc]init];
    secondsAlreadyRun += [[NSDate date] timeIntervalSinceDate:pausedDate];

    
    }

@end