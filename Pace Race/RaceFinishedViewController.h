//
//  RaceFinishedViewController.h
//  Pace Race
//
//  Created by Craig Hewitt on 9/28/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface RaceFinishedViewController : UIViewController
- (IBAction)postToFacebook:(id)sender;
- (IBAction)postToTwitter:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *runDistance;
@property (strong, nonatomic) IBOutlet UILabel *runTime;
@property (strong, nonatomic) IBOutlet UILabel *caloriesBurned;
@property (strong, nonatomic) IBOutlet UILabel *monthlyMileage;
@property (strong, nonatomic) IBOutlet UILabel *annualMileage;
@property (strong, nonatomic) IBOutlet UILabel *weeklyMileage;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
