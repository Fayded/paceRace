//
//  LoginViewController.h
//  Pace Race
//
//  Created by Craig Hewitt on 8/24/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"

@class SMClient;
@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) SMClient *client;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

- (IBAction)createUser:(id)sender;
- (IBAction)login:(id)sender;
- (IBAction)checkStatus:(id)sender;
- (IBAction)logout:(id)sender;@end
