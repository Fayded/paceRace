//
//  FacebookLoginViewController.h
//  Pace Race
//
//  Created by Craig Hewitt on 9/11/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMClient.h"
#import "SWRevealViewController.h"


@interface FacebookLoginViewController : UIViewController
- (IBAction)FBDismissModal:(id)sender;


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) SMClient *client;
@property (weak, nonatomic) IBOutlet UIButton *buttonLoginLogout;

- (IBAction)buttonClickHandler:(id)sender;
- (IBAction)checkStatus:(id)sender;

@end
