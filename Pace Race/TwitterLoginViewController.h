//
//  TwitterLoginViewController.h
//  Pace Race
//
//  Created by Craig Hewitt on 9/11/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"


@interface TwitterLoginViewController : UIViewController
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

- (IBAction)TwitterDismissModal:(id)sender;

- (IBAction)loginUser:(id)sender;
- (IBAction)logoutUser:(id)sender;
- (IBAction)checkStatus:(id)sender;
@end
