//
//  NextRunViewController.h
//  Pace Race
//
//  Created by Craig Hewitt on 8/24/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@interface NextRunViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *nextRunLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;
@property (weak, nonatomic) IBOutlet UILabel *dateSelection;
@property (weak, nonatomic) IBOutlet UILabel *runDistanceLabel;

@property (strong, nonatomic) IBOutlet UITextField *runDistance;
- (IBAction)dismissNextRun:(id)sender;

@end
